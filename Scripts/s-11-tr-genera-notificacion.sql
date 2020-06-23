--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 20/06/2020
--@Descripción: Trigger pare generar notificacion

create or replace trigger tr_genera_notificacion
	for insert on registro_mediciones
	compound trigger
-- Declaraciones globales
type inserciones is record (
	registro_mediciones_id registro_mediciones.registro_mediciones_id%type,
	vehiculo_id registro_mediciones.vehiculo_id%type,
	fecha registro_mediciones.fecha%type
);
-- Crea objeto tipo collection
type inserciones_list is table of inserciones; 

-- Crea una colección y la inicializa
insert_list inserciones_list := inserciones_list();

after each row is
	v_index number(10,0);
begin
	if :new.hc > 100 then
		insert_list.extend;
		v_index := 	insert_list.last;
		insert_list(v_index).registro_mediciones_id := :new.registro_mediciones_id;
		insert_list(v_index).vehiculo_id := :new.vehiculo_id;
		insert_list(v_index).fecha := :new.fecha;
	end if;
end after each row;

after statement is
	v_index number(10,0);
	v_status_id number;
begin
	v_index := insert_list.first;
	while v_index is not null loop
		insert into notificacion(notificacion_id, num_notificacion, fecha,
			registro_mediciones_id)
		values(seq_notificacion.nextval,
			genera_num_notif(insert_list(v_index).registro_mediciones_id),
			insert_list(v_index).fecha, insert_list(v_index).registro_mediciones_id);

		select status_vehiculo_id into v_status_id
		from vehiculo
		where vehiculo_id = insert_list(v_index).vehiculo_id;

		if v_status_id != 4 then
			update vehiculo set status_vehiculo_id = 4
			where vehiculo_id = insert_list(v_index).vehiculo_id;
		end if;
		v_index := insert_list.next(v_index);
	end loop;
end after statement;
end;
/
show errors