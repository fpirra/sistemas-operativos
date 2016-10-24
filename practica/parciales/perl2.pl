#!/bin/perl


# Dos params: id expectador y dir input
# validar

my $id_exp = shift @ARGV or die "Falta expectador ID\n";
my $dir_input = shift @ARGV or die "Falta directorio\n";
my $extra = shift @ARGV;
if (defined ($extra)) {
	die "Solo deben ser dos parametros\n";
}

if (! -d $dir_input) {
	die $dir_input . " no es un directorio\n";
}

%peliculas;

open (PELICULAS, "</catalogo/peliculas.mae") or die "No existe el archivo de peliculas\n";
while ($registro = <PELICULAS>) {
	chomp $registro;
	my @campos = split /:/, $registro;
	my @generos = split /-/, $campos[6]
	$peliculas{$campos[0]} = $generos[0];
}
close (PELICULAS);

@espectadores = dir <"$dir_input/*.dat">;
$espectadores -gt 0 or die "No hay archivos para leer";


%entradas;
foreach my $archivo (@espectadores) {
	open (INPUT, "<$archivo") or die "No pudo abrirse archivo: " . $archivo . "\n";
	while ($reg = <INPUT>) {
		chomp($reg);
		my @campos = split /:/, $reg;
		if ($campos[1] == $id_exp) {
			my $genero = $peliculas{$campos[2]} or "indeterminado";
			if (exists($entradas{$genero})) {
				$entradas{$genero} = $entradas{$genero} + $campos[5];
			} else {
				$entradas{$genero} = $campos[5];
			}
		}
	}
	close(INPUT);
}

foreach my $key (%entradas) {
	print "Clave = $key  - Cantidad = $entradas{$key}";
}

$rta = read "Desea guardar en archivo?\n";
if ($rta = "s") {
	open(SALIDA, ">/output/$id_exp.txt") or die "No se puede escribir archivo";
	foreach my $key (%entradas) {
		print SALIDA "Clave = $key  - Cantidad = $entradas{$key}";
	}
	close(SALIDA);
}


