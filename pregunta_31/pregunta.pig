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

´
-- cargar datos

datos = LOAD 'data.csv' USING PigStorage(',')
    AS (
            Id:int,
            Name:chararray,
            LastName:chararray,
            Birth:chararray,
            color:chararray,
            value:int
    );

datos = FOREACH datos GENERATE SUBSTRING(Birth,0,4) as year;
group_by = GROUP datos BY year;
contador = FOREACH group_by GENERATE group, COUNT($1);
STORE contador INTO 'output' USING PigStorage(',');