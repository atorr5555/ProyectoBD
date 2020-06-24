--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 17/06/2020
--@Descripción: Procedimiento para registrar vehículos

set serveroutput on

create or replace procedure sp_registra_vehiculo(
  p_vehiculo_id in out number,
  p_anio varchar2,
  p_es_transporte_publico number,
  p_es_carga number,
  p_es_particular number,
  p_num_serie_dispositivo number,
  p_modelo_id number,
  p_placa_id number,
  p_propietario_id number,
  p_num_bolsas_aire number default null,
  p_tiene_abs number default null,
  p_tipo_transmision varchar2 default null,
  p_capacidad_toneladas number default null,
  p_capacidad_m3 number default null,
  p_num_remolques number default null,
  p_num_pasajeros_sentados number default null,
  p_num_pasajeros_parados number default null,
  p_tipo_licencia_requerida_id number default null
) is
  v_fecha vehiculo.fecha_status%type;
  v_status_id vehiculo.status_vehiculo_id%type;
begin
  -- Revisando si el tipo es el correcto (también es revisado con un check)
  if p_es_carga = 0 and p_es_particular = 0 and p_es_transporte_publico = 0 then
    raise_application_error(-20029, 'Tipo inválido');
  end if;
  
  if p_es_carga = 1 and p_es_transporte_publico = 1 then
    raise_application_error(-20029, 'Tipo inválido');
  end if;

  if p_es_particular = 1 and p_es_transporte_publico = 1 then
    raise_application_error(-20029, 'Tipo inválido');
  end if;

  -- Revisando si hay argumentos completos para cada tipo
  if p_es_transporte_publico = 1 and (p_num_pasajeros_sentados is null 
  or p_num_pasajeros_parados is null 
  or p_tipo_licencia_requerida_id is null) then
    raise_application_error(-20030, 'Argumentos incompletos');
  end if;

  if p_es_carga = 1 and p_capacidad_toneladas is null then
    raise_application_error(-20030, 'Argumentos incompletos');
  end if;

  if p_es_particular = 1 and (p_num_bolsas_aire is null 
  or p_tiene_abs is null or p_tipo_transmision is null) then
    raise_application_error(-20030, 'Argumentos incompletos');
  end if;

  -- Obteniendo la fecha
  select sysdate into v_fecha
  from dual;
  v_status_id := 1;

  -- Generando el id del nuevo vehiculo
  select seq_vehiculo.nextval into p_vehiculo_id
  from dual;

  -- Insertando en el supertipo
  insert into vehiculo(vehiculo_id, anio, numero_serie, es_transporte_publico,
    es_carga, es_particular, num_serie_dispositivo, inicio_periodo,
    fecha_status, modelo_id, placa_id, propietario_id, status_vehiculo_id)
  values(p_vehiculo_id, p_anio, genera_num_serie(p_modelo_id, p_vehiculo_id),
    p_es_transporte_publico, p_es_carga, p_es_particular,
    p_num_serie_dispositivo, v_fecha, v_fecha, p_modelo_id, p_placa_id,
    p_propietario_id, 1);
  
  -- Insertando en los subtipos
  if p_es_particular = 1 then
    insert into particular(vehiculo_id, num_bolsas_aire, tiene_abs,
    tipo_transmision)
    values(p_vehiculo_id, p_num_bolsas_aire, p_tiene_abs, p_tipo_transmision);
  end if;

  if p_es_carga = 1 then
    insert into carga(vehiculo_id, capacidad_toneladas, capacidad_m3,
      num_remolques)
    values(p_vehiculo_id, p_capacidad_toneladas, p_capacidad_m3,
      p_num_remolques);
  end if;

  if p_es_transporte_publico = 1 then
    insert into transporte_publico(vehiculo_id, num_pasajeros_sentados,
      num_pasajeros_parados, tipo_licencia_requerida_id)
    values(p_vehiculo_id, p_num_pasajeros_sentados, p_num_pasajeros_parados,
      p_tipo_licencia_requerida_id);
  end if;

  -- Un trigger se encarga de insertar al histórico
end;
/
show errors