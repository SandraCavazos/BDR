-- revisión de correcciones en las tablas de la base de datos


select * from customers; -- todo se ve bien en esta tabla, sin embargo se prefiere tener los datos de la columna "Currency" en mayúscula

start transaction;
update customers set Currency=upper(Currency); -- el cambio se efectuó correctamente, se corre commit
commit;



select * from gasstations;
-- observamos que en esta tabla, la columna "Segment" tiene un caracter alfanumérico que no se tiene en el mismo campo en tabla customers
-- hacemos query para extraer solamente el componente numérico de la columna "Segment" en la tabla gasstations.

start transaction;
update gasstations set segment=substring(segment, 2,2); -- el cambio se efectuó correctamente, se corre commit
-- rollback;
commit;



select * from products; -- todo se ve bien en esta tabla

select * from yearmonth; -- todo se ve bien en esta tabla



select * from transactions_1k; 
-- se observa que el campo "CardID" tiene el mismo dato para todos los registros,
-- dicha columna se eliminará al no contener información representativa

start transaction;
alter table transactions_1k drop column CardID; -- el cambio se efectuó correctamente, se corre commit
commit;