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

print "Ingrese el directorio, donde se guardaran los reportes:";
$dir_reportes = <STDIN>;
chomp($dir_reportes);
if (! -d $dir_reportes){
	mkdir $dir_reportes;
}

%sucursales_diccionario;
open(SUCURSALES, $sucursales) || die "Error al abrir archivo de sucursales";
@registros_sucursales = <SUCURSALES>;
foreach $registro (@registros_sucursales){
	@sucursalydetalle = split(";", $registro);
	if ( $sucursalydetalle[2] eq "Argentina" ){ # Chequeo que sea de argentina
		$cuit = substr($sucursalydetalle[1], 0, 12); # Los primeros 12 caracteres, para el CUIT
		@array_to_save = ($cuit, $sucursalydetalle[3]);
		$sucursales_diccionario{$sucursalydetalle[0]} = [@array_to_save];  #armo un diccionario que tiene el nombre de sucursal de clave y como valor el tipo de cambio
	}
}
close(SUCURSALES);

opendir (DIR, $directorio);
@archivos_en_directorio = readdir(DIR);
closedir (DIR);

foreach $archivo (@archivos_en_directorio){
	next if ($archivo eq "." || $archivo eq ".."); # Esto es para que ignore los primeros puntos por el directorio
	chomp($archivo); # Le saco el /n si es que lo tiene

	@nombre_del_archivo = split("_", $archivo); 
	@fechayextension = split('\.', $nombre_del_archivo[1]);
	if ($fechayextension[1] ne "dat"){
		print "Extension incorrecta, archivo no procesado \n";
		next;
	}
	if (index($fechayextension[0],$anio,0) ne 0){
		print "Anio incorrecto, archivo no procesado \n";
		next;
	}

	#Para ingresar en un diccionario, uso llaves
	#Si existe no existe la sucursal en el diccionario, salteo el archivo
	if (! exists($sucursales_diccionario{$nombre_del_archivo[0]}) ){
		next;
	}

	my %hash; 
	open(ARCHIVO,"<nov/$archivo") || die "Error al abrir el archivo";
	@registros_archivo = <ARCHIVO>;	
	foreach $registro (@registros_archivo){
		chomp($registro); # Le saco el /n si es que lo tiene
		@campos_del_registro = split(";", $registro);
		@subcampos_del_registro = split(",", $campos_del_registro[0]);
		$hash{$subcampos_del_registro[1]} = $hash{$subcampos_del_registro[1]} + $campos_del_registro[1] * $campos_del_registro[2];
	}
	$nombre_reporte = $sucursales_diccionario{$nombre_del_archivo[0]}[0] . "_" . $fechayextension[0] ;
	open(REPORT, ">" . $dir_reportes . "/" . $nombre_reporte) || die "Error al abrir el archivo de reporte";
	foreach $key (keys(%hash)) {
		print REPORT $key . " # " . $hash{$key} . " # " . ($hash{$key} / $sucursales_diccionario{$nombre_del_archivo[0]}[1]) . " # " . $ENV{"LOGNAME"} . "\n";
	}
	close REPORT; 
}






