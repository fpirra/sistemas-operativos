#!/bin/bash

# Recibe codigo de localidad
# Recibe Numero de Orden

#Muestra Nombre partido politico-votos

# Eleccion.Result
#		1		  3				5				6			8
# codigo loc : nombre loc : numero orden : cant votos : nombre pp 

#ej echo 55 | resultado.sh

input=$(grep ".*")
codigo=$(echo $input | sed "s/\([^ ]*\) .*/\1/")
orden=$(echo $input | sed "s/[^ ]* \([^ ]*\)/\1/")

reg=$(grep "^$codigo:[^:]*:[^:]*:[^:]*:[^:]*:$orden.*" "files/Eleccion.Result")
nombre=$(echo $reg | sed "s/[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:\([^:]*\)/\1/")
votos=$(echo $reg | sed "s/[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:\([^:]*\):.*/\1/")
echo $nombre-$votos



#--------------Otra resolucion--------------


input=$(grep ".*")

codigo_localidad=$(echo $input | sed "s/\([^ ]*\) .*/\1/")

num_orden=$(echo $input | sed "s/[^ ]*\s*\([^ ]*\).*/\1/")

registro_elegido=$(grep "^$codigo_localidad:[^:]*:[^:]*:[^:]*:$num_orden:.*" "files/Eleccion.Result")

resultado=$(echo $registro_elegido | sed "s/^$codigo_localidad:[^:]*:[^:]*:[^:]*:\([^:]*\)*:\([^:]*\)/\2-\1/")

echo $num_orden
