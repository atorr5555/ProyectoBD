--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 16/06/2020
--@descripción: Creacion de sinonimos

Prompt Conectando como usuario sys:
connect sys /system as sysdba 

Prompt creando sinonimos publicos:

create or replace public synonym vehiculo for fftv_proy_admin.vehiculo;
create or replace public synonym propietario for fftv_proy_admin.propietario;
create or replace public synonym placa for fftv_proy_admin.placa;
create or replace public synonym licencia for fftv_proy_admin.licencia;
create or replace public synonym historico_prop for fftv_proy_admin.historico_propietario;
create or replace public synonym historico_status for fftv_proy_admin.historico_status;

Prompt otorgando permisos al usuario invitado:
Prompt Conectando como administrador
connect fftv_proy_admin/admin
grant select on vehiculo to fftv_proy_invitado;
grant select on propietario to fftv_proy_invitado;
grant select on placa to fftv_proy_invitado;
grant select on licencia to fftv_proy_invitado;
grant select on entidad to fftv_proy_invitado;

Prompt Creando sinonimos con prefijo XX_

@crear-sinonimos.sql

Prompt Sinonimos correctamente creados..

connect fftv_proy_invitado/invitado;

Prompt Creando sinonimos para el usuario invitado:
create or replace synonym vehiculo for fftv_proy_admin.vehiculo;
create or replace synonym propietario for fftv_proy_admin.propietario;
create or replace synonym placa for fftv_proy_admin.placa;
create or replace synonym licencia for fftv_proy_admin.licencia;
create or replace synonym entidad for fftv_proy_admin.entidad;


Prompt creacion de sinonimos completada!.
disconnect;
