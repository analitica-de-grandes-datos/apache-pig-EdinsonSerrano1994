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
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

-- cargar datos

datos = LOAD 'data.csv' USING PigStorage(',')
    AS (
            index:int,
            name:chararray,
            lastn:chararray,
            birth:chararray,
            color:chararray,
            num:int          
        ); 

color_datos = FILTER datos BY STARTSWITH(color,'blue') AND STARTSWITH(name,'Z'); 

seleccionar_datos = FOREACH color_datos GENERATE CONCAT(name,' ',color); 

STORE seleccionar_datos INTO 'output/' USING PigStorage(',');
