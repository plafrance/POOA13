unit uniteConsigneurStub;

interface

uses
  uniteConsigneur,SysUtils;

//Consigner des messages ou des erreurs
type
  ConsigneurStub = class(Consigneur)

    public

      procedure consignerErreur(origine:String; message:String); override;

      procedure consigner(origine:String; message:String); override;

  end;

implementation

procedure ConsigneurStub.consignerErreur;
begin
end;

procedure ConsigneurStub.consigner;
begin
end;

end.
