--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 19/06/2020
--@Descripción: Carga de tipos licencia

insert into tipo_licencia(tipo_licencia_id, clave, descripcion) values(seq_tipo_licencia.nextval, 'A', 'Taxis tipo sedán');
insert into tipo_licencia(tipo_licencia_id, clave, descripcion) values(seq_tipo_licencia.nextval, 'B', 'Camionetas sin pasajeros de pie');
insert into tipo_licencia(tipo_licencia_id, clave, descripcion) values(seq_tipo_licencia.nextval, 'C', ' Autobuses y Camiones para transportar 20 o más');