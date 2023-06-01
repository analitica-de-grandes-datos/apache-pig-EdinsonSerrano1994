/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- cargar datos

datos = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letra:chararray,
            fecha:chararray,
            num:int          
        );

-- Agrupar
agrupado= ORDER datos BY num asc; 

filtrar_agrupado = FOREACH agrupado GENERATE num; 

grupo = LIMIT filtrar_agrupado 5;

STORE grupo INTO 'output/' USING PigStorage(',');