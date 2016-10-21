#!/bin/bash

# dir $HOME/arribos tiene archivos:
# pto_vta.mes.txt
# ej: centro.201105.txt con info.
# nro_factura,id_modem,fecha,cantidad

#archivo /mae/MODEMS.DAT
# id_modem,descripcion_modem,id_gama,importe
# 453,HUAWEI A22,1,589.10


#archivo /mae/GAMA.DAT
# id_gama,descripcion_gama,descuento_gama
# 1,Wi-Fi,0.10

# Script bash que procese archivos
# genere salida archivo: /resultados/facturas.txt:
# nro_factura|id_modem|fecha|importe_total

#importe_total = importe * descuento_gama * cantidad

#no se puede obtener importe o descuento_gama => escribir en /errores/errores.txt
# no procesar cantidad > 10 => /errores/errores.txt



#!/bin/bash
arribosdir=mae/arribos
modemsdir=mae/MODEMS.DAT
gamadir=mae/GAMA.DAT
errores=errores/errores.txt
resultados=resultados/facturas.txt

for archivo in $(ls $arribosdir) 
do
	extension=$(echo $archivo | cut -d '.' -f2) # Esto me da, con f2, el segundo elemento separado por .
	if [ "$extension" != "txt" ]; then 
		echo "El archivo tiene formato incorrecto"
		continue #Si el archivo no es txt, lo saltea
	fi
	for registro in $(cat $arribosdir/$archivo)
	do
		nro_factura=$(echo $registro | cut -d ',' -f1)
		id_modem=$(echo $registro | cut -d ',' -f2)
		fecha=$(echo $registro | cut -d ',' -f3)
		cantidad=$(echo $registro | cut -d ',' -f4)

		if [ $cantidad -gt 10 ]; then
			echo "El registro supera la cantidad aceptada"
			# El > si el archivo existe lo pisa, sino lo crea
			# El >> si el archivo existe le "appendea" la cadena, sino tambien lo crea
			echo "$registro # Cantidad maxima superada" >> $errores
			continue
		fi

		# Busco el importe, en MODEM.DAT | busco el id_gama en MODEM.DAT
		importe=$(cat $modemsdir | grep "^$id_modem" | cut -d ',' -f4)	
		id_gama=$(cat $modemsdir | grep "^$id_modem" | cut -d ',' -f3)	
		# -z se pone adelante, y chequea si es vacio (por si el registro no existia)
		if [ -z $importe  ]; then
			echo "No se encuentra el modem"
			echo "$registro # Modem no encontrado" >> $errores
			continue
		fi

		# Busco el descuento, en GAMA.DAT. En base al id_gama que saque de MODEM.DAT
		descuento=$(cat $gamadir | grep "^$id_gama" | cut -d ',' -f3)		
		# -z se pone adelante, y chequea si es vacio (por si el registro no existia)
		if [ -z $descuento  ]; then
			echo "No se encuentra el descuento"
			echo "$registro # Descuento no encontrado" >> $errores
			continue
		fi

		importe_total=$(echo ($importe*$descuento*$cantidad) | bc) 
		echo "$nro_factura | $id_modem | $fecha | $importe_total" >> $resultados
	done
done


#------------------Otra resolucion-----------------------------------------




for archivo in $(ls $HOME/arribos)
do
	cumple_formato=$(echo $archivo | grep -c "[^\.]*\.[0-9]{6}\.txt")
	if [ $cumple_formato -eq 0 ]; then
		mv $HOME/arribos/$archivo "errores/"
	fi
	for registro in $(cat $archivo)
	do
		factura=$(echo $registro | cut -d "," -f1)
		id_modem=$(echo $registro | cut -d "," -f2)
		fecha=$(echo $registro | cut -d "," -f3)
		cantidad=$(echo $registro | cut -d "," -f4)
		if [ cantidad -gt 10 ]; then
			echo $registro >> "/errores/errores.txt"
			continue
		fi
		reg_modem=$(grep "^$id_modem.*" "/mae/MODEMS.dat")
		if [ -z $importe ]; then
			echo "no se pudo obtener importe de id_modem = $id_modem" >> "/errores/errores.txt"
			continue
		fi
		gama=$(echo $reg_modem | cut -d "," -f3)
		importe=$(echo $reg_modem | cut -d "," -f4)
		reg_dcto=$(grep "^$gama" "/mae/GAMA.dat")
		if [ -z $reg_dcto ]; then
			echo "no se pudo obtener gama de id_gama = $gama" >> "/errores/errores.txt"
			continue
		fi
		dcto=$(echo $reg_dcto | cut -d "," -f3)
		total=$(echo "$cantidad * $importe * dcto" | bc)
		echo "$factura|$id_modem|$fecha|$total" >> "resultados/facturas.txt"
	done
done