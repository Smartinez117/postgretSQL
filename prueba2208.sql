--verificacion de la existencia de la vista del view para la base de datos
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'pglfldv2_obj_def';

--comando para ver los tipos de datos de una view
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'pglfldv2_obj_def'
AND table_schema = 'sc_pgl';


--vista de la view.
select * from sc_pgl.pglfldv2_obj_def;
select * from sc_pgl.pglfldv2_obj_def_table;
----------------------------------------
--paso1
CREATE TABLE sc_pgl.pglfldv2_obj_def_table (
    fmdtb text,
    fmsch text,
    ftobjtip text,
    fmobj text,
    ftobjcmn text,
    fifld integer,
    fmfld text,
    fmschdom text,
    fmdom text,
    ftfldtip text,
    ftfldcmn text,
    ftfil text,
    fvind char,
    fdgen date
);
--paso2 
CREATE VIEW sc_pgl.pglfldv2_obj_def_view1 AS
SELECT 
    fmdtb, fmsch, ftobjtip, fmobj, ftobjcmn, fifld, fmfld,
    fmschdom, fmdom, ftfldtip, ftfldcmn, ftfil, fvind, fdgen
FROM sc_pgl.pglfldv2_obj_def_table;


--------------------------creacion de las rule para la table/view------------------------------------
--uso del insert para la view
CREATE RULE insertarV1 AS
ON INSERT TO sc_pgl.pglfldv2_obj_def_view1
DO INSTEAD
INSERT INTO sc_pgl.pglfldv2_obj_def_table(
    fmdtb, fmsch, ftobjtip, fmobj, ftobjcmn, fifld, fmfld,
    fmschdom, fmdom, ftfldtip, ftfldcmn, ftfil, fvind, fdgen)
VALUES (
    NEW.fmdtb, NEW.fmsch, NEW.ftobjtip, NEW.fmobj, NEW.ftobjcmn, NEW.fifld, NEW.fmfld,
    NEW.fmschdom, NEW.fmdom, NEW.ftfldtip, NEW.ftfldcmn, NEW.ftfil, NEW.fvind, NEW.fdgen);
----------------------------------------------------
--version 2 del insert, resulta ser mas util al ser mas descriptivo
CREATE RULE insertVersion2 AS
ON INSERT TO sc_pgl.pglfldv2_obj_def
DO INSTEAD
INSERT INTO sc_pgl.pglfldv2_obj_def (baseDeDatos, schema, tipo_objeto, nombre_objeto, descripción, columna_id, nombre_columna, schema_relacionado, nombre_objeto_relacionado, tipo_dato, comentario_columna, objeto_pg_class, tipo, fecha_creacion)
VALUES (NEW.baseDeDatos, NEW.schema, NEW.tipo_objeto, NEW.nombre_objeto, NEW.descripción, NEW.columna_id, NEW.nombre_columna, NEW.schema_relacionado, NEW.nombre_objeto_relacionado, NEW.tipo_dato, NEW.comentario_columna, NEW.objeto_pg_class, NEW.tipo, NEW.fecha_creacion);

-------------------------------------------------------------------------------------------------------
--caso del update para la view
CREATE RULE updateParaV1 AS
ON UPDATE TO sc_pgl.pglfldv2_obj_def_view1
DO INSTEAD
UPDATE sc_pgl.pglfldv2_obj_def_table
SET
    fmdtb = NEW.fmdtb,
    fmsch = NEW.fmsch,
    ftobjtip = NEW.ftobjtip,
    fmobj = NEW.fmobj,
    ftobjcmn = NEW.ftobjcmn,
    fifld = NEW.fifld,
    fmfld = NEW.fmfld,
    fmschdom = NEW.fmschdom,
    fmdom = NEW.fmdom,
    ftfldtip = NEW.ftfldtip,
    ftfldcmn = NEW.ftfldcmn,
    ftfil = NEW.ftfil,
    fvind = NEW.fvind,
    fdgen = NEW.fdgen
WHERE fmdtb = OLD.fmdtb AND ftobjtip = OLD.ftobjtip AND fdgen = OLD.fdgen;
----------------------------------------------------------------------------------------------
--version 2 del update ligeramnete superior
CREATE RULE updateVersion2 AS
ON UPDATE TO sc_pgl.pglfldv2_obj_def
DO INSTEAD
UPDATE sc_pgl.pglfldv2_obj_def
SET
    baseDeDatos = NEW.baseDeDatos,
    schema = NEW.schema,
    tipo_objeto = NEW.tipo_objeto,
    nombre_objeto = NEW.nombre_objeto,
    descripción = NEW.descripción,
    columna_id = NEW.columna_id,
    nombre_columna = NEW.nombre_columna,
    schema_relacionado = NEW.schema_relacionado,
    nombre_objeto_relacionado = NEW.nombre_objeto_relacionado,
    tipo_dato = NEW.tipo_dato,
    comentario_columna = NEW.comentario_columna,
    objeto_pg_class = NEW.objeto_pg_class,
    tipo = NEW.tipo,
    fecha_creacion = NEW.fecha_creacion
