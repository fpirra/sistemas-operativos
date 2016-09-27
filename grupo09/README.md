# sistemas-operativos
75.08 Sistemas Operativos

Para descomprimir el paquete ejecutar
```
tar -xvf grupo09.tar.gz
```
Esto generara la carpeta grupo09 con todos los archivos necesarios para comenzar la instalacion.
* Los archivos son 5 ejecutables: INSTALEP INITEP DEMONEP LOGEP MOVEP
* Este README
* Una carpeta dirconf que contendra los archivos de configuracion

Los requisitos para poder utilizar el sistema son:
* Tener un sistema operativo Ubuntu 12.04 o superior
* Bash (Bourne Shell)
* Comandos: CAT, SED

**Pasos para instalar el sistema**
Ingresar a la carpeta ejecutando:
```
cd grupo09
```

**IMPORTANTE! EJECUTAR TODOS LOS SCRIPTS EN LA MISMA SESION DE BASH, NO GENERAR UNA NUEVA TERMINAL**
Por ejemplo, si tengo un script ejemplo.sh, se debe ejecutar
```
. ./ejemplo.sh
```
La instalación se realiza mediante la ejecución ordenada de los siguientes scripts:

* INSTALEP - Instalación
```
. ./INSTALEP
```
* INITEP - Configuración de variables de entorno
```
. ./INITEP
```
A partir de aquí, el sistema ya se encuentra instalado y se puede iniciar el proceso demonio DEMONEP
* DEMONEP - Proceso demonio que recibe archivos, los valida y los mueve de carpetas
```
. ./DEMONEP &
```
Notar el signo "&"

El comando DEMONEP se puede iniciar de dos formas:
* 1 El script INITEP ofrece iniciar el servicio, que de escoger Si a la opción, nos informa el Process ID
del proceso
* 2 Ejecutando el comando en "background" de la forma indicada:
```
. ./DEMONEP &
```
De esta forma, la terminal muestra un número, que es el Process ID con el cual se ejecutó el comando.

Si se desea detener el proceso demonio, se debe anotar este numero y cuando se desee terminar, ejecutar:
```
kill -15 (PID)
```
Donde PID es el numero anotado.
