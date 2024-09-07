--segunda transaccion de un archivo aparte para ver los cambios antes de la ejecucion
--segun san CHATGPT hay que usar dos archivos aparte para eso de las transacciones
-- Abrir transacción 1 con Repeatable Read
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Leer el valor inicial de fifld
SELECT fifld FROM sc_pgl.tabla2 WHERE fmdtb = 'Tabla1';
-- Resultado: 100

-- Actualizar el campo fifld
UPDATE sc_pgl.tabla2 SET fifld = 200 WHERE fmdtb = 'Tabla1';

commit;
-- <<<<<<<<<EL ERROR QUE SALE AL EJECUTAR LAS TRANSACCIONES ES EL SIGUEINTE:>>>>>>----
--ERROR:  transacción abortada, las órdenes serán ignoradas hasta el fin de bloque de transacción 

--SQL state: 25P02