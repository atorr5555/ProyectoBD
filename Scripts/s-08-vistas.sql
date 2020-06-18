--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 16/06/2020
--@descripción: Creacion de vistas útiles

Prompt Conectando como usuario Administrador..
connect fftv_proy_admin/admin

prompt creando vistas:

create or replace view view_vehiculo(
vehiculo_id,año,numero_serie,nombre,num_placa
) as select v.vehiculo_id,v.año,v.numero_serie,pp.nombre,p.num_placa
from vehiculo v,propietario pp,placa p
where v.propietario_id=pp.propietario_id and v.placa_id=p.placa_id;

create or replace view view_propietario(
propietario_id,nombre,num_licencia,cantidad
) as select p.propietario_id,p.nombre,l.num_licencia,n.cantidad
from propietario p, licencia l, puntos_negativos n
where p.propietario_id=l.propietario_id and p.propietario_id=n.propietario_id;

create or replace view vehiculo_carga(
vehiculo_id,capacidad_toneladas,año,nombre
) as select c.vehiculo_id,c.capacidad_toneladas,v.año, m.nombre
from carga c, vehiculo v, modelo m
where c.vehiculo_id=v.vehiculo_id and v.modelo_id=m.modelo_id;

create or replace view vehiculo_transporte(
vehiculo_id,num_pasajeros_sentados,año
) as select t.vehiculo_id, t.num_pasajeros_sentados,v.año
from transporte_publico t,vehiculo v 
where t.vehiculo_id=v.vehiculo_id;

create or replace view vehiculo_particular(
vehiculo_id,num_bolsas_aire,numero_serie,nombre
)as select pa.vehiculo_id,pa.num_bolsas_aire,v.numero_serie,p.nombre
from particular pa,vehiculo v,propietario p
where pa.vehiculo_id=v.vehiculo_id and v.propietario_id=p.propietario_id;

Prompt Vistas creadas exitosamente!.
disconnect;