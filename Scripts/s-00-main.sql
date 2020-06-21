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
@s-11-tr-biometria-licencia.sql

Prompt **********************************
Prompt           Trigger no.2:
Prompt **********************************
@s-11-tr-historial-propietarios.sql

Prompt **********************************
Prompt           Trigger no.3:
Prompt **********************************
@s-11-tr-historico-vehiculo.sql

Prompt **********************************
Prompt           Trigger no.4:
Prompt **********************************
@s-11-tr-revisa-licencia.sql

Prompt **********************************
Prompt           Trigger no.5:
Prompt **********************************
@s-11-tr-revisa-placa.sql

Prompt **********************************
Prompt           Trigger no.6:
Prompt **********************************
@s-11-tr-valida-num-licencia.sql

Prompt **********************************
Prompt           Trigger no.7:
Prompt **********************************
@s-11-tr-genera-notificacion.sql

Prompt **********************************
Prompt        Prueba de Triggers:
Prompt **********************************
@s-12-tr-biometria-licencia-prueba.sql
@s-12-tr-historial-propietarios-prueba.sql
@s-12-tr-historico-vehiculo-prueba.sql
@s-12-tr-revisa-licencia-prueba.sql
@s-12-tr-revisa-placa-prueba.sql
@s-12-tr-valida-num-licencia-prueba.sql
@s-12-tr-genera-notificacion-prueba.sql

Prompt **********************************
Prompt     Creacion del Procedimiento 1:
Prompt **********************************
@s-13-p-registra-vehiculo.sql

Prompt **********************************
Prompt     Prueba del Procedimiento 1:
Prompt **********************************
@s-14-p-registra-vehiculo-prueba.sql

Prompt **********************************
Prompt     Creacion del Procedimiento 2:
Prompt **********************************
@s-13-p-reporte-num-vehiculos.sql

Prompt **********************************
Prompt     Prueba del Procedimiento 2:
Prompt **********************************
@s-14-p-reporte-num-vehiculos-prueba.sql

Prompt **********************************
Prompt     Creacion de funcion no.1:
Prompt **********************************
@s-15-fx-calcula-total-puntos.sql

Prompt **********************************
Prompt     Creacion de funcion no.2:
Prompt **********************************
@s-15-fx-genera-folio-pago.sql

Prompt **********************************
Prompt     Creacion de funcion no.3:
Prompt **********************************
@s-15-fx-genera-num-serie.sql

Prompt **********************************
Prompt     Creacion de funcion no.4:
Prompt **********************************
@s-15-fx-genera-num-notif.sql

Prompt **********************************
Prompt       Prueba de Funciones:
Prompt **********************************
@s-16-fx-calcula-total-puntos-prueba.sql
@s-16-fx-genera-folio-pago-prueba.sql

Prompt **********************************
Prompt         Uso de datos LOB:
Prompt **********************************
@s-17-lob-puntos-negativos.sql

Prompt **********************************
Prompt       Prueba de datos LOB:
Prompt **********************************
@s-18-lob-puntos-negativos-prueba.sql

Prompt **********************************
Prompt      Creacion de cursor(res):
Prompt **********************************
--@s-19-cur-num-placa-longitud-entidad
--@s-19-cur-propietario-tipo-licencia

Prompt **********************************
Prompt  Ejecutando script de resultados:
Prompt **********************************
connect FFTV_PROY_ADMIN/admin
@resultados-proyecto-final.sql

Prompt Prueba terminada exitosamente!.
disconnect;
