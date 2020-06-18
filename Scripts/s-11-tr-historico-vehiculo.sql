--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 16/06/2020
--@Descripción: Trigger para actualizar el histórico del vehículo

set serveroutput on

create or replace trigger tr_historico_vehiculo
  after insert or update of status_vehiculo_id on vehiculo
  for each row
begin
  case 
    when updating then
      -- Si el status es el mismo
      if :old.status_vehiculo_id = :new.status_vehiculo_id then
        raise_application_error(-20011, 'El status es el mismo');
      end if;
  end;

  -- Insertando en histórico vehículo
  insert into historico_status_vehiculo(historico_status_vehiculo_id,
    fecha_status, vehiculo_id, status_vehiculo_id)
  values(seq_historico_status_vehiculo.nextval, sysdate,
    :new.vehiculo_id, :new.status_vehiculo_id);
end;
/
show errors