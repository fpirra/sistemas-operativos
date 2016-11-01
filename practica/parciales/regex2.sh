#!/bin/bash

#precio de lista bruto de productos de la localidad
# dentro de datos de sesion de c/ navegante
# se pasan como unico parametro:
# id sesion | IP Origen | Reingreso | Localidad

# Solo una lista de precios en ListaDePrecios.dat

#mostrar: 'Lista de Precios: ' <identificador lista>
#		  Producto+<precio bruto>


localidad=$(echo "$1" | sed "s/[^|]*|[^|]*|[^|]*|\([^|]*\)/\1/")
#echo $localidad
archivo=$(grep "$localidad" "files/ListaDePrecios.dat" | sed "s/^\([^:]*\):.*/\1/")
#echo $archivo
sed "s/^\([^:]*\):[^:]*:\([^:]*\):.*/\1+\2/" "files/$archivo"