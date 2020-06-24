--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 20/06/2020
--@Descripción: Carga de verificaciones, una por cada notificación

set serveroutput on

declare
  cursor cur_notificacion is
    select registro_mediciones_id, fecha
    from notificacion;
  v_vehiculo_id number;
  v_verificacion_id number;
  v_fecha date;
begin
  for r in cur_notificacion loop
    select vehiculo_id into v_vehiculo_id
    from registro_mediciones
    where registro_mediciones_id = r.registro_mediciones_id;

    select seq_verificacion.nextval into v_verificacion_id
    from dual;

    v_fecha := r.fecha + trunc(dbms_random.value(1,5));

    insert into verificacion(verificacion_id, fecha_verificacion,
      folio_verificacion, vehiculo_id)
    values(v_verificacion_id, v_fecha, 
      v_verificacion_id||to_char(v_fecha, 'dd'),
      v_vehiculo_id);

    -- Por cada verificacion también se inserta una nueva medición
    insert into registro_mediciones(registro_mediciones_id, hc, co, nox, co2,
      fecha, vehiculo_id)
    values(seq_registro_mediciones.nextval, trunc(dbms_random.value(30, 100)), 
      trunc(dbms_random.value(0,0.05), 3), trunc(dbms_random.value(0,3), 3),
      trunc(dbms_random.value(), 3), v_fecha,  v_vehiculo_id);

    -- Vuelve a estado en regla
    insert into historico_status_vehiculo(historico_status_vehiculo_id,
      fecha_status, vehiculo_id, status_vehiculo_id)
    values(seq_historico_status_vehiculo.nextval, v_fecha, v_vehiculo_id, 1);
  end loop;
end;
/