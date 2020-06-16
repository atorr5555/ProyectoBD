--@Autor: FLores Fuentes Kevin y Torres Verastegui Jose Antonio
--@Fecha creación: 15/06/2020
--@Descripción: Creacion de usuario

Prompt Proporcionar el password del usuario sys:
connect sys as sysdba

Prompt creando roles

create role rol_admin;
grant create table, create session,create view, create procedure, create synonym,
	create sequence, create trigger to rol_admin;

create role rol_invitado;
grant create session to rol_invitado;

prompt creando usuario fftv_proy_admin
create user fftv_proy_admin identified by admin quota unlimited on users;

prompt creando usuario fftv_proy_invitado
create user fftv_proy_invitado identified by invitado quota unlimited on users;

Prompt Asignando roles
--Rol de Admin
grant rol_admin to fftv_proy_admin;
--Rol de Invitado
grant rol_invitado to fftv_proy_invitado;

Prompt Creacion de roles, usuarios y privilegios completado.
disconnect;

