--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 20/06/2020
--@Descripción: Carga de datos de pagos anuales por vehiculo desde su registro

declare
	cursor cur_vehiculo is
		select vehiculo_id, fecha_status
		from vehiculo;
	v_fecha date;
	v_vehiculo_id number;
begin
	for r in cur_vehiculo loop
		v_fecha := r.fecha_status;
		v_vehiculo_id := r.vehiculo_id;
		while v_fecha <= sysdate loop
			insert into pago_cuota(folio, vehiculo_id, fecha_pago, importe)
			values(genera_folio_pago(v_vehiculo_id), v_vehiculo_id, v_fecha, 4000.00);
			v_fecha := add_months(v_fecha, 12);
		end loop;
	end loop;
end;
/