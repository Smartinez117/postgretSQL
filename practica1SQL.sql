-- clase 5,6
create table persona(
idPersona int not null,
nombre varchar(10),
cedula varchar(8)
)
insert into persona values ('1','tomas','234') -- una forma de insertar datos
insert into persona (idPersona,nombre) values ('2','alejo');
insert into persona values ('3','mauro','23423');
insert into persona values ('3','ivan','23423243');

select * FROM persona -- permite ver toda la tabla 
select * FROM persona where nombre = 'alejo';-- permite tomar los elementos con una valor especifico
delete persona;-- chequar despues para tener en cuenta como borrar un registro.
truncate table Persona

--Actualizar una un registro
select * from persona

update persona set idPersona = '4'
where cedula is null

update persona set cedula = '4646868' -- tener en cuenta cambiar la cedula
where dedula is null

update persona set cedula = '4646868', nombre= 'daniel' -- tener en cuenta cambiar la cedula
where dedula is null -- se usa el where para definir una columba o fila

---------------------------aplicacion de primary key ---------------------------------
--permite definir que uno de los parametros de la tabla sea unico
Select * from persona

Create table persona{
Idpersona int not null,
Nombre varchar (20),
Cedula varchar(20),
Primary key (idpersona)
}
Alter table persona
Add prmary key (idpersona)
--Insert into persona values (´id repetido´, ´´ , ´´ , ´´), si se coloca un id repetido saldrá error pues --fue definido un primary key para que los id sean únicos.
