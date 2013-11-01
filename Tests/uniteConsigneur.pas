unit uniteConsigneur;
interface
uses SysUtils;
type
Consigneur = class
   public
      procedure consigner(uneDate, uneOrigine, unMessage : String);
      procedure consignerErreur(uneDate, uneOrigine, unMessage : String);
end;
implementation
   procedure Consigneur.consigner(uneDate, uneOrigine, unMessage : String);
   begin
//      writeln(uneDate, '[' + uneOrigine + '] : ', unMessage);
   end;
   procedure Consigneur.consignerErreur(uneDate, uneOrigine, unMessage : String);
   begin
//      writeln(uneDate, '[ERREUR - ' + uneOrigine + '] : ', unMessage);
   end;
end.
