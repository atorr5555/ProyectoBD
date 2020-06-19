--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Función que genera número de serie

set serveroutput on

create or replace function genera_num_serie(
  v_modelo_id number,
  v_vehiculo_id number
) return varchar2 is
  v_str varchar2(40);
  v_marca_id number;
begin
  select marca_id into v_marca_id
  from modelo
  where modelo_id = v_modelo_id;

  v_str := concat(v_marca_id, v_modelo_id);
  v_str := v_str||'-'||v_vehiculo_id;
  return v_str;
end;
/
show errors