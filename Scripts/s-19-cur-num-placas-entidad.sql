--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 17/06/2020
--@descripción: Creacion de cursores 1

Prompt Conectando como administrador:
connect fftv_proy_admin/admin 

Prompt Creando Cursor que obtenga el pais y el numero de placas que tiene asociada la misma.

set serveroutput on
declare
--declaración del cursor
cursor cur_datos_entidad is
select e.clave,e.nombre,p.num_placa,p.fecha_asignacion,count(*) placas
from entidad e,placa p
where p.entidad_id=e.entidad_id
group by e.clave,e.nombre,p.num_placa,p.fecha_asignacion;
begin
dbms_output.put_line('resultados obtenidos');
dbms_output.put_line(
'Clave Nombre Num_placa Fecha #Placas');
for p in cur_datos_entidad loop
dbms_output.put_line(
p.clave||' , '||p.nombre
||' , '||p.num_placa
||' , '||p.fecha_asignacion||' , '||p.placas);
end loop;
end;
/

Prompt Listo!.
disconnect;