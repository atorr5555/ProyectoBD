--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 17/06/2020
--@descripción: Creacion de cursores 2


Prompt Conectando como administrador:
connect fftv_proy_admin/admin 

Prompt Creando Cursor que obtenga el numero de licencias de cada propietario

set serveroutput on
declare
--declaración del cursor
cursor cur_propietario_licencias is
select p.nombre,p.apellido_paterno,p.email,l.inicio_vigencia,count(*) licencias
from propietario p,licencia l
where p.propietario_id=l.propietario_id
group by p.nombre,p.apellido_paterno,p.email,l.inicio_vigencia;
begin
dbms_output.put_line('resultados obtenidos');
dbms_output.put_line(
'Nombre Apellido emial inicio_vigencia #Licencias');
for r in cur_propietario_licencias loop
dbms_output.put_line(
r.nombre||' , '||r.apellido_paterno
||' , '||r.email
||' , '||r.inicio_vigencia||' , '||r.licencias);
end loop;
end;
/

Prompt Listo!.
disconnect;