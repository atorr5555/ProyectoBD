--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 15/06/2020
--@Descripción: Creacion de Entidades
Prompt Conectando como usuario Administrador..
connect fftv_proy_admin/admin

Prompt Creando Entidades y atributos:

create table entidad(
  entidad_id number(10,0) constraint entidad_pk primary key,
  clave varchar2(5) not null,
  nomber varchar2(50) not null
);

create table placa(
  placa_id number(10,0) constraint placa_pk primary key,
  num_placa varchar2(40) not null constraint num_placa_uk unique,
  fecha_asignacion date,
  inactiva number(1,0) not null,
  num_serie_dispositivo varchar2(20) not null,
  entidad_id number(10,0) not null,
  constraint placa_entidad_id_fk foreign key (entidad_id)
    references entidad(entidad_id)
);

create table marca(
  marca_id number(10,0) constraint marca_pk primary key,
  clave varchar2(5) not null,
  descripcion varchar2(50) not null
);

create table modelo(
  modelo_id varchar2(10) constraint modelo_pk primary key,
  nombre varchar2(20) not null,
  marca_id number(10,0) not null, 
  constraint modelo_marca_id_fk foreign key (marca_id)
    references marca(marca_id)
);

create table propietario(
  propietario_id number(10,0) constraint propietario_pk primary key,
  nombre varchar2(50) not null,
  apellido_paterno varchar2(30) not null,
  apellido_materno varchar2(30) not null,
  RFC varchar2(13) default null,
  email varchar2(150) not null
);

create table telefono_propietario(
	telefono_propietario_id number(10,0) constraint telefono_propietario_pk primary key,
	num_telefono number(15) constraint telefono_propietario_num_telefono_uk unique,
	propietario_id number(10,0) constraint telefono_propietario_propietario_id
		references propietario(propietario_id)
);

create table status_vehiculo(
  status_vehiculo_id number(10,0) constraint status_vehiculo_pk primary key,
  clave varchar2(30) not null,
  descripcion varchar2(50) not null,
  constraint clave_chk check(
    clave='EN REGLA' or clave='CON LICENCIA EXPIRADA' 
    or clave='CON ADEUDO DEIMPUESTO' or
    clave='CON VERIFICACION PENDIENTE'
  )
);

create table vehiculo(
  vehiculo_id number(10,0) constraint vehiculo_pk primary key,
  año varchar2(4) not null,
  numero_serie varchar2(40) not null constraint numero_serie_uk unique,
  es_transporte_publico number(1,0) not null,
  es_carga number(1,0) not null,
  es_particular number(1,0) not null,
  inicio_periodo date not null,
  fecha_status date default sysdate,
  modelo_id varchar2(10)not null,
  constraint vehiculo_modelo_id_fk foreign key (modelo_id)
    references modelo(modelo_id),
  placa_id number(10,0) not null,
  constraint vehiculo_placa_id_fk foreign key (placa_id)
    references placa(placa_id),
  propietario_id number(10,0) not null,
  constraint vehiculo_propietario_id_fk foreign key (propietario_id)
    references propietario(propietario_id),
  status_vehiculo_id number(10,0) not null,
  constraint vehiculo_status_vehiculo_id_fk foreign key (status_vehiculo_id)
    references status_vehiculo(status_vehiculo_id),
  constraint tipo_vehiculo_chk check(
    (es_particular=1 and es_carga=1 and es_transporte_publico=0) or
    (es_particular=1 and es_carga=0 and es_transporte_publico=0) or
    (es_particular=0 and es_carga=1 and es_transporte_publico=0) or
    (es_particular=0 and es_carga=0 and es_transporte_publico=1)
  )
);

create table registro_mediciones(
  registro_mediciones_id number(10,0) constraint registro_mediciones_pk primary key,
  HC number(4,0) not null,
  CO number(4,3) not null,
  NOX number(4,3) not null,
  CO2 number(4,3) not null,
  fecha date not null,
  vehiculo_id number(10,0) not null,
  constraint registro_mediciones_vehiculo_id_fk foreign key (vehiculo_id)
    references vehiculo(vehiculo_id)
);

create table notificacion(
  notificacion_id number(10,0) constraint notificacion_pk primary key,
  num_notificacion number(5,0) not null,
  fecha date not null,
  registro_mediciones_id number(10,0) not null,
  constraint notificacion_registro_mediciones_id_fk foreign key (registro_mediciones_id)
    references registro_mediciones(registro_mediciones_id)
);

create table verificacion(
  verificacion_id number(10,0) constraint verificacion_pk primary key,
  fecha_verificacion date not null,
  folio_verificacion varchar(13) not null constraint folio_verificacion_uk unique,
  vehiculo_id number(10,0) not null,
  constraint verificacion_vehiculo_id_fk foreign key (vehiculo_id)
    references vehiculo(vehiculo_id) 
);

