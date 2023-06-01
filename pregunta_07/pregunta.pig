/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' USING PigStorage('\t') AS (
        letter:chararray, 
        tuples:bag{t:tuple(l_mins:chararray)}, 
        keys:map[]);

tamano_data = FOREACH datos GENERATE letter, SIZE(tuples), SIZE(keys);

ordenar_datos = ORDER tamano_data BY $0, $1, $2 ASC;

STORE ordenar_datos INTO 'output' USING PigStorage(',');