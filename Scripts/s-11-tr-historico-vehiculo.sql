--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 16/06/2020
--@Descripción: Trigger para actualizar el histórico del vehículo

set serveroutput on

create or replace trigger tr_historico_vehiculo
  for insert or update of status_vehiculo_id on vehiculo
  compound trigger

before each row is
begin
  case
    when updating('status_vehiculo_id') then
      -- Si el status es el mismo
      if :old.status_vehiculo_id = :new.status_vehiculo_id then
        raise_application_error(-20011, 'El status es el mismo');
      end if;
    else
      dbms_output.put_line('');
  end case;
end before each row;

after each row is
  v_fecha date;
begin
  -- Obteniendo fecha
  select sysdate into v_fecha
  from dual;
  -- Insertando en histórico vehículo
  insert into historico_status_vehiculo(historico_status_vehiculo_id,
    fecha_status, vehiculo_id, status_vehiculo_id)
  values(seq_historico_status_vehiculo.nextval, v_fecha,
    :new.vehiculo_id, :new.status_vehiculo_id);
end after each row;
end tr_historico_vehiculo;
/
show errors