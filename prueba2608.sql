--nota la insercion de los datos no se ejecutan pero la tabla si esta creada en la vista definida mas abajo
--paso1 crear una tabla asociada a una view definida
--dudas a responder porque la necesidad de definir una tabla asociada a la view,
--tomando en cuenta que las view son datos que se muestran solo cuando se ejecuta el select de la view, entonces para guardas los datos de la view se tendria qe 
CREATE TABLE sc_pgl.tabla1 (
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
--como ya tengo vistas definidas puedo crear directamente las rules relacionadas con dicha vista usando la tabla
CREATE RULE ruleInsert AS
ON INSERT TO sc_pgl.pglfldv2_obj_def --nombre de la vista creada con anticipacion
DO INSTEAD
INSERT INTO sc_pgl.tabla1( -- nombre de la tabla asociada a la vista anterior
    fmdtb, fmsch, ftobjtip, fmobj, ftobjcmn, fifld, fmfld,
    fmschdom, fmdom, ftfldtip, ftfldcmn, ftfil, fvind, fdgen)
VALUES (
    NEW.fmdtb, NEW.fmsch, NEW.ftobjtip, NEW.fmobj, NEW.ftobjcmn, NEW.fifld, NEW.fmfld,
    NEW.fmschdom, NEW.fmdom, NEW.ftfldtip, NEW.ftfldcmn, NEW.ftfil, NEW.fvind, NEW.fdgen);

--creacion de la rule para actualizar datos de la vista, parece que no funciona el update
CREATE RULE ruleUpdate AS
ON UPDATE TO sc_pgl.pglfldv2_obj_def    --nombre de la vista creada con anticipacion
DO INSTEAD
UPDATE sc_pgl.tabla1   -- nombre de la tabla asociada a la vista anterior
SET
    fmdtb    = NEW.fmdtb,fmsch 	  = NEW.fmsch,ftobjtip	   = NEW.ftobjtip,fmobj = NEW.fmobj,
	ftobjcmn = NEW.ftobjcmn,fifld = NEW.fifld,fmfld        = NEW.fmfld,fmschdom = NEW.fmschdom,
    fmdom    = NEW.fmdom,ftfldtip = NEW.ftfldtip,ftfldcmn  = NEW.ftfldcmn,ftfil = NEW.ftfil,
    fvind	 = NEW.fvind,fdgen	  = NEW.fdgen
WHERE fmdtb = OLD.fmdtb AND fmsch = OLD.fmsch AND ftobjtip = OLD.ftobjtip;

--rule para hacer un delete en la vista, parece que no funciona el delete
CREATE RULE ruleDelete AS
ON DELETE TO sc_pgl.pglfldv2_obj_def     --nombre de la vista creada con anticipacion
DO INSTEAD
DELETE FROM sc_pgl.tabla1  -- nombre de la tabla asociada a la vista anterior
WHERE fmdtb = OLD.fmdtb AND ftobjtip = OLD.ftobjtip AND fdgen = OLD.fdgen;
-------------------------------------------------------------------<<<<<<<<<<<<<<<<<<<<<<<<
CREATE RULE ruleUpdate AS -- rule mas completo del update.
ON UPDATE TO sc_pgl.pglfldv2_obj_def
DO INSTEAD
UPDATE sc_pgl.tabla1
SET
    fmdtb    = NEW.fmdtb, fmsch    = NEW.fmsch, ftobjtip    = NEW.ftobjtip, fmobj = NEW.fmobj,
	ftobjcmn = NEW.ftobjcmn, fifld = NEW.fifld, fmfld 		= NEW.fmfld, fmschdom = NEW.fmschdom,
    fmdom    = NEW.fmdom, ftfldtip = NEW.ftfldtip, ftfldcmn = NEW.ftfldcmn, ftfil = NEW.ftfil,
    fvind	 = NEW.fvind, fdgen    = NEW.fdgen
WHERE fmdtb    = OLD.fmdtb    AND fmsch = OLD.fmsch    AND ftobjtip = OLD.ftobjtip AND fmobj = OLD.fmobj AND
	  ftobjcmn = OLD.ftobjcmn AND fifld = OLD.fifld       AND fmfld = OLD.fmfld AND fmschdom = OLD.fmschdom AND
      fmdom    = OLD.fmdom AND ftfldtip = OLD.ftfldtip AND ftfldcmn = OLD.ftfldcmn AND ftfil = OLD.ftfil AND
      fvind	   = OLD.fvind AND    fdgen = OLD.fdgen;

-------------------------------------------------------------------<<<<<<<<<<<<<<<<<<<<<<<<
CREATE RULE ruleDelete AS 
ON DELETE TO sc_pgl.pglfldv2_obj_def
DO INSTEAD
DELETE FROM sc_pgl.tabla1
WHERE fmdtb    = OLD.fmdtb    AND fmsch = OLD.fmsch    AND ftobjtip = OLD.ftobjtip AND fmobj = OLD.fmobj AND
	  ftobjcmn = OLD.ftobjcmn AND fifld = OLD.fifld       AND fmfld = OLD.fmfld AND fmschdom = OLD.fmschdom AND
      fmdom    = OLD.fmdom AND ftfldtip = OLD.ftfldtip AND ftfldcmn = OLD.ftfldcmn AND ftfil = OLD.ftfil AND
      fvind	   = OLD.fvind AND    fdgen = OLD.fdgen;

-------------------------------------------------------------------<<<<<<<<<<<<<<<<<<<<<<<<
--vista de la view.
select * from sc_pgl.pglfldv2_obj_def;
select * from sc_pgl.tabla1; 

--prueba del insert
INSERT INTO sc_pgl.pglfldv2_obj_def(
    fmdtb, fmsch, ftobjtip, fmobj, ftobjcmn, fifld, fmfld,
    fmschdom, fmdom, ftfldtip, ftfldcmn, ftfil, fvind, fdgen)
VALUES (
    'tabla1', 'schema1', 'tipo_objeto1', 'objeto1', 'comentario_obj1', 10, 'campo1',
    'schema_dom1', 'dominio1', 'tipo_campo1', 'comentario_campo1', 'filtro1', 'v', '2024-08-24');
----ver el insert
SELECT * FROM sc_pgl.tabla1 WHERE fmdtb = 'tabla1';

--prueba del update , para el primer insert
UPDATE sc_pgl.pglfldv2_obj_def
SET fmdtb = 'hola',fmsch = 'mundo' , ftobjtip = 'cruel',
fmobj='de' , ftobjcmn = 'asembler', fifld = 1000, 
fmfld= 'que',fmschdom = 'mas', fmdom='agrego', 
ftfldtip= 'nose', ftfldcmn= 'hola', ftfil= 'que', 
fvind='tal', fdgen = '2024-08-24'
WHERE fmdtb = 'tabla1' AND fmsch = 'shema1' AND ftobjt
ip = 'tipoonjeto1' ;
--WHERE fmdtb = 'hola' AND fmsch = 'mundo' AND ftobjtip = 'cruel' AND fmobj='objeto1' AND ftobjcmn='comentario_obj1' AND fifld=11 AND fmfld='schema_dom1' AND fmschdom='schema_dom1' AND fmdom='dominio1' AND ftfldtIp='tipo_campo1' AND ftfldcmn='comentario_campo1'AND ftfil='filtro1'AND fvind ='v' AND fdgen='2024-08-24';
--------------------uso del update directamente 
UPDATE sc_pgl.tabla1
SET fmdtb = 'hola',fmsch = 'mundo' , ftobjtip = 'cruel'
WHERE fmdtb = 'tabla1' AND fmsch = 'schema1' AND ftobjtip = 'tipo_objeto1' ;
--------------------uso del delete directamente en la tabla
DELETE FROM sc_pgl.tabla1
WHERE fmdtb = 'tabla1' AND ftobjtip = 'tipo_objeto1' AND fdgen = '2024-08-24';
--delete direcyto
DELETE FROM sc_pgl.tabla1
WHERE fmdtb = 'hola' AND ftobjtip = 'cruel' AND fdgen = '2024-08-24';

--ver los cambios del update
SELECT * FROM sc_pgl.tabla1 WHERE fmdtb = 'hola' AND fmsch = 'mundo' AND ftobjtip = 'cruel';

--prueba para el delete
DELETE FROM sc_pgl.pglfldv2_obj_def
WHERE fmdtb ='hola' AND fmsch ='mundo'  AND ftobjtip ='cruel'  AND fdgen ='2024-08-24' ;
--ahora como se puede ver el delete,buena pregunta supongo con el select y buscar
UPDATE sc_pgl.pglfldv2_obj_def
SET fmdtb = 'hola',fmsch = 'mundo' , ftobjtip = 'cruel',
fmobj='de' , ftobjcmn = 'asembler', fifld = 1000, 
fmfld= 'que',fmschdom = 'mas', fmdom='agrego'
WHERE fmdtb ='hola'  AND fmsch ='mundo'  AND ftobjtip ='cruel'  AND fdgen = '2024-08-24';