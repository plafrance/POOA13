program TestConsignerErreur;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uniteConsigneur;

var
   unConsigneur : Consigneur;
begin
   unConsigneur := Consigneur.create;
   unConsigneur.consignerErreur('Charles J. Sykes', '640K ought to be enough for anybody');
   unConsigneur.destroy;
end.
