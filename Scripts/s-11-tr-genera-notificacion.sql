--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 20/06/2020
--@Descripción: Trigger pare generar notificacion

create or replace trigger tr_genera_notificacion
	after insert on registro_mediciones
	for each row
declare
	v_status_id number;
begin
	if :new.hc > 100 then
		insert into notificacion(notificacion_id, num_notificacion, fecha,
			registro_mediciones_id)
		values(seq_notificacion.nextval,
			genera_num_notif(:new.registro_mediciones_id), :new.fecha,
			:new.registro_mediciones_id);

		select status_vehiculo_id into v_status_id
		from vehiculo
		where vehiculo_id = :new.vehiculo_id;

		if v_status_id != 4 then
			update vehiculo set status_vehiculo_id = 4
			where vehiculo_id = :new.vehiculo_id;
		end if;
	end if;	
end;
/
show errors