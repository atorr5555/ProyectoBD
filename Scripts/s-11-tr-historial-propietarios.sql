--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 16/06/2020
--@Descripción: Trigger para actualizar la lista de propietarios

set serveroutput on

create or replace trigger tr_historial_propietarios
	before insert or update of propietario_id on vehiculo
	for each row
declare
	v_historico_propietario_id historico_propietario.historico_propietario_id%type;

begin
	case 
		when updating then
			-- Si el propietario es el mismo
			if :old.propietario_id = :new.propietario_id then
				raise_application_error(-20010, 'El cliente es el mismo');
			end if;

			-- Obteniendo el registro del histórico para completar el periodo
			select historico_propietario_id into v_historico_propietario_id
			from historico_propietario
			where propietario_id = :old.propietario_id
			and vehiculo_id = :old.vehiculo_id
			and inicio_periodo = :old.inicio_periodo;

			-- Se actualiza el registro del historial de propietarios
			update historico_propietario
			set fin_periodo = sysdate
			where historico_propietario_id = v_historico_propietario_id;
	end case;
	
	-- Insertando en historico propietario
	insert into historico_propietario(historico_propietario_id, inicio_periodo,
		propietario_id, vehiculo_id)
	values(seq_historico_propietario.nextval, :new.inicio_periodo,
		:new.propietario_id, :new.vehiculo_id);
end;
/
show errors