/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname, 
       color 
   FROM 
       u
   WHERE color NOT IN ('blue','black');

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        /* >>> Escriba su respuesta a partir de este punto <<< */


-- cargar datos

data = LOAD 'data.csv' USING PigStorage(',')
    AS (
            Id:int,
            Name:chararray,
            LastName:chararray,
            Birth:chararray,
            color:chararray,
            value:int
    );

Zoe_blue = FOREACH data GENERATE Name, color; 
variable = FILTER Zoe_blue by not color in ('blue','black');
STORE variable INTO 'output' USING PigStorage(',');