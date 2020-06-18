--@Autor: Flores Fuentes Kevin y Torres Verástegui José Antonio
--@Fecha de creación: 16/06/2020
--@descripción: creacion de sinonimos con prefijo xx

Prompt Conectando como administrador
connect fftv_proy_admin/admin

declare
  in_schema varchar(100):= 'FFTV_PROY_ADMIN';

  cursor cur_tablas is 
    select table_name from all_tables where owner = 'FFTV_PROY_ADMIN';

begin
  for i in cur_tablas loop
    Execute immediate 'create synonym '||'XX_'||i.table_name||' for '||in_schema||'.'||i.table_name;
  end loop;
end;
/