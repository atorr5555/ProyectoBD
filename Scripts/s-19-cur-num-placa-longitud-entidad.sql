--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 17/06/2020
--@descripción: Creacion de cursores 1

Prompt Conectando como administrador:
connect fftv_proy_admin/admin 
Prompt =============================================================================
Prompt Creando Cursor que obtenga la clave, nombre, fecha de asignacion
Prompt de aguascalientes cuya fecha de asignacion no sea nula y
Prompt cuyo numero de placa  asociado tengan una longitud de 16 empiecen con 3.
Prompt =============================================================================

set serveroutput on

declare
  --declaración del cursor
  cursor cur_datos_entidad is
    select e.clave,e.nombre,p.num_placa,p.fecha_asignacion,
    length(p.num_placa) tamano
    from entidad e,placa p
    where p.entidad_id=e.entidad_id 
    and e.clave='AGS' 
    and p.fecha_asignacion is not null
    group by e.clave,e.nombre,p.num_placa,p.fecha_asignacion
    having length(p.num_placa)=16 and instr(p.num_placa,'3')=1;
begin
  dbms_output.put_line('resultados obtenidos');
  dbms_output.put_line(
  'Clave      Nombre       Num_placa           Fecha    Longitud');
  for p in cur_datos_entidad loop
    dbms_output.put_line(
      p.clave||' , '||p.nombre
      ||' , '||p.num_placa
      ||' , '||p.fecha_asignacion||' , '||p.tamano);
  end loop;
end;
/

Prompt Listo!.
disconnect;