--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 17/06/2020
--@descripción: Creacion de cursores 2


Prompt Conectando como administrador:
connect fftv_proy_admin/admin

Prompt ===============================================================================
Prompt Creando Cursor que obtenga el nombre, apellido paterno, e email
Prompt de todos los propietarios que no tengan RFC y cuyo tipo de licencia sea para taxi
Prompt ===============================================================================
set serveroutput on
declare
--declaración del cursor
cursor cur_propietario_licencias is
select p.nombre,p.apellido_paterno,p.email,l.inicio_vigencia,tl.clave
from propietario p,licencia l, tipo_licencia tl
where p.propietario_id=l.propietario_id and l.tipo_licencia_id=tl.tipo_licencia_id
and p.RFC is null and tl.clave='A';
begin
dbms_output.put_line('resultados obtenidos');
dbms_output.put_line(
'Nombre               Email      Inicio Vigencia  Clave Licencia');
for r in cur_propietario_licencias loop
dbms_output.put_line(
r.nombre||' '||r.apellido_paterno
||' , '||r.email
||' , '||r.inicio_vigencia||' , '||r.clave);
end loop;
end;
/

Prompt Listo!.
disconnect;