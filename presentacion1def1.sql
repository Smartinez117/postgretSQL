--PRESENTACION 1 VERSION 2 
--Escenario: Sistema de Gestión de Proyectos

--Tabla de Proyectos (proyectos): Almacena información sobre los proyectos.
--Tabla de Tareas (tareas): Almacena las tareas relacionadas con los proyectos. 
--La idea es que todas las operaciones (INSERT, UPDATE, DELETE) sobre la tabla de tareas sean redirigidas a una tabla secundaria para evitar la recursión infinita.

CREATE TABLE sc_pruebas.tablaProyectos (  
    id_proyecto serial PRIMARY KEY,
    nombre_proyecto text NOT NULL,
    fecha_inicio date NOT NULL ,
    fecha_fin date
	--PRIMARY KEY (id_proyecto ,nombre_proyecto)
);
--tabla secundaria asociada a c_pruebas.tablaProyectos
CREATE TABLE sc_pruebas.tablaTareas (
    id_tarea serial PRIMARY KEY,
    id_proyecto integer REFERENCES sc_pruebas.tablaProyectos(id_proyecto),
    nombre_tarea text NOT NULL,
    legajo_alumno integer NOT NULL,
    descripcion text,
    estado varchar(20) DEFAULT 'Pendiente',
    fecha_asignacion date NOT NULL DEFAULT CURRENT_DATE,
    fecha_entrega date,
    prioridad varchar(10) CHECK (prioridad IN ('Alta', 'Media', 'Baja')),
    fecha_completada date
);
CREATE TABLE sc_pruebas.tareasSecundaria (
    id_tarea serial PRIMARY KEY,
    id_proyecto integer REFERENCES sc_pruebas.tablaProyectos(id_proyecto),
    nombre_tarea text NOT NULL,
    legajo_alumno integer NOT NULL,
    descripcion text,
    estado varchar(20) DEFAULT 'Pendiente',
    fecha_asignacion date NOT NULL DEFAULT CURRENT_DATE,
    fecha_entrega date,
    prioridad varchar(10) CHECK (prioridad IN ('Alta', 'Media', 'Baja')),
    fecha_completada date
);
--rule insert
CREATE OR REPLACE RULE insertEnTareas AS
ON INSERT TO sc_pruebas.tablaTareas
DO INSTEAD
INSERT INTO sc_pruebas.tareasSecundaria (
    id_proyecto, nombre_tarea, legajo_alumno, descripcion, estado, 
    fecha_asignacion, fecha_entrega, prioridad, fecha_completada)
VALUES (
    NEW.id_proyecto, NEW.nombre_tarea, NEW.legajo_alumno, NEW.descripcion, 
    NEW.estado, NEW.fecha_asignacion, NEW.fecha_entrega, NEW.prioridad, 
    NEW.fecha_completada);

--ejemplo
INSERT INTO sc_pruebas.tablaProyectos (nombre_proyecto, fecha_inicio, fecha_fin)
VALUES
    ('presentacion1 Base de datos', '2024-09-08', '2024-09-16'),
    ('Presentacion2 base de datos', '2024-09-10', '2024-09-16');

select *from sc_pruebas.tablaProyectos; 

INSERT INTO sc_pruebas.tablaTareas (
    id_proyecto, nombre_tarea, legajo_alumno, descripcion, estado, 
    fecha_asignacion, fecha_entrega, prioridad)
VALUES (
    1,  -- ID del proyecto
    'presentacion1 base de datos', 
    13949,  -- ID del alumno
    'uso de rules en tabla', 
    'Entregada', 
    CURRENT_DATE, 
    '2024-09-16', 
    'Alta'
);

select * from sc_pruebas.tareasSecundaria;
--prueba del serial
INSERT INTO sc_pruebas.tablaTareas (
    id_proyecto, nombre_tarea, legajo_alumno, descripcion, estado, 
    fecha_asignacion, fecha_entrega, prioridad)
VALUES (
    3,  -- ID del proyecto
    'presentacion3 base de datos', 
    13949,  -- ID del alumno
    'uso de rules en tabla', 
    'ENTREGADA', 
    CURRENT_DATE, 
    '2024-09-16', 
    'Alta'
);
--update
UPDATE sc_pruebas.tablaTareas
SET estado = 'Completada', fecha_completada = CURRENT_DATE
WHERE id_tarea = 1;

select * from sc_pruebas.tareasSecundaria;

