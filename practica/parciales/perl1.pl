# arch separados por ;


# SALDINIC nombre cuenta, numero cuenta, saldo inicial,

# Caja; 1010; 1234,56

# N archivos (*.mov) con:  numero cuenta, fecha movimiento, debito, credito

# 1010; 27-10-13;1.23;0

# Si archivo de salida existe, reemplazar.
# Si archivo de salida no existe, crear

# Se llama con 2 parametros

# Invocacion: perl perl1.pl dirsaldinic archivo_salida

%acumulado;

@archivos = <*.mov>
foreach $archivo (@archivos) {
	open(ENTRADA, "<$archivo");
	while ($registro = <ENTRADA>) {
		@separado = split(/;/, $registro);
		$cuenta = separado[0];
		$debito = separado[2];
		$credito = separado[3];
		$suma = $debito - $credito;
		if (exists($acumulado{$cuenta})) {
			$acumulado{$cuenta} += $suma;
		} else {
			$acumulado{$cuenta} = $suma;
		}
	}
	close(ENTRADA);
}
print "modificaciones\n";
foreach $cuenta (keys(%acumulado)) {
	print $cuenta . ":" . $acumulado{$cuenta};
}
print "Guardar modificaiones? (S/N)";
$respuesta = <STDIN>;
chomp($respuesta);
if ($respuesta eq "N") {
	exit 0;
}

if ($#ARGV + 1 != 2) {
	print "param invalidos\n";
	exit 1;
}

($dir, $archivo) = @ARGV;
$ruta = $dir . "/saldinic";
if (! -f $ruta) {
	print "no existe el archivo\n";
	exit 1;
}

open (SALDINIC, "<$ruta");
open (SALIDA, "$>$archivo");

while ($registro = <SALDINIC>) {
	@campos = split /;/, $registro;
	$total = $campos[2];
	if (exists($acumulado{$campos[0]})) {
		$total += $acumulado{$campos[0]};
	}
	print SALIDA $campos[0] . ";" . $campos[1] . ";" . $total . "\n";
}
close(SALDINIC);
close(SALIDA);


