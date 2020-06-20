--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 19/06/2020
--@Descripción: Prueba para trigger de inserción en biometría

set serveroutput on

Prompt Pruebas para el trigger biometria_licencia
Prompt =======================================
Prompt Prueba 1.
prompt Insertando en licencia
Prompt ========================================

declare
  v_licencia_id number;
  v_propietario_id number;
  v_fecha date;
  v_count number;
begin

  select seq_propietario.nextval into v_propietario_id
  from dual;

  select seq_licencia.nextval into v_licencia_id
  from dual;

  select sysdate into v_fecha
  from dual;

  insert into propietario (propietario_id, nombre, apellido_paterno,
    apellido_materno, rfc, email)
  values (v_propietario_id, 'Rolf', 'Botger', 'Pimm', null,
    'rpimm0@indiegogo.com');

  insert into licencia(licencia_id, num_licencia, inicio_vigencia,
    fin_vigencia, propietario_id, tipo_licencia_id)
  values(v_licencia_id, v_propietario_id+v_licencia_id, v_fecha,
    add_months(v_fecha, 48), v_propietario_id, 1);	
  
  select count(*) into v_count
  from biometria
  where licencia_id = v_licencia_id;

  if v_count = 1 then
    dbms_output.put_line('OK. Prueba Correcta');
  else
    dbms_output.put_line('ERROR. Prueba Incorrecta. No se encontró el registro');
  end if;
end;
/

rollback;