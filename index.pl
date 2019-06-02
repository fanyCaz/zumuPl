#!C:/Strawberry/perl/bin/perl.exe
#MODULOS
use strict;
use POSIX qw/strftime/;
use Time::Local;

#Hora local de Laptop
my ($s, $min, $h, $d, $m, $y) = localtime();
my $time = timelocal $s, $min, $h, $d, $m, $y;

#VARIABLES
my $nivel=0;
my $numAzar=0;
my $gameToPlay=0;
my $n=1;
my $x=1;
my @mayorQue;
my @menorQue;
my @residuo;
my $espacio;
my @simbolicPlaces;
my @coordenadas;
my $respuesta;
my $level;
my $renglon=0;
my $h=0;
my $v=0;
my $numero;

#FUNCIONES
	#Imprime la dimension de la matriz
sub cuadro {
	my (@simPl,$level) = @_;
	for(my $i=0; $i < 4; $i+=1){
		print "[";
		for(my $j=0; $j < 4; $j+=1){

			if($simPl[0][1]==$i && $simPl[0][2]==$j){
				if($simPl[0][0]==2000){
					print "|(>)|  ||";
					$espacio=1;
					$renglon=$j;
				}
				elsif($simPl[0][0]==1000){
					print "|(<)|  ||";
					$espacio=1;
					$renglon=$j;
				}
			}
			elsif($simPl[1][1]==$i && $simPl[1][2]==$j){
				if($simPl[1][0]==2000){
					print "|(>)|  ||";
					$espacio=1;
					$renglon=$j;
				}
				elsif($simPl[1][0]==1000){
					print "|(<)|  ||";
					$espacio=1;
					$renglon=$j;
				}
			}
			elsif($espacio==1 && $renglon != $j){
				print "|  |";
				$espacio=0;
			}
			else{
				print "|  |";
				$espacio=0;
			}
		}
		print "]\n";
	}
}

	# Xn+1=(2xo + c)mod m
sub numAleatorio {
	for(my $i=0;$i<$n;$i++){
		$numAzar=($s*$x + $s)%32;
	}
	$n++;
	$x=$numAzar;
	return $numAzar;
}

sub input {
	#coordenDSS
	$level=@_[0];
	print "Ingrese el numero que quiere ingresar";
	$numero = <STDIN>;
	print "(";
	while ($h < 1 || $h > $level) {
		$h = <STDIN>;
	}
	print ",";
	while ($v < 1 || $v > $level) {
		$v = <STDIN>;
	}
	print ")";
	return $h,$v,$numero;
}

#PLANTILLAS
	#Plantilla 1
	#1000 es > ; 2000 es < ; # es numeroResiduo
sub Plantilla1 {
	@mayorQue = (1000,0,2);
	@menorQue = (2000,0,3);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 4;
	&cuadro(@simbolicPlaces,$level);
	@coordenadas=input($level);
	
}

sub Plantilla2 {
	@mayorQue = (2000,0,2);
	@menorQue = (2000,0,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 4;
	&cuadro(@simbolicPlaces,$level);
	@coordenadas=input($level);
	print $coordenadas[0];
}

sub Plantilla3 {
	@mayorQue = (5,0,2);
	@menorQue = (1000,0,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 4;
	&cuadro(@simbolicPlaces,$level);
	@coordenadas=input($level);
	print $coordenadas[0];
}

#SCRIPT
sub Menu {
	print "Intrucciones cortas: ";
print "En 'Mainarizumu' se presenta un tablero vacío, en donde tendrás que rellenar los recuadros con numeros del 1 hasta el numero de filas que juegues\n";
	print "Habra simbolos como: '>' mayor que, y '<' menor que. Si estos simbolos conectan dos recuadros tendras que escribir valores que cumplan esta condicion\n";
	print "Si dos recuadros estan conectados por un numero, tendras que escribir valores en estos recuadros que cumplan una resta que de como resultado el numero que se presente\n";
	do{
		print "Niveles a Jugar: \n"."Nivel 1: 4x4 \n"."Nivel 2: 5x5 \n"."Nivel 3: 6x6 \n";
		print "Ingresa el nivel que quieres jugar: ";
		$nivel=<>;
	}while($nivel < 1 || $nivel > 3);
	
	#Llamar a subrutina
	$gameToPlay = &numAleatorio();
	print "Numero elegido :". $gameToPlay."\n";
	if ($nivel == 1){
		if($gameToPlay > 21){
			&Plantilla1();
		}
		elsif($gameToPlay > 11){
			&Plantilla2();
		}
		else{
			&Plantilla3();
		}
	}
	elsif ($nivel == 2){
		print "Nivel 2";
	}
	else {
		print "Nivel 3";
	}
}

#SCRIPT
print "MAINARIZUMU \n";
print "Presione 1 si desea jugar una partida. Presione cualguier otro numero para salir\n";
$respuesta=<>;
if($respuesta == 1){
	&Menu();
}
else{
	print "Salir";
}