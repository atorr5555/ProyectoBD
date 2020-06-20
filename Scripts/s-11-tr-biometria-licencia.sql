--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 19/06/2020
--@Descripción: Inserción en biometría

set serveroutput on

create or replace trigger tr_biometria_licencia
  after insert on licencia
  for each row
begin
  insert into biometria(licencia_id, foto, firma, huella_izq, huella_der)
  values(:new.licencia_id, empty_blob(), empty_blob(), empty_blob(),
    empty_blob());
end;
/