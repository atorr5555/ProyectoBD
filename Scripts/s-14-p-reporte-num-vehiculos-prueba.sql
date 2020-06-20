--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Procedimiento para realizar un reporte

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
Prompt Prueba del procedimiento almacenado para el reporte de vehículos
Prompt ========================================

declare
  v_num_registros number;
  v_count number;
begin
  sp_reporte_num_vehiculos(v_num_registros);
  select count(*) into v_count
  from (
    select distinct anio
    from vehiculo
  );
  if v_count = v_num_registros then
    dbms_output.put_line('OK. Prueba 1 Correcta');
  else
    dbms_output.put_line('ERROR. Prueba 1 Incorrecta');
  end if;
end;
/

rollback;