--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 1/06/2020
--@Descripción: Trigger para revisar la cantidad de licencias del propietario

set serveroutput on

create or replace trigger tr_valida_num_licencia
  before insert on licencia
  for each row
declare
  v_num_licencias number;
begin
  select count(*) into v_num_licencias
  from licencia
  where propietario_id = :new.propietario_id
  and fin_vigencia < sysdate
  and tipo_licencia_id = :new.tipo_licencia_id;
  
  -- Si hay una licencia, entonces ya no se puede insertar otra del mismo tipo
  if v_num_licencias > 0 then
    raise_application_error(-20020, 'Ya existe una licencia vigente de ese tipo');
  end if;
end;