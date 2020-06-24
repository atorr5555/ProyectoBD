--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 20/06/2020
--@Descripción: Carga de notificaciones basada en mediciones

set serveroutput on

declare
  cursor cur_fechas is
    select vehiculo_id, max(fecha_status) as fecha
    from historico_status_vehiculo
    group by vehiculo_id;
begin
  for r in cur_fechas loop
    update vehiculo set fecha_status = r.fecha
    where vehiculo_id = r.vehiculo_id;
  end loop;
end;
/
