--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Función que calcula el total de puntos negativos

set serveroutput on

create or replace function calcula_total_puntos(
	v_propietario_id number
) return number is
	v_total number;
begin
	v_total := 0;
	for r in (
		select *
		from puntos_negativos
		where propietario_id = v_propietario_id
	) loop
		v_total := v_total + r.cantidad;
	end loop;
	return v_total;
end;
/
show errors