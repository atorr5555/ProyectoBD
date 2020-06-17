--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 16/06/2020
--@Descripción: Trigger para revisar el tipo de licencia

set serveroutput on

create or replace trigger tr_revisa_licencia
  before insert or update of tipo_licencia_requerida_id on transporte_publico
  for each row
declare
  v_propietario_id vehiculo.propietario_id%type;
  v_tipo_licencia_id tipo_licencia.tipo_licencia_id%type;
begin
  -- Revisa si hay una licencia que cumple con el tipo requerido
  for r in (
    select tipo_licencia_id
    from vehiculo v, propietario p, licencia l
    where v.propietario_id = p.propietario_id
    and p.propietario_id = l.propietario_id
    and v.vehiculo_id = :new.vehiculo_id
    and l.fin_vigencia < sysdate;
  ) loop
    if r.tipo_licencia_id = :new.tipo_licencia_requerida_id then
      return;
    end if;
  end loop;

  -- Obtener el id del propietario
  select propietario_id into v_propietario_id
  from vehiculo
  where vehiculo_id = :new.vehiculo_id;
  
  -- Insertar a una tabla de revisiones pendientes
  insert into revision_licencia(revision_licencia_id, vehiculo_id,
    propietario_id)
  values(seq_revision_licencia.nextval, :new.vehiculo_id, v_propietario_id);
end;
/
show errors