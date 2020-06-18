--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 16/06/2020
--@Descripción: Creacion de tablas(s) temporal(es)

Prompt Conectando como usuario Administrador..
connect fftv_proy_admin/admin

Prompt creando tabla temporal:

create global temporary table tabla_temporal_vehiculo(
  año varchar2(4) not null,
  numero_autos number(10,0),
  numero_autos_carga number(20,0),
  numero_autos_particulares number(20,0)
) on commit delete rows; 

--Obtener el numero de autos, el año, el numero de autos de carga, y el numero de autos particulares del año 2010

insert into tabla_temporal_vehiculo(año,numero_autos,numero_autos_carga,numero_autos_particulares)
values ('2010',(
  select count(*) as num_autos
  from vehiculo v
  where año='2010'
  ),(
  select count(*) as num_autos_carga
  from carga c, vehiculo v
  where c.vehiculo_id=v.vehiculo_id and año='2010'
  ),
  (
  select count(*) as numero_autos_particulares
  from particular p, vehiculo v
  where p.vehiculo_id=v.vehiculo_id and año='2010'
  )
);

select * from tabla_temporal_vehiculo;

Prompt Listo!
disconnect;