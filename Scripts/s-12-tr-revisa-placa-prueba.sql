--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Prueba para compound trigger

set serveroutput on

Prompt Prueba para el compound trigger de la asignación de placas
Prompt =======================================
Prompt Prueba 1.
prompt Asignando una placa inactiva
Prompt ========================================

declare
  v_placa_id placa.placa_id%type;
  v_vehiculo_id vehiculo.vehiculo_id%type;
begin
  -- Obteniendo una placa inactiva
  select placa_id into v_placa_id
  from placa
  where inactiva = 1
  and rownum = 1;

  -- Obteniendo vehículo para modificar la placa
  select vehiculo_id into v_vehiculo_id
  from vehiculo
  where rownum = 1;

  -- Asignando la placa inactiva
  update vehiculo set placa_id = v_placa_id
  where vehiculo_id = v_vehiculo_id;

  dbms_output.put_line('ERROR. Prueba 1 Incorrecta. Se esperaba error.');

  exception
    when others then
      if sqlcode = -20050 then
        dbms_output.put_line('OK. Prueba 1 Correcta');
      else
        dbms_output.put_line('ERROR. Prueba 1 Incorrecta. Código erróneo.');
				raise;
      end if;
end;
/

Prompt =======================================
Prompt Prueba 2.
prompt Asignando una placa válida
Prompt ========================================

declare
  v_placa_id placa.placa_id%type;
  v_vehiculo_id vehiculo.vehiculo_id%type;
  v_resultado number;
begin
  -- Obteniendo placa activa que no está en uso
  select p.placa_id into v_placa_id
  from placa p
  left join vehiculo v
  on p.placa_id = v.placa_id
  where v.placa_id is null
  and inactiva = 0
  and rownum = 1;

  -- Obteniendo vehículo para modificar la placa
  select vehiculo_id into v_vehiculo_id
  from vehiculo
  where rownum = 1;

  -- Asignando la placa
  update vehiculo set placa_id = v_placa_id
  where vehiculo_id = v_vehiculo_id;

  -- Revisando si se modificó la fecha de asignación
  select count(*) into v_resultado
  from placa
  where placa_id = v_placa_id
  and to_char(fecha_asignacion, 'dd-mm-yyyy') = to_char(sysdate, 'dd-mm-yyyy');

  if v_resultado = 1 then
    dbms_output.put_line('OK. Prueba 2 Correcta');
  else
    dbms_output.put_line('OK. Prueba 2 Incorrecta. No se encontró el registro');
  end if;
end;
/

rollback;