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
data = LOAD 'data.tsv' USING PigStorage('\t') AS (letter:chararray, date:chararray, value:int);

letter_data = FOREACH data GENERATE letter;

-- agrupa los registros
grouped = GROUP letter_data BY letter;

count = FOREACH grouped GENERATE group, COUNT(letter_data);

-- escribe el archivo de salida 
STORE count INTO 'output' USING PigStorage(',');