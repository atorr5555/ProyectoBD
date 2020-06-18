--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 16/06/2020
--@Descripción: Trigger para actualizar la lista de propietarios

set serveroutput on

create or replace trigger tr_historial_propietarios
  after insert or update of propietario_id on vehiculo
  for each row
begin
  case 
    when updating then
      -- Si el propietario es el mismo
      if :old.propietario_id = :new.propietario_id then
        raise_application_error(-20010, 'El propietario es el mismo');
      end if;
  end case;
  
  -- Insertando en historico propietario
  insert into historico_propietario(historico_propietario_id, inicio_periodo,
    propietario_id, vehiculo_id)
  values(seq_historico_propietario.nextval, sysdate,
    :new.propietario_id, :new.vehiculo_id);
end;
/
show errors