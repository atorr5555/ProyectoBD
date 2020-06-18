--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Prueba para trigger para revisar la cantidad de 
--              licencias del propietario

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
Prompt Insertando una licencia de tipo A a un propietario que ya tiene una vigente de ese tipo
Prompt ========================================

declare
  v_licencia_id licencia.licencia_id%type;
  v_propietario_id propietario.propietario_id%type;
begin
  -- Obteniendo al propietario
  select p.propietario_id into v_propietario_id
  from propietario p, licencia l
  where p.propietario_id = l.propietario_id
  and l.tipo_licencia_id = 1
  and l.fin_vigencia < sysdate
  and rownum = 1;

  insert into licencia(licencia_id, num_licencia, inicio_vigencia,
    fin_vigencia, propietario_id, tipo_licencia_id)
  values(seq_licencia.nextval, '123456763', sysdate, add_months(sysdate, 48),
    v_propietario_id, 1);

  dbms_output.put_line('ERROR. Prueba 1 Incorrecta. Se esperaba error.');

  exception
    when others then
      if sqlcode = -20020 then
        dbms_output.put_line('OK. Prueba 1 Correcta');
      else
        dbms_output.put_line('ERROR. Prueba 1 Incorrecta. Código incorrecto');
      end if;
end;
/

Prompt =======================================
Prompt Prueba 2.
Prompt Insertando una licencia de tipo B a un propietario que ya tiene una vigente de ese tipo
Prompt ========================================

declare
  v_licencia_id licencia.licencia_id%type;
  v_propietario_id propietario.propietario_id%type;
begin
  -- Obteniendo al propietario
  select p.propietario_id into v_propietario_id
  from propietario p, licencia l
  where p.propietario_id = l.propietario_id
  and l.tipo_licencia_id = 2
  and l.fin_vigencia < sysdate
  and rownum = 1;

  insert into licencia(licencia_id, num_licencia, inicio_vigencia,
    fin_vigencia, propietario_id, tipo_licencia_id)
  values(seq_licencia.nextval, '123456763', sysdate, add_months(sysdate, 48),
    v_propietario_id, 2);

  dbms_output.put_line('ERROR. Prueba 2 Incorrecta. Se esperaba error.');

  exception
    when others then
      if sqlcode = -20020 then
        dbms_output.put_line('OK. Prueba 2 Correcta');
      else
        dbms_output.put_line('ERROR. Prueba 2 Incorrecta. Código incorrecto');
      end if;
end;
/

Prompt =======================================
Prompt Prueba 3.
Prompt Insertando una licencia de tipo C a un propietario que ya tiene una vigente de ese tipo
Prompt ========================================

declare
  v_licencia_id licencia.licencia_id%type;
  v_propietario_id propietario.propietario_id%type;
begin
  -- Obteniendo al propietario
  select p.propietario_id into v_propietario_id
  from propietario p, licencia l
  where p.propietario_id = l.propietario_id
  and l.tipo_licencia_id = 3
  and l.fin_vigencia < sysdate
  and rownum = 1;

  insert into licencia(licencia_id, num_licencia, inicio_vigencia,
    fin_vigencia, propietario_id, tipo_licencia_id)
  values(seq_licencia.nextval, '123456763', sysdate, add_months(sysdate, 48),
    v_propietario_id, 3);

  dbms_output.put_line('ERROR. Prueba 3 Incorrecta. Se esperaba error.');

  exception
    when others then
      if sqlcode = -20020 then
        dbms_output.put_line('OK. Prueba 3 Correcta');
      else
        dbms_output.put_line('ERROR. Prueba 3 Incorrecta. Código incorrecto');
      end if;
end;
/

Prompt =======================================
Prompt Prueba 4.
Prompt Insertando una licencia de tipo A a un propietario que no tiene una vigente de ese tipo
Prompt ========================================

declare
  v_licencia_id licencia.licencia_id%type;
  v_propietario_id propietario.propietario_id%type;
begin
  -- Obteniendo al propietario
  select propietario_id into v_propietario_id
  from(
    select propietario_id
    from propietario
    minus
    select p.propietario
    from propietario p, licencia l
    where p.propietario_id = l.propietario_id
    and l.tipo_licencia_id = 1
    and l.fin_vigencia < sysdate
  )
  where rownum = 1;

  insert into licencia(licencia_id, num_licencia, inicio_vigencia,
    fin_vigencia, propietario_id, tipo_licencia_id)
  values(seq_licencia.nextval, '123456763', sysdate, add_months(sysdate, 48),
    v_propietario_id, 1);

  dbms_output.put_line('OK. Prueba 4 Correcta');
end;
/

rollback;