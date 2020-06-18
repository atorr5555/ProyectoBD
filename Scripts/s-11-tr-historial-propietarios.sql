--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 16/06/2020
--@Descripción: Trigger para actualizar la lista de propietarios

set serveroutput on

create or replace trigger tr_historial_propietarios
  after insert or update of propietario_id on vehiculo
  for each row
declare
	v_fecha date;
begin
  case 
    when updating then
      -- Si el propietario es el mismo
      if :old.propietario_id = :new.propietario_id then
        raise_application_error(-20010, 'El propietario es el mismo');
      end if;
  end case;

	-- Obteniendo fecha
	select sysdate into v_fecha
	from dual;
  
  -- Insertando en historico propietario
  insert into historico_propietario(historico_propietario_id, inicio_periodo,
    propietario_id, vehiculo_id)
  values(seq_historico_propietario.nextval, v_fecha,
    :new.propietario_id, :new.vehiculo_id);
	
	-- Actualizando fecha
	update vehiculo set inicio_periodo = v_fecha
	where vehiculo_id = :new.vehiculo_id;
end;
/
show errors