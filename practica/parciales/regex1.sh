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

