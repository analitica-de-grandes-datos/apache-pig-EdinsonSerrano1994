/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- carga de datos
datos = LOAD 'data.tsv' USING PigStorage('\t') AS (
        letter:chararray, 
        tuples:bag{t:tuple(l_mins:chararray)}, 
        keys:map[]);

flattened = FOREACH datos GENERATE FLATTEN(keys) AS clave;

palabras = FOREACH flattened GENERATE $0 AS word;

agrupado = GROUP palabras BY word;

conteo = FOREACH agrupado GENERATE group, COUNT(words);

STORE conteo INTO 'output' USING PigStorage(',');