WHERE baseDeDatos = OLD.baseDeDatos
AND schema = OLD.schema
AND nombre_objeto = OLD.nombre_objeto
AND columna_id = OLD.columna_id
AND nombre_columna = OLD.nombre_columna;

----------------------------------------------------------------------------------------------
--caso para el delete
CREATE RULE deletev1 AS
ON DELETE TO sc_pgl.pglfldv2_obj_def_view1
DO INSTEAD
DELETE FROM sc_pgl.pglfldv2_obj_def_table
WHERE fmdtb = OLD.fmdtb AND ftobjtip = OLD.ftobjtip AND fdgen = OLD.fdgen;
---------------------------------------------------------------------------
--version 2 del delte
CREATE RULE deleteVersion2 AS
ON DELETE TO sc_pgl.pglfldv2_obj_def
DO INSTEAD
DELETE FROM sc_pgl.pglfldv2_obj_def
WHERE baseDeDatos = OLD.baseDeDatos
AND schema = OLD.schema
AND nombre_objeto = OLD.nombre_objeto
AND columna_id = OLD.columna_id
AND nombre_columna = OLD.nombre_columna;
-------------------------PRUEBAS PARA LOS INSERT,UPDATE Y DELETE---------------------------------
INSERT INTO sc_pgl.pglfldv2_obj_def (
	baseDeDatos, schema, tipo_objeto, nombre_objeto, descripción, columna_id, nombre_columna, schema_relacionado, nombre_objeto_relacionado, tipo_dato, comentario_columna, objeto_pg_class, tipo, fecha_creacion)
VALUES ('miBaseDeDatos', 'miSchema', 'Tabla', 'miObjeto', 'Descripción del objeto', 1, 'miColumna', 'miSchemaRelacionado', 'miObjetoRelacionado', 'integer', 'Comentario de la columna', 'pg_class', 'r', '2024-08-23');
--prueba2--
INSERT INTO sc_pgl.pglfldv2_obj_def_view1 (
    fmdtb, fmsch, ftobjtip, fmobj, ftobjcmn, fifld, fmfld,
    fmschdom, fmdom, ftfldtip, ftfldcmn, ftfil, fvind, fdgen)
VALUES (
    'tabla1', 'schema1', 'tipo_objeto1', 'objeto1', 'comentario_obj1', 10, 'campo1',
    'schema_dom1', 'dominio1', 'tipo_campo1', 'comentario_campo1', 'filtro1', 'v', '2024-08-22');
--prueba 3
INSERT INTO sc_pgl.pglfldv2_obj_def_view1 (
    fmdtb, fmsch, ftobjtip, fmobj, ftobjcmn, fifld, fmfld,
    fmschdom, fmdom, ftfldtip, ftfldcmn, ftfil, fvind, fdgen)
VALUES (
    'tabla1', 'schema1', 'tipo_objeto1', 'objeto1', 'comentario_obj1', 10, 'campo1',
    'schema_dom1', 'dominio1', 'tipo_campo1', 'comentario_campo1', 'filtro1', 'v', '2024-08-23');

------------------------------------------------------------------

--PRUEBA PARA VER QUE FUNCIONES EL INSERT
SELECT * FROM sc_pgl.pglfldv2_obj_def_view1 WHERE nombre_objeto = 'miObjeto1';
----version2 que funciona.
SELECT * FROM sc_pgl.pglfldv2_obj_def_view1 WHERE fmdtb = 'tabla1' AND fmobj = 'objeto1';


--ACTUALIZAR UN REGISTRO
UPDATE sc_pgl.pglfldv2_obj_def
SET nombre_objeto = 'nuevoObjeto', descripción = 'Nueva descripción'
WHERE baseDeDatos = 'miBaseDeDatos' AND schema = 'miSchema' AND nombre_objeto = 'miObjeto' AND columna_id = 1 AND nombre_columna = 'miColumna';
--VERIFICAR LA ACTUALIZACION
SELECT * FROM sc_pgl.pglfldv2_obj_def WHERE nombre_objeto = 'nuevoObjeto';
--ELIMINAR UN REGISTRO
DELETE FROM sc_pgl.pglfldv2_obj_def
WHERE baseDeDatos = 'miBaseDeDatos' AND schema = 'miSchema' AND nombre_objeto = 'nuevoObjeto' AND columna_id = 1 AND nombre_columna = 'miColumna';
--VERIFICAR LA ELIMINICACION
SELECT * FROM sc_pgl.pglfldv2_obj_def WHERE nombre_objeto = 'nuevoObjeto';
