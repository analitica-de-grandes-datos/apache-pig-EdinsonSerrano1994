/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- cargar datos

data = LOAD 'data.csv' USING PigStorage(',') AS (
        num_1:int,
        first_name:chararray,
        last_name:chararray,
        date:chararray,
        color:chararray,
        num_2:int);

years =  FOREACH data GENERATE SUBSTRING(date, 0, 4) AS year;

grouped = GROUP years BY year;

count = FOREACH grouped GENERATE group, COUNT(years);

STORE count INTO 'output' USING PigStorage(',');