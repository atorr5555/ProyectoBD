--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 16/06/2020
--@descripción: Creacion de secuencias necesarias en la bd

Prompt Conectando como administrador:
connect fftv_proy_admin/admin 

Prompt creando secuencias:

create sequence seq_entidad
  start with 1
  increment by 1
  maxvalue 5000
  nocycle
  order;

create sequence seq_placa
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;

create sequence seq_marca
  start with 1
  increment by 1
  maxvalue 100000
  nocycle
  order;

create sequence seq_modelo
  start with 1
  increment by 1
  maxvalue 100000
  nocycle
  order;

create sequence seq_propietario
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;

create sequence seq_telefono_propietario
  start with 1
  increment by 1
  maxvalue 10000
  nocycle
  order;

create sequence seq_status_vehiculo
  start with 1
  increment by 1
  maxvalue 10
  nocycle
  order;

create sequence seq_vehiculo
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;

create sequence seq_registro_mediciones
  start with 1
  increment by 1
  maxvalue 1000
  nocycle
  order;

create sequence seq_notificacion
  start with 1
  increment by 1
  maxvalue 100
  nocycle
  order;

create sequence seq_verificacion
  start with 1
  increment by 1
  maxvalue 10000
  nocycle
  order;

create sequence seq_tipo_licencia
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;

create sequence seq_licencia
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;

create sequence seq_biometria
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;

create sequence seq_puntos_negativos
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;

create sequence seq_historico_status_vehiculo
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;

create sequence seq_historico_propietario
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;


create sequence seq_pago_cuota
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;

create sequence seq_revision_licencia
  start with 1
  increment by 1
  maxvalue 1000000
  nocycle
  order;


Prompt creacion de secuencias completadas!.
disconnect;
