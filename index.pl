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
my @addedNumbers;
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
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print $addedNumbers[3][4];
	print "¿Verificar?"
}

sub Plantilla2 {
	@mayorQue = (2000,0,2);
	@menorQue = (2000,0,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 4;
	&cuadro(@simbolicPlaces,$level);
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print $addedNumbers[3][4];
	print "¿Verificar?"
}

sub Plantilla3 {
	@mayorQue = (5,0,2);
	@menorQue = (1000,0,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 4;
	&cuadro(@simbolicPlaces,$level);
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print $addedNumbers[3][4];
	print "¿Verificar?"
}

=begin comment 
sub Plantilla4{
	@mayorQue = (1000,1,1);
	@menorQue = (2000,0,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 1;
	&cuadro(@simbolicPlaces,$level);}
	@coordenadas=input($level);

sub Plantilla5{
	@mayorQue = (1000,0,1);
	@menorQue = (2000,3,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 1;
	&cuadro(@simbolicPlaces,$level);}
	@coordenadas=input($level);

sub Plantilla6{
	@mayorQue = (1000,3,1);
	@menorQue = (2000,0,0);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 3;
	&cuadro(@simbolicPlaces,$level);}
	@coordenadas=input($level);

sub Plantilla7{
	@mayorQue = (1000,1,0);
	@menorQue = (2000,2,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 3;
	&cuadro(@simbolicPlaces,$level);
	@coordenadas=input($level);
	}
=end comment
=cut

#SCRIPT
sub Menu {
	print "Instrucciones cortas: ";
	print "En 'Mainarizumu' se presenta un tablero vac\241o, en donde tendr\240s que rellenar los recuadros con n\243meros del 1 hasta el n\243mero de filas que juegues.\n";
	print "Habr\240 s\241mbolos como: '>' mayor qu\202, y '<' menor qu\202. Si estos s\241mbolos conectan dos recuadros, tendr\240s que escribir valores que cumplan esta condici\242n.\n";
	print "Si dos recuadros est\240n conectados por un n\243mero, tendr\240s que escribir valores en estos recuadros que cumplan una resta que d\202 como resultado el n\243mero que se presente.\n";
	do{
		print "Niveles a Jugar: \n"."Nivel 1: 4x4 \n"."Nivel 2: 5x5 \n"."Nivel 3: 6x6 \n";
		print "Ingresa el nivel que quieres jugar: ";
		$nivel=<>;
	}while($nivel < 1 || $nivel > 3);
	
	#Llamar a subrutina
	$gameToPlay = &numAleatorio();
	print "N\243mero elegido :". $gameToPlay."\n";
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

sub Instrucciones {
	print "Instrucciones.\n";
	print "Para poder jugar este puzzle, deber\240s saber sus reglas:\n";
	print "Los n\243meros no deben repetirse en fila o columna.\n";
	print "Habr\240 s\241mbolos como : '<' o '>', esto significa, que cada vez que encuentres uno, tendr\240s que poner n\243meros en los cuadros adyacentes que cumplan esta regla, por ejemplo: \n";
	print "|5|(>)|2|  Aqu\241, esta regla es cumplida, por lo tanto, puedes continuar.\n";
	&Menu();
}

#SCRIPT
print "MAINARIZUMU \n";
print "Presione '1' si desea jugar una partida. Presione '2' si eres Nuevo Jugador, \242 cualquier otra tecla si deseas salir.\n";
$respuesta=<>;
if($respuesta == 1){
	&Menu();
}
elsif($respuesta == 2){
	&Instrucciones();
}
else{
	print "Salir";
}
