--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Prueba para función genera_folio_pago

set serveroutput on

Prompt =======================================
Prompt Prueba para la función genera folio pago
Prompt ========================================

declare
  v_resultado number;
  v_vehiculo_id number;
  v_esperado number;
begin
  select vehiculo_id into v_vehiculo_id
  from vehiculo
  where rownum = 1;

  select count(*) into v_esperado
  from pago_cuota
  where vehiculo_id = v_vehiculo_id;

  v_esperado := v_esperado + 1;

  select genera_folio(v_vehiculo_id) into v_resultado
  from dual;

  if v_esperado = v_resultado then
    dbms_output.put_line('OK. Prueba Correcta');
  else
    dbms_output.put_line('ERROR. Prueba Incorrecta');
  end if;

end;
/