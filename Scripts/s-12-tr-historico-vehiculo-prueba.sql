--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Pruebas para el trigger historico_vehiculo

set serveroutput on

Prompt Pruebas para el trigger historico_vehiculo
Prompt =======================================
Prompt Prueba 1.
prompt Insertando en vehículo
Prompt ========================================

declare
  v_modelo_id modelo.modelo_id%type;
  v_marca_id marca.marca_id%type;
  v_placa_id placa.placa_id%type;
  v_vehiculo_id vehiculo.vehiculo_id%type;
  v_propietario_id propietario.propietario_id%type;
  v_fecha date;
  v_count number;
begin
  -- Obteniendo modelo y marca
  select modelo_id, marca_id into v_modelo_id, v_marca_id
  from modelo
  where rownum = 1;

  -- Obteniendo placa
  select placa_id into v_placa_id
  from placa
  where fecha_asignacion is null
  and rownum = 1;

  -- Obteniendo propietario
  select propietario_id into v_propietario_id
  from propietario
  where rownum = 1;

  select sysdate into v_fecha
  from dual;

  select seq_vehiculo.nextval into v_vehiculo_id
  from dual;

  insert into vehiculo(vehiculo_id, anio, numero_serie, es_transporte_publico,
    es_carga, es_particular, num_serie_dispositivo, modelo_id, placa_id, propietario_id,
    status_vehiculo_id)
  values(v_vehiculo_id, to_char(v_fecha, 'yyyy'),
    concat(concat(v_marca_id,v_modelo_id), v_vehiculo_id), 0, 1, 0, '154996335',
    v_modelo_id, v_placa_id, v_propietario_id, 1);

  insert into carga(vehiculo_id, capacidad_toneladas)
  values(v_vehiculo_id, 5.2);

  select count(*) into v_count
  from historico_status_vehiculo
  where vehiculo_id = v_vehiculo_id
  and status_vehiculo_id = 1;

  if v_count = 1 then
    dbms_output.put_line('OK. Prueba 1 Correcta');
  else
    dbms_output.put_line('ERROR. Prueba 1 Incorrecta');
  end if;
end;
/

Prompt =======================================
Prompt Prueba 2.
prompt Actualizando propietario de vehículo
Prompt ========================================

declare
  v_count number;
  v_vehiculo_id vehiculo.vehiculo_id%type;
  v_status_vehiculo_id vehiculo.status_vehiculo_id%type;
  v_status_vehiculo_actual_id vehiculo.status_vehiculo_id%type;
begin
  -- Obteniendo status actual y vehiculo
  select vehiculo_id, status_vehiculo_id 
  into v_vehiculo_id, v_status_vehiculo_actual_id
  from vehiculo
  where rownum = 1;

  -- Obteniendo nuevo status
  select status_vehiculo_id into v_status_vehiculo_id
  from status_vehiculo
  where status_vehiculo_id != v_status_vehiculo_actual_id
  and rownum = 1;

  update vehiculo set status_vehiculo_id = v_status_vehiculo_id
  where vehiculo_id = v_vehiculo_id;

  select count(*) into v_count
  from historico_status_vehiculo
  where vehiculo_id = v_vehiculo_id
  and status_vehiculo_id = v_status_vehiculo_id
  and to_char(fecha_status, 'dd-mm-yyy') = to_char(sysdate, 'dd-mm-yyy');

  if v_count = 1 then
    dbms_output.put_line('OK. Prueba 2 Correcta');
  else
    dbms_output.put_line('ERROR. Prueba 2 Incorrecta');
  end if;
end;
/

Prompt =======================================
Prompt Prueba 3.
prompt Actualizando al mismo propietario
Prompt ========================================

declare
  v_count number;
  v_vehiculo_id vehiculo.vehiculo_id%type;
  v_status_vehiculo_actual_id vehiculo.status_vehiculo_id%type;
begin
  -- Obteniendo status actual y vehiculo
  select vehiculo_id, status_vehiculo_id 
  into v_vehiculo_id, v_status_vehiculo_actual_id
  from vehiculo
  where rownum = 1;

  update vehiculo set status_vehiculo_id = v_status_vehiculo_actual_id
  where vehiculo_id = v_vehiculo_id;

  dbms_output.put_line('ERROR. Prueba 3 Incorrecta');

  exception
    when others then
      if sqlcode = -20011 then
        dbms_output.put_line('OK. Prueba 3 Correcta');
      else
        dbms_output.put_line('ERROR. Prueba 3 Incorrecta');
      end if;
end;
/

rollback;