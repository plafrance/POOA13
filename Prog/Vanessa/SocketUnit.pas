{
  Delphi Winsock 1.1 Library by Aphex
  http://iamaphex.cjb.net
  unremote@knology.net
}

unit SocketUnit;


interface

uses SysUtils, winsock;
 
type
   
  TClientSocket = class
  private 
    FAddress: pchar; 
    FData: pointer; 
    FTag: integer; 
    FConnected: boolean; 
    function GetLocalAddress: string;
    function GetLocalPort: integer; 
    function GetRemoteAddress: string; 
    function GetRemotePort: integer; 
  protected 
    FSocket: TSocket; 
  public 
    procedure Connect(Address: string; Port: integer);
    property Connected: boolean read FConnected; 
    property Data: pointer read FData write FData; 
    constructor Create; 
    destructor Destroy; override; 
    procedure Disconnect; 
    procedure Idle(Seconds: integer); 
    property LocalAddress: string read GetLocalAddress; 
    property LocalPort: integer read GetLocalPort; 
    function ReceiveBuffer(var Buffer; BufferSize: integer): integer; 
    function ReceiveLength: integer; 
    function ReceiveString: string; 
    property RemoteAddress: string read GetRemoteAddress; 
    property RemotePort: integer read GetRemotePort; 
    function SendBuffer(var Buffer; BufferSize: integer): integer; 
    function SendString(const Buffer: string): integer; 
    property Socket: TSocket read FSocket; 
    property Tag: integer read FTag write FTag; 
  end; 
 
  TServerSocket = class(TObject)
  private 
    FListening: boolean; 
    function GetLocalAddress: string; 
    function GetLocalPort: integer; 
  protected 
    FSocket: TSocket; 
  public 
    function Accept: TClientSocket; 
    constructor Create; 
    destructor Destroy; override; 
    procedure Disconnect; 
    procedure Idle; 
    procedure Listen(Port: integer); 
    property Listening: boolean read FListening; 
    property LocalAddress: string read GetLocalAddress; 
    property LocalPort: integer read GetLocalPort; 
  end; 
 
var 
  WSAData: TWSAData; 
 
implementation 
 
constructor TClientSocket.Create; 
begin 
  inherited Create; 
  WSAStartUp(257, WSAData);
end; 
 
procedure TClientSocket.Connect(Address: string; Port: integer); 
var 
  SockAddrIn: TSockAddrIn; 
  HostEnt: PHostEnt; 
begin 
  //Disconnect;
  FConnected := false;
  FAddress := pchar(Address); 
  FSocket := Winsock.socket(PF_INET, SOCK_STREAM, IPPROTO_TCP); 
  SockAddrIn.sin_family := AF_INET; 
  SockAddrIn.sin_port := htons(Port); 
  SockAddrIn.sin_addr.s_addr := inet_addr(FAddress); 
  if SockAddrIn.sin_addr.s_addr = INADDR_NONE then 
  begin
    HostEnt := gethostbyname(FAddress);
    if HostEnt = nil then 
    begin 
      raise Exception.create('Le serveur '+FAddress+' n''existe pas');
    end; 
    SockAddrIn.sin_addr.s_addr := Longint(PLongint(HostEnt^.h_addr_list^)^); 
  end;
  Winsock.Connect(FSocket, SockAddrIn, SizeOf(SockAddrIn));
  if winsock.WSAGetLastError <> 0 then
    raise Exception.create('Connexion impossible');

  FConnected := True; 
end; 
 
procedure TClientSocket.Disconnect; 
begin
  if closesocket(FSocket)= SOCKET_ERROR then
    raise Exception.create('Impossible de refermer la connexion.' );

  FConnected := False;
end; 
 
function TClientSocket.GetLocalAddress: string; 
var 
  SockAddrIn: TSockAddrIn; 
  Size: integer; 
begin 
  Size := sizeof(SockAddrIn); 
  getsockname(FSocket, SockAddrIn, Size); 
  Result := inet_ntoa(SockAddrIn.sin_addr); 
end;

function TClientSocket.GetLocalPort: integer; 
var 
  SockAddrIn: TSockAddrIn; 
  Size: Integer; 
begin 
  Size := sizeof(SockAddrIn); 
  getsockname(FSocket, SockAddrIn, Size); 
  Result := ntohs(SockAddrIn.sin_port); 
end; 
 
function TClientSocket.GetRemoteAddress: string; 
var 
  SockAddrIn: TSockAddrIn; 
  Size: Integer; 
begin 
  Size := sizeof(SockAddrIn); 
  getpeername(FSocket, SockAddrIn, Size); 
  Result := inet_ntoa(SockAddrIn.sin_addr); 
end; 
 
function TClientSocket.GetRemotePort: integer; 
var 
  SockAddrIn: TSockAddrIn; 
  Size: Integer; 
begin 
  Size := sizeof(SockAddrIn); 
  getpeername(FSocket, SockAddrIn, Size); 
  Result := ntohs(SockAddrIn.sin_port); 
end; 
 
