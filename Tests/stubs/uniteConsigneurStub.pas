unit uniteConsigneurStub;

interface

uses
  uniteConsigneur,SysUtils;

//Consigner des messages ou des erreurs
type
  ConsigneurStub = class(Consigneur)

    public
      constructor create( unRepertoireJournaux: String ); override;

      procedure consignerErreur(origine:String; message:String); override;

      procedure consigner(origine:String; message:String); override;

  end;

implementation

constructor ConsigneurStub.create( unRepertoireJournaux: String );
begin
end;

procedure ConsigneurStub.consignerErreur;
begin
end;

procedure ConsigneurStub.consigner;
begin
end;

end.
