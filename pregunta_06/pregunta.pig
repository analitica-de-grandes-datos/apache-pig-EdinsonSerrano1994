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

data = LOAD 'data.tsv' USING PigStorage('\t') AS (
        letter:chararray, 
        tuples:bag{t:tuple(l_mins:chararray)}, 
        keys:map[]);

flattened = FOREACH data GENERATE FLATTEN(keys) AS clave;

words = FOREACH flattened GENERATE $0 AS word;

groupped= GROUP words BY word;

counted = FOREACH groupped GENERATE group, COUNT(words);

STORE counted INTO 'output' USING PigStorage(',');