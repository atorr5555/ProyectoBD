--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 20/06/2020
--@Descripción: Carga de datos de mediciones cada 10 días desde registro

declare
	cursor cur_vehiculo is
		select fecha_status, vehiculo_id
		from vehiculo;
	v_fecha date;
	v_vehiculo_id number;
begin
	for r in cur_vehiculo loop
		v_fecha := r.fecha_status + 10;
		v_vehiculo_id := r.vehiculo_id;
		-- Por cada vehiculo llenar sus mediciones cada 10 días
		while v_fecha <= sysdate loop
			insert into registro_mediciones(registro_mediciones_id, hc, co, nox, co2,
				fecha, vehiculo_id)
			values(seq_registro_mediciones.nextval, trunc(dbms_random.value(30, 105)), 
				trunc(dbms_random.value(0,0.05), 3), trunc(dbms_random.value(0,3), 3),
				trunc(dbms_random.value(), 3), v_fecha,  v_vehiculo_id);
			v_fecha := v_fecha + 10;
		end loop;
	end loop;
end;
/