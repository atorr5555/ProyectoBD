--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Función que genera número de folio para los pagos

set serveroutput on

create or replace function genera_folio(
  v_vehiculo_id number
) return number is
  v_count number;
begin
  select count(*) into v_count
  from pago_cuota
  where vehiculo_id = v_vehiculo_id;

  v_count := v_count + 1;
  return v_count;
end;
/
show errors