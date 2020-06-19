--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 18/06/2020
--@Descripción: Prueba para la función que calcula puntos de prueba

set serveroutput on

Prompt =======================================
Prompt Prueba para la función que calcula el total de puntos
Prompt ========================================

declare
	v_propietario_id propietario.propietario_id%type;
	v_fecha date;
	v_esperado number;
	v_resultado number;
begin
	v_esperado := 0;

	select seq_propietario.nextval into v_propietario_id
	from dual;

	select sysdate into v_date
	from dual;

	insert into propietario(propietario_id, nombre, apellido_paterno,
		apellido_materno, email)
	values(v_propietario_id, 'Propietario', 'Para', 'Prueba',
		'prueba@prueba.com');
	
	v_date := add_months(v_date, -10);

	for i in 1 .. 10 loop
		v_esperado := v_esperado + i;
		insert into puntos_negativos(puntos_negativos_id, fecha, descripcion,
			cantidad, documento_evidencia, propietario_id)
		values(seq_puntos_negativos.nextval, add_months(v_date, i),
			'Infracción de prueba', i, empty_blob(), v_propietario_id);
	end loop;

	select calcula_total_puntos(v_propietario_id) into v_resultado
	from dual;

	if v_esperado = v_resultado then
		dbms_output.put_line('OK. Prueba Correcta');
	else
		dbms_output.put_line('ERROR. Prueba Incorrecta');
	end if;

end;
/