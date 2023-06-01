/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

--cargar datos

datos = LOAD 'data.csv' USING PigStorage(',') AS (num_1:int, first_name:chararray, last_name:chararray, date:chararray, color:chararray, num_2:int);

apellidos = FOREACH datos GENERATE last_name;

filtrar_apellidos = FILTER apellidos BY SUBSTRING(last_name, 0, 1) MATCHES '[D-K]';

STORE filtrar_apellidos INTO 'output' USING PigStorage(',');