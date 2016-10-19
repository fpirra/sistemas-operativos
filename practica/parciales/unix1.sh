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

for archivo in $(ls $HOME/arribos)
do
	cumple_formato=$(echo $archivo | grep -c "[^\.]*\.[0-9]{6}\.txt")
	if [ cumple_formato -eq 0 ]; then
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