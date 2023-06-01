/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
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

mes_datos = FOREACH datos GENERATE REGEX_EXTRACT(birth,'(.*)-(.*)-(.*)',2) as month;


STORE mes_datos INTO 'output/' USING PigStorage(',');