--@Autor: Flores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha de creación: 16/06/2020
--@descripción: Scrip master

--si ocurre un error, se hace rollback de los datos y
--se sale de SQL *Plus

whenever sqlerror exit rollback

Prompt conectando como usuario sys
connect sys/system as sysdba

set serveroutput on 

declare
  v_count number;
begin
  select count(*) into v_count
  from dba_users
  where username = 'FFTV_PROY_ADMIN';
  if v_count > 0  then
    dbms_output.put_line('Eliminando al usuario');
    execute immediate 'drop user FFTV_PROY_ADMIN cascade ';
  end if;
  select count(*) into v_count
  from dba_users
  where username = 'FFTV_PROY_INVITADO';
  if v_count > 0  then
    dbms_output.put_line('Eliminando al usuario');
    execute immediate 'drop user FFTV_PROY_INVITADO cascade ';
  end if;
end;
/
drop role rol_admin;
drop role rol_invitado;

Prompt **********************************
Prompt        Creando Usuarios:
Prompt **********************************
@s-01-usuarios.sql

Prompt **********************************
Prompt   Creando Entidades y Atributos:
Prompt **********************************
@s-02-entidades.sql

Prompt **********************************
Prompt   Creando tabla(s) temporal(es):
Prompt **********************************
@s-03-tablas-temporales.sql

Prompt **********************************
Prompt   Creando tabla(s) externa(s):
Prompt **********************************
@s-04-tablas-externas.sql

Prompt **********************************
Prompt        Creando Secuencias:
Prompt **********************************
@s-05-secuencias.sql

Prompt **********************************
Prompt       Creando Indices:
Prompt **********************************
@s-06-índices.sql

Prompt **********************************
Prompt        Creando Sinonimos:
Prompt **********************************
@s-07-sinonimos.sql

Prompt **********************************
Prompt          Creando Vistas:
Prompt **********************************
@s-08-vistas.sql
/*
Prompt **********************************
Prompt        Carga Inicial de datos
Prompt **********************************
@s-09-carga-inicial.sql

Prompt **********************************
Prompt        Consultas de datos:
Prompt **********************************
@s-10-consultas.sql

Prompt **********************************
Prompt           Trigger no.1:
Prompt **********************************


Prompt **********************************
Prompt           Trigger no.2:
Prompt **********************************


Prompt **********************************
Prompt        Prueba de Triggers:
Prompt **********************************


Prompt **********************************
Prompt     Creacion del Procedimiento:
Prompt **********************************


Prompt **********************************
Prompt     Prueba del Procedimiento:
Prompt **********************************


Prompt **********************************
Prompt     Creacion de funcion no.1:
Prompt **********************************


Prompt **********************************
Prompt     Creacion de funcion no.2:
Prompt **********************************


Prompt **********************************
Prompt       Prueba de Funciones:
Prompt **********************************


Prompt **********************************
Prompt         Uso de datos LOB:
Prompt **********************************


Prompt **********************************
Prompt       Prueba de datos LOB:
Prompt **********************************


Prompt **********************************
Prompt      Creacion de cursor(res):
Prompt **********************************


Prompt **********************************
Prompt      Prueba de cursor(res):
Prompt **********************************

Prompt **********************************
Prompt  Ejecutando script de resultados:
Prompt **********************************
@resultados-proyecto-final.sql

*/