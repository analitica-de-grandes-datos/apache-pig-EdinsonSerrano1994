/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- cargar datos
datos = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            mayus:chararray,
            minus:chararray,
            claves:chararray          
        ); 

separar_datos = FOREACH datos GENERATE mayus, FLATTEN(TOKENIZE(minus,',')) as minu, FLATTEN(TOKENIZE(claves,',')) as clave; 

limpiar_datos = FOREACH separar_datos GENERATE REPLACE (minu,'([^a-zA-Z\\s]+)','') as minu, REPLACE (clave,'([^a-zA-Z\\s]+)','') as clave;

tuple_data = FOREACH limpiar_datos GENERATE TOTUPLE(minu,clave) as tupla; 

agrupar_datos = GROUP tuple_data BY tupla; 

conteo_datos = FOREACH agrupar_datos GENERATE group, COUNT(tuple_data); 


STORE conteo_datos INTO 'output/' USING PigStorage(',');