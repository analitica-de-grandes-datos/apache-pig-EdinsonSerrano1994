/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta en SQL.

   SELECT
       color
   FROM 
       u 
   WHERE 
       color 
   LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        /* >>> Escriba su respuesta a partir de este punto <<< */
*/

-- cargar datos
data = LOAD 'data.csv' USING PigStorage(',') AS (
        num_1:int,
        first_name:chararray,
        last_name:chararray,
        date:chararray,
        color:chararray,
        num_2:int);

colors = FOREACH data GENERATE color;

filtered_colors = FILTER colors BY color MATCHES 'b.*';

STORE filtered_colors INTO 'output' USING PigStorage(',');