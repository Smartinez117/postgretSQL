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


--------------creacion de las rule para la table/view-------------------
--uso del insert para la view
CREATE RULE insertarEnVistaENpglfldv2_obj_def AS
ON INSERT TO sc_pgl.pglfldv2_obj_def
DO INSTEAD
INSERT INTO sc_pgl.pglfldv2_obj_def(
    fmdtb, fmsch, ftobjtip, fmobj, ftobjcmn, fifld, fmfld,
    fmschdom, fmdom, ftfldtip, ftfldcmn, ftfil, fvind, fdgen)
VALUES (
    NEW.fmdtb, NEW.fmsch, NEW.ftobjtip, NEW.fmobj, NEW.ftobjcmn, NEW.fifld, NEW.fmfld,
    NEW.fmschdom, NEW.fmdom, NEW.ftfldtip, NEW.ftfldcmn, NEW.ftfil, NEW.fvind, NEW.fdgen);
----------------------------------------------------
--caso del update para la view
CREATE RULE updateENpglfldv2_obj_def AS
ON UPDATE TO sc_pgl.pglfldv2_obj_def
DO INSTEAD
UPDATE sc_pgl.pglfldv2_obj_def
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
-----------------------------------------------------------------
--caso para el delete
CREATE RULE deleteENpglfldv2_obj_def AS
ON DELETE TO sc_pgl.pglfldv2_obj_def
DO INSTEAD
DELETE FROM sc_pgl.pglfldv2_obj_def
WHERE fmdtb = OLD.fmdtb AND ftobjtip = OLD.ftobjtip AND fdgen = OLD.fdgen;
--