--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Compound trigger para asignación de placas

set serveroutput on

create or replace trigger tr_revisa_placa
  for insert or update of placa_id on vehiculo
  compound trigger

before each row is
  v_placa_inactiva number;
begin
  -- Revisando si la placa ya está marcada como inactiva
  select inactiva into v_placa_inactiva
  from placa
  where placa_id = :new.placa_id;

  if v_placa_inactiva = 1 then
    raise_application_error(-20050, 'La placa es inactiva');
  end if;
end before each row;

after each row is
begin
  update placa 
  set fecha_asignacion = sysdate
  where placa_id = :new.placa_id;
end after each row;

end tr_revisa_placa;
/