procedure TClientSocket.Idle(Seconds: integer); 
var 
  FDset: TFDset; 
  TimeVal: TTimeVal; 
begin 
  if Seconds = 0 then 
  begin 
    FD_ZERO(FDSet); 
    FD_SET(FSocket, FDSet); 
    select(0, @FDset, nil, nil, nil); 
  end 
  else 
  begin 
    TimeVal.tv_sec := Seconds; 
    TimeVal.tv_usec := 0; 
    FD_ZERO(FDSet); 
    FD_SET(FSocket, FDSet); 
    select(0, @FDset, nil, nil, @TimeVal); 
  end; 
end; 
 
function TClientSocket.ReceiveLength: integer; 
begin 
  Result := ReceiveBuffer(pointer(nil)^, -1);
end;
 
function TClientSocket.ReceiveBuffer(var Buffer; BufferSize: integer): integer; 
begin 
  if BufferSize = -1 then 
  begin 
    if ioctlsocket(FSocket, FIONREAD, Longint(Result)) = SOCKET_ERROR then
    begin 
      Result := SOCKET_ERROR; 
      Disconnect; 
    end; 
  end 
  else 
  begin 
     Result := recv(FSocket, Buffer, BufferSize, 0); 
     if Result = 0 then 
     begin 
       Disconnect; 
     end; 
     if Result = SOCKET_ERROR then 
     begin 
       Result := WSAGetLastError; 
       if Result = WSAEWOULDBLOCK then 
       begin
         Result := 0;
       end
       else
       begin
         Disconnect;
         raise Exception.create('Impossible de lire sur le socket. Erreur : '+intToStr(result));
       end;
     end;
  end;
end;

function TClientSocket.ReceiveString: string;
begin
  SetLength(Result, ReceiveBuffer(pointer(nil)^, -1));
  SetLength(Result, ReceiveBuffer(pointer(Result)^, Length(Result)));
end;

function TClientSocket.SendBuffer(var Buffer; BufferSize: integer): integer;
var
  ErrorCode: integer;
begin
  Result := send(FSocket, Buffer, BufferSize, 0);
  if Result = SOCKET_ERROR then
  begin
    ErrorCode := WSAGetLastError;
    if (ErrorCode = WSAEWOULDBLOCK) then
    begin
      Result := -1;
    end
    else
    begin
      Disconnect;
      raise Exception.create('Impossible d''écrire sur le socket. Erreur : '+intToStr(ErrorCode));
    end;
  end;
end;

function TClientSocket.SendString(const Buffer: string): integer;
begin
  Result := SendBuffer(pointer(Buffer)^, Length(Buffer));
end;

destructor TClientSocket.Destroy;
begin
  inherited Destroy;
  if FConnected then Disconnect;
  WSACleanup;
end;

constructor TServerSocket.Create;
begin
  inherited Create;
  WSAStartUp(257, WSAData);
end;

procedure TServerSocket.Listen(Port: integer);
var
  SockAddrIn: TSockAddrIn;
begin
  Disconnect;
  FSocket := socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  SockAddrIn.sin_family := AF_INET;
  SockAddrIn.sin_addr.s_addr := INADDR_ANY;
  SockAddrIn.sin_port := htons(Port);
  bind(FSocket, SockAddrIn, sizeof(SockAddrIn));
  FListening := True;
  Winsock.listen(FSocket, 5); 
end; 
 
function TServerSocket.GetLocalAddress: string; 
var 
  SockAddrIn: TSockAddrIn; 
  Size: integer; 
begin 
  Size := sizeof(SockAddrIn); 
  getsockname(FSocket, SockAddrIn, Size); 
  Result := inet_ntoa(SockAddrIn.sin_addr); 
end; 
 
function TServerSocket.GetLocalPort: integer; 
var 
  SockAddrIn: TSockAddrIn; 
  Size: Integer; 
begin
  Size := sizeof(SockAddrIn);
  getsockname(FSocket, SockAddrIn, Size); 
  Result := ntohs(SockAddrIn.sin_port); 
end; 
 
procedure TServerSocket.Idle; 
var 
  FDset: TFDset; 
begin 
  FD_ZERO(FDSet); 
  FD_SET(FSocket, FDSet); 
  select(0, @FDset, nil, nil, nil); 
end; 
 
function TServerSocket.Accept: TClientSocket; 
var 
  Size: integer; 
  SockAddr: TSockAddr; 
begin 
  Result := TClientSocket.Create; 
  Size := sizeof(TSockAddr); 
  Result.FSocket := Winsock.accept(FSocket, @SockAddr, @Size);
  if Result.FSocket = INVALID_SOCKET then
    begin
      raise Exception.create('Cannot listen on designated port');
      Disconnect;
    end
  else
  begin 
    Result.FConnected := True; 
  end; 
end; 
 
procedure TServerSocket.Disconnect; 
begin 
  FListening := False; 
  closesocket(FSocket); 
end; 
 
destructor TServerSocket.Destroy; 
begin 
  inherited Destroy; 
  Disconnect; 
  WSACleanup; 
end; 
 
end.

