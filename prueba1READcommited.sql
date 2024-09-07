--presentacion dos para base de datos.
--Dar ejemplo de lo que ocurre cuando hay dos transacciones simultáneas y
--tienen diferentes niveles de aislamiento"
--primero creo una tabla para para hacer las pruebas de las transacciones
CREATE TABLE sc_pgl.tabla2 (
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

----------------------------------------------------------------
--agrego unos datos a la tabla2 
INSERT INTO sc_pgl.tabla2 (fmdtb, fmsch, ftobjtip, fmobj, ftobjcmn, fifld, fmfld, fmschdom, fmdom, ftfldtip, ftfldcmn, ftfil, fvind, fdgen)
VALUES
('Tabla1', 'Esquema1', 'Tipo1', 'Objeto1', 'Comentario1', 100, 'Campo1', 'EsquemaDom1', 'Dominio1', 'TipoCampo1', 'ComentarioCampo1', 'Archivo1', 'S', '2024-01-01'),
('Tabla2', 'Esquema2', 'Tipo2', 'Objeto2', 'Comentario2', 200, 'Campo2', 'EsquemaDom2', 'Dominio2', 'TipoCampo2', 'ComentarioCampo2', 'Archivo2', 'N', '2024-01-02');
--veo los datos subidos a la tabla 2
select * from sc_pgl.tabla2
---------------------------------------------------------------_

-- Abrir transacción 1 con Read Committed
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Leer el valor inicial de la columna fifld
SELECT fifld FROM sc_pgl.tabla2 WHERE fmdtb = 'Tabla1';
-- Resultado: 100

-- Actualizar el campo fifld
UPDATE sc_pgl.tabla2 SET fifld = 150 WHERE fmdtb = 'Tabla1';

commit;
------------------------------------------
