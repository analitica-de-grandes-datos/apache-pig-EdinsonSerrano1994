/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname 
   FROM 
       u 
   WHERE 
       SUBSTRING(firstname, 0, 1) >= 'm';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

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

birthday = FOREACH datos GENERATE Name;
filtrar = FILTER birthday BY ((SUBSTRING(Name,0,1))>='M');
STORE filtrar INTO 'output' USING PigStorage(',');