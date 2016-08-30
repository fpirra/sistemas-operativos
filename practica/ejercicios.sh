
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

function ej5 {
	echo "Falta implementar"
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
	ej5
else
	echo "No selecciono ningun ejercicio."
fi


