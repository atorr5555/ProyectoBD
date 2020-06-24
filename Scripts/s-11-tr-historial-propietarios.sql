--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 16/06/2020
--@Descripción: Trigger para actualizar la lista de propietarios

set serveroutput on

create or replace trigger tr_historial_propietarios
  for insert or update of propietario_id on vehiculo
  compound trigger
  
before each row is
begin
  case 
    when updating('propietario_id') then
      if :old.propietario_id = :new.propietario_id then
         raise_application_error(-20010, 'El propietario es el mismo');
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
  
  -- Insertando en historico propietario
  insert into historico_propietario(historico_propietario_id, inicio_periodo,
    propietario_id, vehiculo_id)
  values(seq_historico_propietario.nextval, v_fecha,
    :new.propietario_id, :new.vehiculo_id);
end after each row;
end tr_historial_propietarios;
/
show errors