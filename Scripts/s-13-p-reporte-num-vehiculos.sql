--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Procedimiento para realizar un reporte

set serveroutput on

create or replace procedure sp_reporte_num_vehiculos(
  p_num_registros in out number
) is
  v_count number;
  cursor cur_reporte is
    select v.anio, count(*) as total_vehiculos,
      q1.num_carga, q2.num_particular
    from vehiculo v, (
      select v.anio, count(c.vehiculo_id) as num_carga
      from vehiculo v, carga c
      where v.vehiculo_id = c.vehiculo_id(+)
      group by v.anio
    ) q1, (
      select v.anio, count(p.vehiculo_id) as num_particular
      from vehiculo v, particular p
      where v.vehiculo_id = p.vehiculo_id(+)
      group by v.anio
    ) q2
    where v.anio = q1.anio
    and v.anio = q2.anio
    group by v.anio, q1.num_carga, q2.num_particular;
begin
  v_count := 0;
  for r in cur_reporte loop
    insert into tabla_temporal_vehiculo(anio, numero_autos, numero_autos_carga,
      numero_autos_particulares)
    values(r.anio, r.total_vehiculos, r.num_carga, r.num_particular);
    v_count := v_count + 1;
  end loop;
  p_num_registros := v_count;
end;
/