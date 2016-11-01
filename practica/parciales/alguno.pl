


# en /consumo_previsto hay 52 archivos de nombre resmas_xx (xx del 01 al 52 por semanas del año)
# oficina; tamaño_papel-gramaje; cantidad
# biblioteca;A4-82gr;4

# En /stock esta resmas_en_stock:
# tipo_papel; cantidad_resmas
# A4-82gr-210x297; 40000

# tipo_papel = tamaño_papel-gramaje-dimension

# validar que exista resmas_en_stock

# 2 params: semana inicio (1 al 52)
# par 2: semana fin (1 al 52)

# recibir solo 2 params, validarlos

# solicitar ingresar un tam de papel por STDIN y mostrar cual es el stock que hay
# sin importar gramaje (resmas_en_stock)
# si no existe en archivo, es error, pedir nuevo tam de papel.


# luego ver consumo previsto en cada oficina para ese tamaño de papel, sin importar gramaje
# SOLO PARA EL RANGO DE SEMANAS
# Si algun archivo da error, mostrar mensaje.

# usar hash para acumular cantidades
# grabar en "salida" tamaño_papel; semana <ini> a <fin>	;oficina;valor acumulado;

# ej: A4; semana 1 a 4; despacho; 33

$arch = "resmas_en_stock";

$valido = 0;
while ($valido == 0) {
	print "Ingrese tamaño de papel\n";
	$rta = <STDIN>;
	chomp($rta);
	open (RESMAS, "<$arch") or die "No existe archivo de resmas";
	while (my $reg = <RESMAS>) {
		chomp($reg);
		@camp = split /-/, $reg;
		if ($camp[0] eq $rta) {
			$valido = 1;
		}
	}
	close (RESMAS);
	if ($valido == 0) {
		print "Tam invalido\n";
	}
}

if (@ARGV != 2) {
	die "Se necesitan 2 params\n";
}
$ini = $ARGV[0];
$fin = $ARGV[1];

if ($ini < 1 or $ini > 52) {
	die "Semana $ini invalida. Debe ser del 1 al 52\n";
}

if ($fin < 1 or $fin > 52) {
	die "Semana $fin invalida. Debe ser del 1 al 52\n";
}

if ($fin <= $ini) {
	die "Semana $fin posterior a $ini\n";
}

%acum;
$dir = "files/resmas";
opendir(DIR, $dir) or die "fallo\n";
@archivos = readdir(DIR);
close(DIR);

foreach $arch (@archivos) {
	chomp($arch);
	next if ($arch eq '.' or $arch eq '..');
	@arch_camp = split /_/, $arch;
	if ($arch_camp[1] <= $fin and $arch_camp[1] >= $ini) {
		print "$arch arch valid\n";
		open(FILE, "<$dir/$arch") or die "no se puede abrir";
		while ($reg = <FILE>) {
			chomp($reg);
			@otr_camp = split /;/, $reg;
			@c_pap = split /-/, $otr_camp[1];
			print "papel: $rta\n";
			if ($c_pap[0] eq $rta) {
				if (exists($acum{$otr_camp[0]})) {
					$acum{$otr_camp[0]} += $otr_camp[2];
				} else {
					$acum{$otr_camp[0]} = $otr_camp[2];
				}
			}
		}
		close(FILE);
	}
}

open (OUT, ">salida") or die "No se puede escribir archivo";
foreach $keys (keys(%acum)) {
	# tamaño_papel; semana <ini> a <fin>	;oficina;valor acumulado;
	# A4; semana 1 a 4; despacho; 33
	print OUT "$rta;semana $ini a $fin;$keys;$acum{$keys}\n";
}

close (OUT);
