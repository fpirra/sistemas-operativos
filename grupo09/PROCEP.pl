#!/usr/bin/perl

#Si el ambiente no fue inicializado, no ejecutar
#Mostrar mensaje adecuado y terminar el programa
$ENV{'VAR_INITEP'} = true;
$ENV{'DIRREC'} = 'nov';

if(!defined $ENV{'VAR_INITEP'}) {
    die "El ambiente no fue inizializado. Ejecute INITEP"
}

#Grabar en log
#Cantidad de archivos a procesar:<cantidad>

@archivo_para_procesar = glob($ENV{'DIRREC'});



#ciclar archivos

#ANTES DE PROCESAR UN ARCHIVO, VERIFICAR QUE NO ESTA DUPLICADO
#Cada vez que se procesa un archivo, se lo mueve tal cual fue recibido y con el mismo nombre a
#DIRPROC/proc/<nombre del archivo>
#Es por ello que es posible detectar antes de intentar procesar un archivo si ya fue procesado solo
#inspeccionando el contenido de ese directorio. Si ya fue procesado, rechazar el archivo completo y
#grabar en el log un mensaje aclaratorio, como ser:
#Archivo Duplicado. Se rechaza el archivo <nombre del archivo>
#El archivo duplicado se lo mueve a DIRNOK empleando la función Movep.


#ANTES DE PROCESAR UN ARCHIVO, VERIFICAR EL FORMATO
#A efectos de este TP, bastara con verificar el primer registro para determinar si el formato es
#correcto.
#Si la cantidad de campos del primer registro no se corresponde con el formato establecido, asumir
#que el archivo está dañado, rechazar el archivo completo y grabar en el log un mensaje aclaratorio,
#como ser:
#Estructura inesperada. Se rechaza el archivo <nombre del archivo>.
#El archivo rechazado se lo mueve a DIRNOK empleando la función Movep.


#VALIDAR LOS CAMPOS DE LA SIGUIENTE FORMA
#Grabar en log
#Archivo a procesar <nombre del archivo>.
#Validación Centro de Presupuesto: El centro de presupuesto debe existir en el maestro de centros
#Validación de Actividad: La actividad debe existir en el maestro de actividades
#Validación Trimestre: El trimestre debe existir en la tabla de trimestres y el trimestre debe ser del año
#presupuestario corriente
#Validación de Fecha: la fecha indicada en el registro debe ser una fecha valida; menor o igual a la
#fecha del nombre del archivo y estar comprendida entre la fecha de inicio del trimestre
#(FDESDE_TRI) y la fecha de fin del trimestre (FHASTA_TRI)
#Validación de Gasto: el importe de gasto debe ser mayor a cero.
#NOTA: si detecta otro tipo de error clasificable, puede incluir su validación

#PROCESAR ARCHIVO

    #GRABAR REGISTRO RECHAZADO
    #Si el registro NO supera estas validaciones se debe rechazar solo ese registro y grabar en el archivo
    #anual con registros rechazados (DIRPROC/rechazado-<año presupuestario>) un registro con la
    #estructura indicada.
    #Nota: al menos considerar describir los siguientes motivos de rechazo:
    # Centro inexistente
    # Actividad inexistente
    #Universidad de Buenos Aires
    #Facultad de Ingeniería
    #Segundo Cuatrimestre 2016
    #Trabajo Práctico de Sistemas Operativos
    #Curso Martes
    #Grupo: nn Página 4 de 12
    # Trimestre invalido
    # Fecha invalida
    # La fecha no se corresponde con el trimestre indicado
    # Importe invalido
    # Cualquier otro motivo que considere adecuado
    #Incrementar en uno el contador de registros rechazados.
    #Al finalizar el proceso grabar en el log la cantidad de registros rechazados.



    #GRABAR REGISTRO VALIDADO
    #Si el registro supera estas validaciones se debe grabar en el archivo anual con presupuesto
    #ejecutado (DIRPROC/ejecutado-<año presupuestario>) un registro con la estructura indicada.
    #Incrementar en uno el contador de registros validados ok.
    #Al finalizar el proceso grabar en el log la cantidad de registros validados ok.

#FIN ARCHIVO
# MOVER ARCHIVO PROCESADO
#Cuando se termina de procesar el archivo, para evitar su reprocesamiento, se debe mover el
#archivo procesado a DIRPROC/proc/<nombre del archivo> empleando la función Movep.
# GRABAR TOTALES POR ARCHIVO EN LOG
#Cuando se termina de procesar el archivo, registrar en el log la cantidad de registros leidos,
#cuantos fueron rechazados y cuantos validaron bien
# Continuar con el siguiente archivo



#No debe procesar dos veces un mismo archivo
#Mueve los archivos a través del Movep
#Graba en el archivo de Log a través del Logep

#Graba los registros validos en un archivo de salida

#Graba los registros rechazados en un archivo de rechazos indicando su motivo