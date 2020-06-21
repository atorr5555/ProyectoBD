--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 19/06/2020
--@Descripción: Carga inicial de datos

whenever sqlerror exit rollback;
@s-15-fx-genera-num-serie.sql
@s-15-fx-genera-num-notif.sql
@s-15-fx-genera-folio-pago.sql
prompt Cargando entidades ...
@s-09-carga-entidad.sql
prompt Cargando placas ...
@s-09-carga-placa.sql
prompt Cargando marcas ...
@s-09-carga-marca.sql
prompt Cargando modelos ...
@s-09-carga-modelo.sql
prompt Cargando tipos de licencia ...
@s-09-carga-tipo-licencia.sql
prompt Cargando propietarios ...
@s-09-carga-propietario.sql
prompt Cargando status vehiculo ...
@s-09-carga-status-vehiculo.sql
prompt Cargando vehiculos ...
@s-09-carga-vehiculo.sql
prompt Cargando licencias ...
@s-09-carga-licencia.sql
prompt Cargando mediciones ...
@s-09-carga-mediciones.sql
prompt Cargando notificaciones ...
@s-09-carga-notificacion.sql
prompt Cargando pagos ...
@s-09-carga-pago.sql
prompt Cargando verificaciones ...
@s-09-carga-carga-verificacion.sql

commit;
prompt Listo! Carga inicial completa

whenever sqlerror continue;