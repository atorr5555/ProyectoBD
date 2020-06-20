--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Prueba para el trigger para revisar el tipo de licencia

set serveroutput on

Prompt Prueba para el trigger para revisar el tipo de licencia
Prompt =======================================
Prompt Prueba 1.
prompt Insertando un transporte público de +20 personas con licencia inválida
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

  -- Obteniendo propietario
  select propietario_id into v_propietario_id
  from propietario
  where rownum = 1;

  -- Obteniendo vehiculo_id
  select seq_vehiculo.nextval into v_vehiculo_id
  from dual;

  -- Insertando en vehiculo de tipo transporte público
  insert into vehiculo(vehiculo_id, anio, numero_serie, es_transporte_publico,
    es_carga, es_particular, num_serie_dispositivo, modelo_id, placa_id,
		propietario_id, status_vehiculo_id)
  values(v_vehiculo_id, to_char(sysdate, 'yyyy'),
    concat(concat(v_marca_id,v_modelo_id), v_vehiculo_id), 1, 0, 0, '6665665656',
    v_modelo_id, v_placa_id, v_propietario_id, 1);
  
  insert into transporte_publico(vehiculo_id, num_pasajeros_sentados,
    num_pasajeros_parados, tipo_licencia_requerida_id)
  values(v_vehiculo_id, 15, 10, 1);

  dbms_output.put_line('ERROR. Prueba 1 Incorrecta. Se esperaba error.');

  exception
    when others then
      if sqlcode = -20012 then
        dbms_output.put_line('OK. Prueba 1 Correcta');
      else
        dbms_output.put_line('ERROR. Prueba 1 Incorrecta. Error incorrecto');
      end if;

end;
/

Prompt =======================================
Prompt Prueba 2.
prompt Insertando un transporte público con personas paradas y licencia A
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

  -- Obteniendo propietario
  select propietario_id into v_propietario_id
  from propietario
  where rownum = 1;

  -- Obteniendo vehiculo_id
  select seq_vehiculo.nextval into v_vehiculo_id
  from dual;

  -- Insertando en vehiculo de tipo transporte público
  insert into vehiculo(vehiculo_id, anio, numero_serie, es_transporte_publico,
    es_carga, es_particular, num_serie_dispositivo, modelo_id, placa_id, propietario_id,
    status_vehiculo_id)
  values(v_vehiculo_id, to_char(sysdate, 'yyyy'),
    genera_num_serie(v_modelo_id, v_vehiculo_id), 1, 0, 0, 
		v_modelo_id||v_vehiculo_id, v_modelo_id, v_placa_id, v_propietario_id, 1);
  
  insert into transporte_publico(vehiculo_id, num_pasajeros_sentados,
    num_pasajeros_parados, tipo_licencia_requerida_id)
  values(v_vehiculo_id, 5, 2, 1);

  dbms_output.put_line('ERROR. Prueba 2 Incorrecta. Se esperaba error');

  exception
    when others then
      if sqlcode = -20012 then
        dbms_output.put_line('OK. Prueba 2 Correcta');
      else
        dbms_output.put_line('ERROR. Prueba 2 Incorrecta. Error incorrecto');
      end if;
end;
/

Prompt =======================================
Prompt Prueba 3.
prompt Insertando con un propietario con licencia incorrecta
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
  select p.propietario_id into v_propietario_id
  from propietario p, licencia l, tipo_licencia t
  where p.propietario_id = l.propietario_id
  and l.tipo_licencia_id = t.tipo_licencia_id
  and t.clave = 'A'
  and rownum = 1;

  -- Obteniendo vehiculo_id
  select seq_vehiculo.nextval into v_vehiculo_id
  from dual;

  -- Insertando en vehiculo de tipo transporte público
  insert into vehiculo(vehiculo_id, anio, numero_serie, es_transporte_publico,
    es_carga, es_particular, num_serie_dispositivo, modelo_id, placa_id,
		propietario_id, status_vehiculo_id)
  values(v_vehiculo_id, to_char(sysdate, 'yyyy'),
    genera_num_serie(v_modelo_id,v_vehiculo_id), 1, 0, 0, 
		v_modelo_id||v_vehiculo_id, v_modelo_id, v_placa_id, v_propietario_id, 1);
  
  insert into transporte_publico(vehiculo_id, num_pasajeros_sentados,
    num_pasajeros_parados, tipo_licencia_requerida_id)
  values(v_vehiculo_id, 15, 10, 3);

  select count(*) into v_count
  from revision_licencia
  where vehiculo_id = v_vehiculo_id
  and propietario_id = v_propietario_id;

  if v_count = 1 then
    dbms_output.put_line('OK. Prueba 3 Correcta');
  else
    dbms_output.put_line('ERROR. Prueba 3 Incorrecta.'
                        ||'No se encontró el registro en revisión');
  end if;

end;
/

Prompt =======================================
Prompt Prueba 4.
prompt Insertando con un propietario correcto
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
  select p.propietario_id into v_propietario_id
  from propietario p, licencia l, tipo_licencia t
  where p.propietario_id = l.propietario_id
  and l.tipo_licencia_id = t.tipo_licencia_id
  and t.clave = 'C'
  and l.fin_vigencia > sysdate
  and rownum = 1;

  -- Obteniendo vehiculo_id
  select seq_vehiculo.nextval into v_vehiculo_id
  from dual;

  -- Insertando en vehiculo de tipo transporte público
  insert into vehiculo(vehiculo_id, anio, numero_serie, es_transporte_publico,
    es_carga, es_particular, num_serie_dispositivo, modelo_id, placa_id,
		propietario_id, status_vehiculo_id)
  values(v_vehiculo_id, to_char(sysdate, 'yyyy'),
    genera_num_serie(v_modelo_id, v_vehiculo_id), 1, 0, 0, 
		v_modelo_id||v_vehiculo_id, v_modelo_id, v_placa_id, v_propietario_id, 1);
  
  insert into transporte_publico(vehiculo_id, num_pasajeros_sentados,
    num_pasajeros_parados, tipo_licencia_requerida_id)
  values(v_vehiculo_id, 15, 10, 3);

  select count(*) into v_count
  from revision_licencia
  where vehiculo_id = v_vehiculo_id
  and propietario_id = v_propietario_id;

  if v_count = 0 then
    dbms_output.put_line('OK. Prueba 4 Correcta');
  else
    dbms_output.put_line('ERROR. Prueba 4 Incorrecta.'
                        ||'Se encontró un registro en revisión (no debería)');
  end if;

end;
/

rollback;