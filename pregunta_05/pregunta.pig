/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- cargar datos
datos = LOAD 'data.tsv' USING PigStorage('\t') AS (mayus:chararray, minus:chararray, claves:int); 

filtrar_datos = FOREACH datos GENERATE minus;

filtrar_minusculas = FOREACH filtrar_datos GENERATE FLATTEN(TOKENIZE(minus)) as letra; 

filtrar_letras = FILTER filtrar_minusculas BY (letra MATCHES '.*[a-z].*');

agrupar_letra = GROUP filtrar_letras BY letra; 

conteo_letras= FOREACH agrupar_letra GENERATE group, COUNT(filtrar_letras); 


STORE conteo_letras INTO 'output/' USING PigStorage(',');