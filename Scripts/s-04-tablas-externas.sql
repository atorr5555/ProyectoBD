--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 16/06/2020
--@descripción: Creacion de tabla(s) externa(s)


prompt conectando como sys
connect sys/system as sysdba
--creando un objeto de tipo directory
prompt creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/Proy';
--dando permisos
grant read, write on directory tmp_dir to fftv_proy_admin;
connect fftv_proy_admin/admin
prompt creando tabla externa
-- Tabla que contiene los vehiculos antiguos que no se guardan en la base
create table vehiculos_antiguos(
  vehiculo_id number(10,0) null,
  num_serie   varchar2(40) null,
  placa_id    number(10,0) null
)
organization external(
  type oracle_loader
  default directory tmp_dir
  access parameters(
    records delimited by newline
    badfile tmp_dir:'vehiculos_antiguos_bad.log'
    logfile tmp_dir:'vehiculos_antiguos.log'
    fields terminated by '#'
    lrtrim
    missing field values are null
    (
      vehiculo_id,num_serie,placa_id
    )
  )
  location('vehiculos_antiguos.csv')
)
reject limit unlimited;


prompt creando el directorio /tmp/Proy en caso de no existir
!mkdir -p /tmp/Proy
!chmod 777 /tmp/Proy
!cp vehiculos_antiguos.csv /tmp/Proy
prompt probando mostrar los datos
select * from vehiculos_antiguos;

prompt Listo!.
disconnect;