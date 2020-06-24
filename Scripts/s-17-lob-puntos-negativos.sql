--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 15/06/2020
--@Descripción: Uso de datos tipo BLOB

set serveroutput on

Prompt conectando como usuario sys
connect sys/system as sysdba
Prompt ========================================================================
Prompt Creando prodecimiento para insertar datos tipo BLOB en puntos negativos
Prompt ========================================================================

create or replace directory data_dir as '/tmp/data_dir';
grant read,write on directory data_dir to FFTV_PROY_ADMIN;
!mkdir -p /tmp/data_dir
!chmod 777 /tmp/data_dir
!cp multa.pdf /tmp/data_dir

Prompt Conectando como usuario Administrador..
connect fftv_proy_admin/admin

create or replace procedure crea_puntos_negativos_blob(
  p_nombre_directorio in varchar2,
  p_puntos_negativos_id out number,
  p_fecha in date, 
  p_descripcion in varchar2, 
  p_cantidad in number, 
  p_nombre_documento_evidencia in varchar2,
  p_propietario_id in number
) is
  v_bfile bfile;
  v_src_offset number := 1;
  v_dest_offset number:= 1;
  v_dest_blob blob;
  v_src_length number;
  v_dest_length number;
begin
  v_bfile := bfilename(upper(p_nombre_directorio),p_nombre_documento_evidencia);
  if dbms_lob.fileexists(v_bfile) = 1 and not
    dbms_lob.isopen(v_bfile) = 1 then
    dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
  else
    raise_application_error(-20001,'El archivo '
    ||p_nombre_documento_evidencia
    ||' no existe en el directorio '
    ||p_nombre_directorio
    ||' o el archivo esta abierto');
  end if;

  select seq_puntos_negativos.nextval into p_puntos_negativos_id
  from dual;

  insert into puntos_negativos(puntos_negativos_id,fecha,descripcion,
    cantidad,documento_evidencia,propietario_id )
  values(p_puntos_negativos_id,p_fecha,p_descripcion, 
    p_cantidad,empty_blob(),p_propietario_id);

  select documento_evidencia into v_dest_blob
  from puntos_negativos
  where puntos_negativos_id=p_puntos_negativos_id;

  dbms_lob.loadblobfromfile(
    dest_lob => v_dest_blob,
    src_bfile => v_bfile,
    amount => dbms_lob.getlength(v_bfile),
    dest_offset => v_dest_offset,
    src_offset => v_src_offset
  );
  dbms_lob.close(v_bfile);
  v_src_length := dbms_lob.getlength(v_bfile);
  v_dest_length := dbms_lob.getlength(v_dest_blob);
  if v_src_length = v_dest_length then
    dbms_output.put_line('Escritura correcta, bytes escritos: '
    || v_src_length);
  else
    raise_application_error(-20002,'Error al escribir datos.\n'
    ||' Se esperaba escribir '||v_src_length
    ||' Pero solo se escribio '||v_dest_length);
  end if;
end;
/
show errors

Prompt Creacion de procedimiento blob completado!.
disconnect;