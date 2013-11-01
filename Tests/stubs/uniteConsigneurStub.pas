unit uniteConsigneurStub;

interface

uses
  uniteConsigneur,SysUtils;

//Consigner des messages ou des erreurs
type
  ConsigneurStub = class(Consigneur)

    public

      procedure consignerErreur(date:TDateTime;origine:String; message:String); override;

      procedure consigner(date:TDateTime;origine:String; message:String); override;

  end;

implementation

procedure Consigneur.consignerErreur(date:TDateTime;origine:String; message:String);
begin
end;

procedure Consigneur.consigner(date:TDateTime;origine:String; message:String);
begin
end;

end.
