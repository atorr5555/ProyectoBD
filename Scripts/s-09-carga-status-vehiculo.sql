--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 19/06/2020
--@Descripción: Carga de status_vehiculo

insert into status_vehiculo(status_vehiculo_id, clave, descripcion) values(seq_status_vehiculo.nextval, 'EN REGLA', 'VEHICULO EN REGLA');
insert into status_vehiculo(status_vehiculo_id, clave, descripcion) values(seq_status_vehiculo.nextval, 'CON LICENCIA EXPIRADA', 'PROPIETARIO CON LICENCIA EXPIRADA');
insert into status_vehiculo(status_vehiculo_id, clave, descripcion) values(seq_status_vehiculo.nextval, 'CON ADEUDO DE IMPUESTO', 'NO HA PAGADO ALGUNA CUOTA ANUAL');
insert into status_vehiculo(status_vehiculo_id, clave, descripcion) values(seq_status_vehiculo.nextval, 'CON VERIFICACION PENDIENTE', 'DEBE IR A UN CENTRO DE VERIFICACION');