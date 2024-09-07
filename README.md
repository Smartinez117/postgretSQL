ALGO DE TEORIA PARA LO DE LAS TRANSACCIONES
ERROR: transacción abortada, las órdenes serán ignoradas hasta el fin de bloque de transacción (SQL state: 25P02).


Este error ocurrió porque la segunda transacción intentó modificar un registro que estaba en conflicto con la primera transacción, 
que ya había confirmado cambios (o en proceso de hacerlo). Al hacer COMMIT en la primera transacción, se liberaron los cambios, 
y ahora la segunda transacción está en una situación conflictiva, pues intentó actualizar el mismo campo que ya fue modificado y confirmado por otra transacción. 
PostgreSQL evita este tipo de conflictos mediante el control de concurrencia.


Explicación del Error (SQL State 25P02):
El SQL state 25P02 es un error de "transacción abortada". Esto significa que una de tus transacciones no pudo completarse debido a un conflicto de aislamiento.
Cuando dos transacciones intentan modificar el mismo registro, la segunda que intente hacerlo puede recibir este error si la primera ya confirmó los cambios. 
Como las transacciones en modo Repeatable Read y Serializable aseguran consistencia, PostgreSQL aborta la segunda transacción para evitar inconsistencias.


3. Detalle del Comportamiento por Nivel de Aislamiento:
   
READ COMMITTED: En este nivel de aislamiento, cada transacción solo ve los cambios confirmados.
Si haces COMMIT en la primera transacción, los cambios son visibles para las transacciones futuras.
Si una segunda transacción intenta acceder a los mismos datos antes de que la primera haga COMMIT, puede quedar en espera (como en tu caso).


REPEATABLE READ: Garantiza que si una transacción lee un valor, este valor no cambiará mientras la transacción esté activa. 
Si una transacción intenta actualizar un registro que otra transacción ya modificó (pero no ha hecho COMMIT), entrará en un estado de espera. 
Si la primera transacción hace COMMIT, la segunda transacción fallará si hay conflicto.


NOTAS ADICIONALES:
EN EL ARCHIVO PRUEBA2408.SQL EN LA LINEA 78 AL 84 ESTA EL CODIGO PARA EL EJEMPLO DEL INSERT.
captura de la ejecucion exitosa del insert en la tabla. (PRESENTACION 1)

![Captura de pantalla 2024-09-07 163104](https://github.com/user-attachments/assets/24418a6c-2a9e-4fa2-bdad-08c6657a90a7)

captura de pantalla del error de las transacciones (PRESENTACION 2)

![Captura de pantalla 2024-09-07 161641](https://github.com/user-attachments/assets/ee9d4e71-6c99-45d9-b4b6-26b336df0d36)

nota final: no tengo idea de si se pueden ver las imagenes, cson capturas para poder agregar a la presentacion,SI no se ven avisame asi te las paso directo, pero aca ya estaria archivado asique es mas facil.
