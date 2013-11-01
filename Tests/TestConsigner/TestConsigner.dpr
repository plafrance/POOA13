program TestConsigner;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uniteConsigneur;

var
   unConsigneur : Consigneur;
begin
   unConsigneur := Consigneur.create;
   unConsigneur.consigner('2013-10-25 08:09:10', 'Oscar Wilde', 'Be warned in time, James, and remain, as I do, incomprehensible: to be great is to be misunderstood.');
   unConsigneur.destroy;
end.
