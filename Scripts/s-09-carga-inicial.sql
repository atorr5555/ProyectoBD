--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 19/06/2020
--@Descripción: Carga inicial de datos

whenever sqlerror exit;

@s-09-carga-entidad.sql
@s-09-carga-placa.sql
@s-09-carga-marca.sql
@s-09-carga-modelo.sql
@s-09-carga-propietario.sql
@s-09-carga-status-vehiculo.sql
@s-09-carga-vehiculo.sql
@s-09-carga-tipo-licencia.sql
@s-09-carga-licencia.sql

whenever sqlerror continue;