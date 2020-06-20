--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 19/06/2020
--@Descripción: Carga de datos de vehiculo, subtipos e históricos

declare
  cursor cur_placas is
    select * 
    from placas;
  v_max number;
  v_count number;
  v_num_modelos number;
  v_vehiculo_id number;
  v_modelo_id number;
  v_es_transporte number;
  v_es_carga number;
  v_es_particular number;
  v_abs number;
  v_tipo_trans char;
  v_fecha date;
begin
  select count(*) into v_max
  from propietario;

  v_count := 1;
  v_es_transporte := 0;
  v_es_carga := 0;
  v_es_particular := 0;

  select count(*) into v_num_modelos
  from modelo;

  select sysdate into v_fecha
  from dual;

  for r in cur_placas loop
    exit when v_count >= v_max;

    select seq_vehiculo.nextval into v_vehiculo_id
    from dual;

    v_modelo_id = dbms_random.value(1, v_num_modelos);

    if v_count < trunc(v_max/3) then
      v_es_transporte := 0;
      v_es_carga := 0;
      v_es_particular := 1;
    elsif v_count < trunc(2*v_max/3) then
      v_es_transporte := 0;
      v_es_carga := 1;
      v_es_particular := 0;
    else
      v_es_transporte := 1;
      v_es_carga := 0;
      v_es_particular := 0;
    end if;
    
    -- Insertando en supertipo
    insert into vehiculo(vehiculo_id, anio, numero_serie, es_transporte_publico,
      es_carga, es_particular, inicio_periodo, fecha_status,
      num_serie_dispositivo, modelo_id, placa_id, propietario_id,
      status_vehiculo_id)
    values(v_vehiculo_id, to_char(trunc(dbms_random.value(1960, 2020))),
      genera_num_serie(v_modelo_id, v_vehiculo_id),v_es_transporte, v_es_carga,
      v_es_particular, v_fecha, v_fecha, v_vehiculo_id+r.placa_id, v_modelo_id,
      r.placa_id, v_count, 1);
    
    -- Insertando en subtipos
    if v_es_transporte = 1 then
      insert into transporte_publico(vehiculo_id, num_pasajeros_sentados,
        num_pasajeros_parados, tipo_licencia_requerida_id)
      values(v_vehiculo_id, trunc(dbms_random.value(1,20)),
        trunc(dbms_random.value(1,20)), 3);
    end if;

    if v_es_carga = 1 then
      insert into carga(vehiculo_id, capacidad_toneladas)
      values(v_vehiculo_id, trunc(dbms_random.value(2,10)));
    end if;
    
    if v_es_particular = 1 then
      if dbms_random.value() > 0.5 then
        v_abs := 1;
        v_tipo_trans := 'A';
      else
        v_abs := 0;
        v_tipo_trans := 'M';
      end if;

      insert into particular(vehiculo_id, num_bolsas_aire, tiene_abs,
        tipo_transmision)
      values(v_vehiculo_id, trunc(dbms_random.value(1,5)), v_abs, v_tipo_trans);
    end if;

    -- Insertando en historico propietario
    insert into historico_propietario(historico_propietario_id, inicio_periodo,
      propietario_id, vehiculo_id)
    values(seq_historico_propietario.nextval, v_fecha, v_count, v_vehiculo_id);

    -- Insertando en historico status
    insert into historico_status_vehiculo(historico_status_vehiculo_id,
      fecha_status, vehiculo_id, status_vehiculo_id)
    values(seq_historico_status_vehiculo.nextval, v_fecha, v_vehiculo_id, 1);

    v_count := v_count + 1;
  end loop;
end;
/