--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 16/06/2020
--@descripción: Creacion de indices que pueden ser de utilidad en el caso de estudio

Prompt Conectando como administrador:
connect fftv_proy_admin/admin 
Prompt creando indices no unique:
create index email_ix on propietario(email);
create index importe_ix on pago_cuota(importe);
create index RFC_ix on propietario(RFC);
create index clave_ix on entidad(clave);

Prompt creando indices unique:
--create unique index nombre_iuk on  propietario(nombre);
--create unique index fecha_status_iuk on vehiculo(fecha_status);
create unique index clave_Status_iuk on status_vehiculo(clave);
create unique index num_licencia_iuk on licencia(num_licencia);


Prompt creando indices compuestos:
create unique index vehiculo_propietario_iuk on vehiculo(vehiculo_id,propietario_id);
create unique index vehiculo_placa_iuk on vehiculo(vehiculo_id,placa_id);
--create unique index folio_importe_iuk on pago_cuota(folio,importe);
create unique index propietario_licencia_iuk on licencia(propietario_id,licencia_id);

Prompt creando indices a base de funciones:
create index nombre_completo_ix on propietario(upper(nombre)||' '||upper(apellido_paterno));

Prompt creacion de indices completada!.

disconnect;


