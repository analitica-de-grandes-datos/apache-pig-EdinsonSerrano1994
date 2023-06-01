/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- cargar datos
datos = LOAD 'data.tvs' USING PigStorage('\t') AS (letter:chararray, date:chararray, value: int);

datos_letter = FOREACH datos GENERATE letter;

-- agrupar registros

agrupado = GROUP datos_letter BY letter;

conteo = FOREACH agrupado GENERATE group, COUNT(datos_letter);

-- generar archivo de salida

iSTORE conteo INTO 'output USING PigStorage(',');