create table tipo_licencia(
  tipo_licencia_id number(10,0) constraint tipo_licencia_fk primary key,
  clave varchar2(1) not null,
  descripcion varchar2(50) not null
);

create table licencia(
  licencia_id number(10,0) constraint licencia_pk primary key,
  num_licencia varchar2(15) not null,
  inicio_vigencia date not null,
  fin_vigencia date not null,
  licencia_anterior_id number(30,0),
  constraint licencia_anterior_fk foreign key (licencia_anterior_id)
    references licencia(licencia_id),
  propietario_id number(10,0) not null,
  constraint licencia_propietario_id_fk foreign key (propietario_id)
    references propietario(propietario_id),
  tipo_licencia_id number(10,0) not null,
  constraint licencia_tipo_licencia_fk foreign key (tipo_licencia_id)
    references tipo_licencia(tipo_licencia_id)
);

create table biometria(
  licencia_id number(30,0) not null,
  constraint biometria_licencia_id_fk foreign key (licencia_id)
    references licencia(licencia_id),
  foto blob not null,
  firma blob not null,
  huella_izq blob not null,
  huella_der blob not null,
  constraint biometria_pk primary key(licencia_id)
);

create table puntos_negativos(
  puntos_negativos_id number(10,0) constraint puntos_negativos_pk primary key,
  fecha date not null,
  descripcion varchar2(50) not null,
  cantidad number(2,0) not null,
  documento_evidencia blob not null,
  propietario_id number(10,0) not null,
  constraint puntos_negativos_propietario_fk foreign key (propietario_id)
    references propietario(propietario_id)
);

create table historico_status_vehiculo(
  historico_status_vehiculo_id number(10,0) constraint historico_status_vehiculo_pk primary key,
  fecha_status date not null,
  vehiculo_id number(10,0) not null,
  constraint historico_status_vehiculo_id_fk foreign key (vehiculo_id)
    references vehiculo(vehiculo_id),
  status_vehiculo_id number(10,0) not null,
  constraint historico_status_vehiculo_status_fk foreign key (status_vehiculo_id)
    references status_vehiculo(status_vehiculo_id)
);

create table historico_propietario(
  historico_propietario_id number(10,0) constraint historico_propietario_pk primary key,
  inicio_periodo date not null,
  fin_periodo date not null,
  propietario_id number(10,0) not null,
  constraint historico_propietario_propietario_fk foreign key (propietario_id)
    references propietario(propietario_id),
  vehiculo_id number(10,0) not null,
  constraint historico_propietario_vehiculo_fk foreign key (vehiculo_id)
    references vehiculo(vehiculo_id)  
);

create table transporte_publico(
  vehiculo_id number(10,0) not null,
  constraint transporte_publico_vehiculo_fk foreign key (vehiculo_id)
    references vehiculo(vehiculo_id),
  num_pasajeros_sentados number(2,0) not null,
  num_pasajeros_parados number(2,0) not null,
  num_pasajeros_total as (num_pasajeros_parados+num_pasajeros_sentados) not null,
  tipo_licencia_requerida_id number(10,0) not null,
  constraint transporte_publico_tipo_licencia_fk foreign key (tipo_licencia_requerida_id)
    references tipo_licencia(tipo_licencia_id)
);

create table carga(
  vehiculo_id number(10,0) not null,
  constraint carga_vehiculo_fk foreign key (vehiculo_id)
    references vehiculo(vehiculo_id),
  capacidad_toneladas number(5,2) not null,
  capacidad_m3 number(5,2) default null,
  num_remolques number(2,0) default null,
  constraint carga_pk primary key(vehiculo_id)
);

create table particular(
  vehiculo_id number(10,0) not null,
  constraint particular_vehiculo_fk foreign key (vehiculo_id)
    references vehiculo(vehiculo_id),
  num_bolsas_aire number(2,0) not null,
  tiene_abs number(1,0) not null,
  tipo_transmision varchar2(1) not null,
  constraint particular_pk primary key(vehiculo_id),
  constraint tipo_transmision_chk check(
    tipo_transmision='M' or tipo_transmision='A'
  )
);

create table pago_cuota(
  folio number(10,0) not null constraint folio_uk unique,
  vehiculo_id number(10,0) not null,
  constraint pago_cuota_vehiculo_fk foreign key (vehiculo_id)
    references vehiculo(vehiculo_id),
  fecha_pago date not null,
  importe number(7,2) not null,
  constraint pago_cuota_pk primary key(folio,vehiculo_id)
);