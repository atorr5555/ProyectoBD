--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 19/06/2020
--@Descripción: Carga de licencias

declare
  cursor cur_propietarios is
    select *
    from propietario;
  v_fecha date;
  v_tipo_licencia_id number;
  v_es_transporte number;
  v_licencia_id number;
begin
  for r in cur_propietarios loop

    select seq_licencia.nextval into v_licencia_id
    from dual;

    select sysdate into v_fecha
    from dual;

    select es_transporte_publico into v_es_transporte
    from vehiculo
    where propietario_id = r.propietario_id;

    if v_es_transporte != 1 then
			if dbms_random.value() > 0.5  then
				v_tipo_licencia_id := 1;
			else
				v_tipo_licencia_id := 2;
			end if;
    else
      v_tipo_licencia_id := 3;
    end if;

    -- Insertando en licencia
    insert into licencia(licencia_id, num_licencia, inicio_vigencia,
      fin_vigencia, propietario_id, tipo_licencia_id)
    values(v_licencia_id, r.propietario_id||v_licencia_id, v_fecha,
      add_months(v_fecha, 48), r.propietario_id, v_tipo_licencia_id);
  
    -- Insertando en biometria de la licencia
    insert into biometria(licencia_id, foto, firma, huella_izq, huella_der)
    values(v_licencia_id, empty_blob(), empty_blob(), empty_blob(),
      empty_blob());
  end loop;
end;
/