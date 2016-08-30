#!/bin/bash

function ej1 {
	echo $(date +"Son las %T del dia %e %n del mes %m del año %Y.")
}

function ej2 {
	nombre=$(date +"%Y-%m-%d-$1.tar.gz")
        echo $nombre
        tar -czvf $nombre $1
}

function ej3 {
	num=$1
        for i in {1..10}
        do
                mult=$(( i * num ))
                echo "$i * $num = $mult"
        done
}

function ej4 {
	num=$1
	if [ $(( $num % 101 )) -ne 0 ]; then
                echo "$num NO ES divisible por 101."
        else
                echo "$num es divisible por 101."
        fi
}

function ej6 {
	echo $$
	adivino=false
	cuenta=1
	while (! $adivino)
	do
		read intento
		if [ $intento -eq $$ ]; then
			echo "Adivinaste!"
			adivino=true
		elif [ $intento -lt $$ ]; then
			echo "nop... proba un numero mas grande"
			cuenta=$(( $cuenta + 1 ))
		else
			echo "nop... proba un numero mas chico"
			cuenta=$(( $cuenta + 1 ))
		fi
	done
	echo "Tardaste $cuenta intentos en adivinar el PID"
}

seguir=true
trap ctrl_c INT

function ctrl_c {
	echo "** Trapped CTRL-C"
	seguir=false
}

function ej7 {
	while ( $seguir )
	do
		echo "verificando si existe prueba.txt"
		if [ -f "prueba.txt" ]; then
			echo "EXISTE!"
		fi
		sleep 30
	done
}


if [ $# -eq 0 ]; then
	sel="nada"
else
	sel=$1
fi

if [ "$sel" == "1" ]; then
	ej1
elif [ "$sel" == "2" ]; then
	ej2 $2
elif [ "$sel" == "3" ]; then
	ej3 $2
elif [ "$sel" == "4" ]; then
	ej4 $2
elif [ "$sel" == "5" ]; then
	fecha=$(date +"%Y-%m-%d")
	lista=$(echo $fecha.lst)
	# No puede existir el archivo.
	if [ -f $lista ]; then
		echo "Ya existe un archivo $lista. Saliendo..."
		exit
	fi
	# Tienen que ser directorios todos.
	for var in "$@"
	do
		if [ ! -d $var ]; then
			echo "Un parametro ingresado no es un directorio. Saliendo..."
			exit
		fi
	done
	archivo=$(echo $fecha.tar.gz)
	tar -czvf $archivo $@ #> /dev/null 2> /dev/null
	for var in $@
	do
		echo $var >> $lista
	done
elif [ "$sel" == "6" ]; then
	ej6
elif [ "$sel" == "7" ]; then
	ej7
else
	echo "No selecciono ningun ejercicio."
fi


