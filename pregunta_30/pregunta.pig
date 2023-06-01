/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- cargar datos

datos = LOAD 'data.csv' USING PigStorage(',') AS (
        num_1:int,
        first_name:chararray,
        last_name:chararray,
        date:chararray,
        color:chararray,
        num_2:int);

formato_fecha = FOREACH datos GENERATE date, 
                ToString(ToDate(date, 'yyyy-MM-dd'), 'dd') AS day, 
                ToString(ToDate(date, 'yyyy-MM-dd'), 'd') AS day_s,
                LOWER(ToString(ToDate(date, 'yyyy-MM-dd'), 'EEEE')) AS day_name;
                
reemplazar_mes =FOREACH formato_fecha GENERATE date,
                day,
                day_s,
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(day_name, 'sunday', 'domingo'), 'monday', 'lunes'),
                    'tuesday', 'martes'),'wednesday','miercoles'),'thursday','jueves'),'friday','viernes'),'saturday','sabado') AS name_long;
                 
final_formato = FOREACH reemplazar_mes GENERATE date, day, day_s,
                SUBSTRING(name_long, 0, 3) AS day_short, name_long;

STORE final_formato INTO 'output' USING PigStorage(',');