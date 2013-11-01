program TestConsignerErreur;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uniteConsigneur;

var
   unConsigneur : Consigneur;
begin
   unConsigneur := Consigneur.create;
   unConsigneur.consignerErreur('2013-10-25 08:09:10', 'Charles J. Sykes', '640K ought to be enough for anybody');
   unConsigneur.destroy;
end.
