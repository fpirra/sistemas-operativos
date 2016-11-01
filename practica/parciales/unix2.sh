#!/bin/bash
# Se reciben archivos en /input
# formato: sol_fact_aaaammdd, ej sol_fact_20160517
# id_servicio,id_cuenta, importe, region, fecha_vto

# servicios: /mae/segba.dat
# id_servicio, descripcion, region, porcentaje

# tarifa: /mae/tarifa_social.dat
# id_cuenta

#procesar archivos:
# validar nombre (fecha valida y anterior a la actual)

#c reg validar id_servicio + region existe grabar en /aceptados o /rechazados
# obtener nuevo archivo /resultado/nueva_fact_aaaammdd con
# id_servicio, id_cuenta, nuevo_importe, fecha_vto

# nuevo_importe = importe + importe * porcentaje
# si id_cuenta esta en tarifa social => porcentaje = 0

#$input="/input"
input="files/"
errores="errores/errores.txt"

for archivo in $(ls "$input" )
do
	count=$(echo $archivo | grep -c "sol_fact_[0-9]\{8\}")
	if [ $count -eq 0 ]; then
		echo "formato invalido: $archivo" #>> $errores
		#mv $archivo rechazados/
		continue
	fi
	fecha=$(echo $archivo | cut -d "_" -f3)
	hoy=$(date "+%Y%m%d")
	if [ "$fecha" -gt "$hoy" ]; then
		echo "fecha invalida" #>> /errores/errores.txt
		#mv $archivo rechazados/
		continue
	fi
	echo $fecha
	for reg in $(cat $archivo)
	do
		id_servicio=$(echo $reg | cut -d "," -f1)
		id_cuenta=$(echo $reg | cut -d "," -f2)
		importe=$(echo $reg | cut -d "," -f3)
		region=$(echo $reg | cut -d "," -f4)
		fecha_vto=$(echo $reg | cut -d "," -f5)
		serv=$(echo $reg | grep "^$id_servicio.*$region.*" "/mae/segba.dat")
		if [ -z $serv ]; then
			echo "No existe $id_servicio + $region" #>> /errores/errores.txt
			continue
		fi
		porcentaje=$(echo $serv | cut -d "," -f4)
		existe=$(echo $id_cuenta | grep -c "^$id_cuenta")
		if [ $existe -ne 0 ]; then
			porcentaje=0
		fi
		nuevo=$(echo "$importe + $importe * $porcentaje" | bc)
		echo "$id_servicio,$id_cuenta,$nuevo,$fecha_vto" >> "/resultado/nueva_fact_$fecha"
	done
	#mv $archivo aceptados/
done

