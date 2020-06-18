--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 16/06/2020
--@descripción: Creacion de secuencias necesarias en la bd

/*Este archivo contendrá 5 o más consultas. El criterio es libre. Se debe emplear el uso de los siguientes elementos.
- joins (inner join, natural join, outer join)
- funciones de agregación (group by y having)
- algebra relacional (operadores set: union, intersect, minus).
- Subconsultas
- Consulta que involucre el uso de un sinónimo
- Consulta que involucre el uso de una vista
- Consulta que involucre una tabla temporal
- Consulta que involucre a una tabla externa.
No es necesario crear una consulta por cada elemento. En una misma consulta pueden incluirse varios de los elementos anteriores. 
*/

/*
Consulta para encontrar todos los vehículos particulares que no tienen frenos
ABS cuyo status sea diferente a 'EN REGLA'. Obtener su id, año, numero de serie
y el tipo de transmision.

Utiliza joins, sinonimos
*/

select v.vehiculo_id, v.anio, v.numero_serie, p.tipo_transmision
from XX_vehiculo v, XX_particular p, XX_status_vehiculo s
where v.vehiculo_id = p.vehiculo_id
and v.status_vehiculo_id = s.status_vehiculo_id
and s.descripcion != 'EN REGLA';

/*
Consulta para mostar las mediciones de CO y el id de todos los autos. No mostrar
las mediciones realizadas ante del 2015. Mostar las mediciones en las que HC sea
menor a 200
Utiliza subconsulta, funcion de agregacion, algebra relacional
*/
select vehiculo_id, CO, (
  select avg(CO)
  from registro_mediciones 
) as promedio_mediciones
from (
  select *
  from registro_mediciones
  where HC < 200
  minus
  select *
  from registro_mediciones
  where to_char(fecha, 'yyyy') = '2015'
);

/*
Obtener los propietarios con más de 3 vehículos de la vista view_vehiculo,
obtener su nombre y el número de vehículos que tienen.
Utiliza una vista, funciones de agregacion
*/
select nombre, count(*) as num_vehiculos
from view_vehiculo
group by nombre
having count(*) > 3;

/*
De la tabla temporal vehículo obtener el porcentaje de autos de carga
y autos particulares que hay en el año establecido
*/
select (numero_autos_carga/numero_autos)*100 as porcentaje_carga,
  (numero_autos_carga/numero_autos)*100 as porcentaje_particulares
from tabla_temporal_vehiculo;

/*
Consulta a la tabla externa que obtiene los autos cuyo número de serie
empieze con A
*/
select * 
from vehiculos_antiguos
where num_serie like 'A%';