--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 15/06/2020
--@Descripción: Prueba del script de archivos blob

Prompt Conectando como usuario Administrador..
connect fftv_proy_admin/admin
set serveroutput on
declare
v_nombre_directorio varchar2(30):='DATA_DIR';
v_puntos_negativos_id number(10,0);
v_fecha date :=to_date('1999-03-29','YYYY-MM-DD');
v_descripcion varchar2(30) := 'Multas aplicadas';
v_cantidad number(10,0) :=15;
v_nombre_documento_evidencia varchar2(100) :='multa.pdf';
v_propietario_id number(10,0):=1;
begin
dbms_output.put_line('Exportando datos de la tabla puntos negativos');
crea_puntos_negativos_blob(v_nombre_directorio, v_puntos_negativos_id,
  v_fecha, v_descripcion, v_cantidad, v_nombre_documento_evidencia, v_propietario_id);
--hace permanente el cambio
commit;
exception
when others then
dbms_output.put_line('Error al exportar, se hara rollback');
dbms_output.put_line(dbms_utility.format_error_backtrace);
rollback;
raise;
end;
/
show errors

Prompt Prueba completada!.
disconnect;