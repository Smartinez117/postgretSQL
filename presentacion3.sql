--presentacion 3 de base datos usando la extension earthdistance
--uso de las extension earthdistance para calcular la distancia entre diferentes ciudades usando su longitud y latitud


--primero habilitamos las extensiones para hacer las consultas despues.
CREATE EXTENSION IF NOT EXISTS cube;
CREATE EXTENSION IF NOT EXISTS earthdistance;

CREATE TABLE destinos_turisticos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    latitud FLOAT8,
    longitud FLOAT8
);

--agrego los datos
INSERT INTO destinos_turisticos (nombre, latitud, longitud) VALUES
('Torre Eiffel', 48.8588443, 2.2943506),
('Estatua de la Libertad', 40.689247, -74.044502),
('Machu Picchu', -13.163141, -72.544962),
('Gran Muralla China', 40.431908, 116.570374),
('Buenos Aires', -34.603684, -58.381559);

--ver los arreglos de las coordenadas de las ciudades
select * from destinos_turisticos;

--basta con cambiar las coordenas y la ciudad para calcular la distancia a cualquiera de las otras ciudades
SELECT nombre,
       earth_distance(ll_to_earth( -34.603684,-58.381559 ), 
                      ll_to_earth(latitud, longitud)) AS distancia_metros
FROM destinos_turisticos
WHERE nombre <> 'Buenos Aires'
ORDER BY distancia_metros;

--devolvera lo siguente:
--"Machu Picchu"	2781094.2359746704
--"Estatua de la Libertad"	8533974.332981458
--"Torre Eiffel"	11059636.62968651
--"Gran Muralla China"	19250787.796027128
