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
create index particular_id_ix on particular(vehiculo_id);
create index carga_id_ix on carga(vehiculo_id);
create index transporte_publico_id_ix on transporte_publico(vehiculo_id);
create index biometria_id_ix on biometria(licencia_id);
create index registro_mediciones_fk_ix on notificacion(registro_mediciones_id);
create index vehiculo_fk_ix on registro_mediciones(vehiculo_id);

Prompt creando indices unique:
create unique index clave_status_iuk on status_vehiculo(clave);
create unique index num_licencia_iuk on licencia(num_licencia);


Prompt creando indices compuestos:
create unique index vehiculo_propietario_iuk on vehiculo(vehiculo_id,propietario_id);
create unique index vehiculo_placa_iuk on vehiculo(vehiculo_id,placa_id);
create unique index propietario_licencia_iuk on licencia(propietario_id,licencia_id);

Prompt creando indices a base de funciones:
create index nombre_completo_ix on propietario(upper(nombre)||' '||upper(apellido_paterno));

Prompt creacion de indices completada!.

disconnect;


