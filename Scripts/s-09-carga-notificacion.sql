--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 20/06/2020
--@Descripción: Carga de notificaciones basada en mediciones

declare
	cursor cur_mediciones is
		select *
		from registro_mediciones;
	v_num_notificacion number;
begin
	for r in cur_mediciones loop
		if r.hc > 100 then
			insert into notificacion(notificacion_id, num_notificacion, fecha,
				registro_mediciones_id)
			values(seq_notificacion.nextval, genera_num_notif(r.registro_mediciones_id),
				r.fecha, r.registro_mediciones_id);
		end if;
	end loop;
end;
/