#!/usr/bin/perl

if (@ARGV < 2){
	die "Los parametros son insuficientes, por favor ejecute nuevamente indicando año y directorio"
}

$anio = $ARGV[0];
$directorio = $ARGV[1];
$sucursales = "mae/sucursales.txt";

if (!-d $directorio){    
	die "El directorio no existe o es incorrecto";
}

if (!-f $sucursales){
	die "El archivo maestro de sucursales no existe o es incorrecto";
}

#TODO: Chequear que sucursal existe en sucursales.txt, pais=Argentina, y el anio igual al del primer parametro

opendir (DIR, $directorio);
@archivos_en_directorio = readdir(DIR);
closedir (DIR);

foreach $archivo (@archivos_en_directorio){
	next if ($archivo eq "." || $archivo eq ".."); # Esto es para que ignore los primeros puntos por el directorio
	chomp($archivo); # Le saco el /n si es que lo tiene
	my %hash; 

	@campos_del_archivo = split("_", $archivo); 
	@fechayextension = split('\.', $campos_del_archivo[1]);
	if ($fechayextension[1] ne "dat"){
		print "Extension incorrecta, archivo no procesado \n";
		next;
	}
	if (index($fechayextension[0],$anio,0) ne 0){
		print "Anio incorrecto, archivo no procesado \n";
		next;
	}

	open(ARCHIVO,"nov/$archivo") || die "Error al abrir el archivo";
	@registros_archivo = <ARCHIVO>;
	foreach $registro (@registros_archivo){
		chomp($registro);
		print "$registro\n";
		#aca hay que seguir... quien te conoce papa
	}
}


