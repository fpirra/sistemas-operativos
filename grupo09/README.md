# sistemas-operativos
75.08 Sistemas Operativos

Para descomprimir el paquete ejecutar
```bash
tar -xvf grupo09.tar.gz
```
Esto generara la carpeta grupo09 con todos los archivos necesarios para comenzar la instalacion.
* Los archivos son 6 ejecutables: INSTALEP INITEP DEMONEP LOGEP MOVEP PROCEP
* Este README
* Una carpeta dirconf que contendra los archivos de configuracion

Los requisitos para poder utilizar el sistema son:
* Tener un sistema operativo Ubuntu 12.04 o superior
* Bash (Bourne Shell)
* Comandos: CAT, SED

**Pasos para instalar el sistema**

Ingresar a la carpeta ejecutando:
```bash
cd grupo09
```

La instalación se realiza mediante la ejecución ordenada de los siguientes scripts:

1. INSTALEP - Instalación
```bash
./INSTALEP
```
Aquí se le pedirá el ingreso de directorios de configuración para poder crear la estructura.
Debe seguir los pasos y finalizar la instalación.

**IMPORTANTE: NO MOVER DE NINGUN LADO NINGÚN ARCHIVO! SI SE MUEVE DE LUGAR INSTALEP, INITEP, DEMONEP, PROCEP, LOGEP O MOVEP NO SE GARANTIZA EL CORRECTO FUNCIONAMIENTO DEL SISTEMA**

En caso de que detecte malfuncionamiento, descomprimir el paquete de vuelta y empezar la instalación desde cero.

Si desea realizar la instalación nuevamente puede:
** Eliminar el archivo INSTALEP.conf que se encuentra en el directorio dirconf.
** Eliminar la carpeta entera y descomprimir nuevamente el paquete de instalación.
Y volver a instalar.

2. INITEP - Configuración de variables de entorno
Luego de haber instalado, debe entrar en la carpeta especificada en la instalación, por defecto la llamaremos bin, si usted eligió nombrarla de otra manera reemplace "bin" por el nombre que usted haya ingresado.
Aquí se encuentran todos los ejecutables del sistema para que funcione.
```bash
cd bin
```
Ahora ejecutar INITEP.

**IMPORTANTE: Este es el único script que requiere una forma de ejecución distinta a los demás scripts.**
**Notar que la ejecución tiene dos puntos ". ./INITEP" y no sólo uno**
```bash
. ./INITEP
```
A partir de aquí, el sistema ya se encuentra iniciado y puede comenzar a procesar archivos.
Para esto hay que iniciar el proceso que estará esperando que ingresen nuevos archivos a procesar
3. DEMONEP - Proceso demonio que recibe archivos, los valida y los mueve de carpetas
```bash
./DEMONEP &
```
Notar el signo "&"

El comando DEMONEP se puede iniciar de dos formas:
⋅⋅1. El script INITEP ofrece iniciar el servicio, que de escoger Si a la opción, nos informa el Process ID
del proceso
⋅⋅2. Ejecutando el comando en "background" de la forma indicada:
```bash
./DEMONEP &
```
De esta forma, la terminal muestra un número, que es el Process ID con el cual se ejecutó el comando.

Si se desea detener el proceso demonio, se debe registrar el Process ID y cuando se desee terminar, ejecutar:
```bash
kill -15 PID
```
Donde PID es el Process ID indicado.
