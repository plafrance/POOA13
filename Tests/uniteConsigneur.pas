unit uniteConsigneur;
interface
uses SysUtils;
type
Consigneur = class
   public
      procedure consigner(uneOrigine, unMessage : String); virtual;
      procedure consignerErreur(uneOrigine, unMessage : String); virtual;
end;
implementation
   procedure Consigneur.consigner(uneOrigine, unMessage : String);
   begin
//      writeln(uneDate, '[' + uneOrigine + '] : ', unMessage);
   end;
   procedure Consigneur.consignerErreur(uneOrigine, unMessage : String);
   begin
//      writeln(uneDate, '[ERREUR - ' + uneOrigine + '] : ', unMessage);
   end;
end.
