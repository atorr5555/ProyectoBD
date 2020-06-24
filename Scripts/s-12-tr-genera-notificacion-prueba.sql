--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 20/06/2020
--@Descripción: Prueba para trigger pare generar notificacion

set serveroutput on

Prompt Pruebas para el trigger genera_notificacion
Prompt =======================================
Prompt Prueba 1.
prompt Insertando registro con hc > 100
Prompt ========================================

declare
  v_vehiculo_id number;
  v_registro_mediciones_id number;
  v_count number;
  v_count2 number;
begin
  select vehiculo_id into v_vehiculo_id
  from vehiculo
  where rownum = 1;

  select seq_registro_mediciones.nextval into v_registro_mediciones_id
  from dual;

  insert into registro_mediciones(registro_mediciones_id, hc, co, nox, co2,
    fecha, vehiculo_id)
  values(v_registro_mediciones_id, 150, 0.2, 0.2, 0.2, sysdate, v_vehiculo_id);

  select count(*) into v_count
  from notificacion
  where registro_mediciones_id = v_registro_mediciones_id;

  select count(*) into v_count2
  from vehiculo
  where vehiculo_id = v_vehiculo_id
  and status_vehiculo_id = 4;

  if v_count = 1 and v_count2 = 1 then
    dbms_output.put_line('OK. Prueba 1 Correcta');
  else
    dbms_output.put_line('ERROR. Prueba 1 Inorrecta');
  end if;
end;
/

Prompt =======================================
Prompt Prueba 2.
prompt Insertando registro con hc < 100
Prompt ========================================

declare
  v_vehiculo_id number;
  v_registro_mediciones_id number;
  v_count number;
begin
  select vehiculo_id into v_vehiculo_id
  from vehiculo
  where rownum = 1;

  select seq_registro_mediciones.nextval into v_registro_mediciones_id
  from dual;

  insert into registro_mediciones(registro_mediciones_id, hc, co, nox, co2,
    fecha, vehiculo_id)
  values(v_registro_mediciones_id, 50, 0.2, 0.2, 0.2, sysdate, v_vehiculo_id);

  select count(*) into v_count
  from notificacion
  where registro_mediciones_id = v_registro_mediciones_id;

  if v_count = 0 then
    dbms_output.put_line('OK. Prueba 2 Correcta');
  else
    dbms_output.put_line('ERROR. Prueba 2 Inorrecta');
  end if;
end;
/

rollback;