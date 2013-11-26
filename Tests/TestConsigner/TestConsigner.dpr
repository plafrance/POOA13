program TestConsigner;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uniteConsigneur;

var
   unConsigneur : Consigneur;
begin
   unConsigneur := Consigneur.create;
   unConsigneur.consigner('Oscar Wilde', 'Be warned in time, James, and remain, as I do, incomprehensible: to be great is to be misunderstood.');
   unConsigneur.destroy;
end.
