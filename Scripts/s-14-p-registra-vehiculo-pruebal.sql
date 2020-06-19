--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción:  Pruebas procedimiento registrar vehículo

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
Prompt Insertando un vehiculo sin tipo (todas las banderas en 0)
Prompt ========================================

declare
  v_modelo_id modelo.modelo_id%type;
  v_marca_id marca.marca_id%type;
  v_placa_id placa.placa_id%type;
  v_vehiculo_id vehiculo.vehiculo_id%type;
  v_propietario_id propietario.propietario_id%type;
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
(
  -- Obteniendo propietario
  select propietario_id into v_propietario_id
  from propietario
  where rownum = 1;
  
  sp_registra_vehiculo(
    p_vehiculo_id => v_vehiculo_id,
    p_anio => to_char(sysdate, 'yyyy'),
    p_numero_serie => concat(concat(marca_id, modelo_id), placa_id),
    p_es_transporte_publico => 0,
    p_es_carga => 0,
    p_es_particular => 0,
    p_modelo_id => v_modelo_id,
    p_placa_id => v_placa_id,
    p_propietario_id  => v_propietario_id
  );

  dbms_output.put_line('ERROR. Prueba 1 Incorrecta. Se esperaba error');

  exception
    when others then
      if sqlcode = -20029 then
        dbms_output.put_line('OK. Prueba 1 Correcta');
      else
        dbms_output.put_line('ERROR. Prueba 1 Incorrecta. Código Incorrecto');
      end if;
end;
/

Prompt =======================================
Prompt Prueba 2.
Prompt Insertando un vehiculo con tipos incompletos
Prompt ========================================

declare
  v_modelo_id modelo.modelo_id%type;
  v_marca_id marca.marca_id%type;
  v_placa_id placa.placa_id%type;
  v_vehiculo_id vehiculo.vehiculo_id%type;
  v_propietario_id propietario.propietario_id%type;
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
(
  -- Obteniendo propietario
  select propietario_id into v_propietario_id
  from propietario
  where rownum = 1;
  
  sp_registra_vehiculo(
    p_vehiculo_id => v_vehiculo_id,
    p_anio => to_char(sysdate, 'yyyy'),
    p_numero_serie => concat(concat(marca_id, modelo_id), placa_id),
    p_es_transporte_publico => 0,
    p_es_carga => 0,
    p_es_particular => 1,
    p_modelo_id => v_modelo_id,
    p_placa_id => v_placa_id,
    p_propietario_id  => v_propietario_id
  );

  dbms_output.put_line('ERROR. Prueba 2 Incorrecta. Se esperaba error');

  exception
    when others then
      if sqlcode = -20030 then
        dbms_output.put_line('OK. Prueba 2 Correcta');
      else
        dbms_output.put_line('ERROR. Prueba 2 Incorrecta. Código incorrecto');
      end if;
end;
/

Prompt =======================================
Prompt Prueba 3.
Prompt Insertando un vehiculo con datos completos
Prompt ========================================

declare
  v_modelo_id modelo.modelo_id%type;
  v_marca_id marca.marca_id%type;
  v_placa_id placa.placa_id%type;
  v_vehiculo_id vehiculo.vehiculo_id%type;
  v_propietario_id propietario.propietario_id%type;
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
  
  sp_registra_vehiculo(
    p_vehiculo_id => v_vehiculo_id,
    p_anio => to_char(sysdate, 'yyyy'),
    p_numero_serie => concat(concat(marca_id, modelo_id), placa_id),
    p_es_transporte_publico => 0,
    p_es_carga => 0,
    p_es_particular => 1,
    p_modelo_id => v_modelo_id,
    p_placa_id => v_placa_id,
    p_propietario_id  => v_propietario_id,
    p_num_bolsas_aire => 4,
    p_tiene_abs => 1,
    p_tipo_transmision => 'A'
  );

  select count(*) into v_count
  from vehiculo
  where vehiculo_id = v_vehiculo_id;

  if v_count = 1 then
    dbms_output.put_line('OK. Prueba 3 Correcta');
  else
    dbms_output.put_line('ERROR. Prueba 3 Incorrecta.'
                        ||'No se encontró el registro');
  end if;
end;
/

rollback;