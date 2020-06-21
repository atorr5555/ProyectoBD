--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Función que genera número de notificacion

set serveroutput on

create or replace function genera_num_notif(
  v_registro_mediciones_id number
) return number is
  v_count number;
	v_vehiculo_id number;
begin
	select vehiculo_id into v_vehiculo_id
	from registro_mediciones
	where registro_mediciones_id = v_registro_mediciones_id;

	select count (*) into v_count
	from registro_mediciones r
	join notificacion n
	on r.registro_mediciones_id = n.registro_mediciones_id
	where r.vehiculo_id = v_vehiculo_id;

	v_count := v_count + 1;

	return v_count;
end;
/
show errors