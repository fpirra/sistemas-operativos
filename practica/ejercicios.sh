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

function ej8 {
	if [ ! -d $1 ]; then
		echo "El argumento pasado no es un directorio. Saliendo..."
		exit
	fi
	find $1 -type d
}


function ej9 {
	milis=$(date +"%s")
	nombre=$(echo stop_proceso_$milis.sh)
	pid=$$
	echo -e "kill -15 $pid\nrm $nombre" > $nombre
	chmod +x $nombre
	sleep 30
}

function ej10 {
	read n
	for (( i=1; i <= $n; i++ ))
	do
		append=""
		for (( j=1; j<= $i; j++ ))
		do
			append=$(echo $append $i)
		done
		echo $append
	done
}

function ej11 {
	if [ "$1" == "$2" -a "$2" == "$3" ]; then
		echo "Las tres son iguales"
	elif [ "$1" == "$2" -o "$1" == "$3" -o "$2" == "$3" ]; then
		echo "Solo dos son iguales"
	else
		echo "Son las tres distintas"
	fi
}

function ej12 {
	echo "Not implemented"
}

function ej13 {
	for var in $@
	do
		if [ -f $var ]; then
			cat $var
		elif [ -d $var ]; then
			ls $var
		fi
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
elif [ "$sel" == "8" ]; then
	ej8 $2
elif [ "$sel" == "9" ]; then
	ej9
elif [ "$sel" == "10" ]; then
	ej10
elif [ "$sel" == "11" ]; then
	if [ $# -ne 4 ]; then
		echo "Se necesitan tres palabras"
		exit
	fi
	ej11 $2 $3 $4
elif [ "$sel" == "12" ]; then
	ej12
elif [ "$sel" == "13" ]; then
	ej13 $@
else
	echo "No selecciono ningun ejercicio."
fi


