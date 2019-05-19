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
my $x;
my @mayorQue;
my @menorQue;
my @residuo;
my $espacio;
my @simbolicPlaces;
my $respuesta;
my $level;

#FUNCIONES
	#Imprime la dimension de la matriz
sub cuadro {
	my (@simPl,$level) = @_;
	for(my $i=0; $i < 3; $i+=1){
		$espacio=0;
		print "[";
		for(my $j=0; $j < 3; $j+=1){

			if($simPl[0][1]==$i && $simPl[0][2]==$j){
				if($simPl[0][0]==2000){
					print "|(>)| |";
					$espacio=1;
				}
				elsif($simPl[0][0]==1000){
					print "|(<)| |";
					$espacio=1;
				}
			}
			elsif($simPl[1][1]==$i && $simPl[1][2]==$j){
				if($simPl[1][0]==2000){
					print "|(>)| |";
					$espacio=1;
				}
				elsif($simPl[1][0]==1000){
					print "|(<)| |";
					$espacio=1;
				}
			}
			elsif($espacio==1){
				print "   |  |";
			}
			else{
				print "| |";
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

#PLANTILLAS
	#Plantilla 1
	#1000 es > ; 2000 es < ; # es numeroResiduo
sub Plantilla1 {
	@mayorQue = (1000,0,2);
	@menorQue = (2000,0,3);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 1;
	&cuadro(@simbolicPlaces,$level);
}

sub Plantilla2 {
	@mayorQue = (1000,0,2);
	@menorQue = (2000,0,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 1;
	&cuadro(@simbolicPlaces,$level);
}

sub Plantilla3 {
	@mayorQue = (5,0,2);
	@menorQue = (1000,0,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 1;
	&cuadro(@simbolicPlaces,$level);
}

#SCRIPT
sub Menu {
	print "Niveles a Jugar: \n"."Nivel 1: 4x4 \n"."Nivel 2: 5x5 \n"."Nivel 3: 6x6 \n";
	do{
		print "Ingresa el nivel que quieres jugar: ";
		$nivel=<>;
	}while($nivel < 1 || $nivel > 3);
	
	#Llamar a subrutina
	$gameToPlay = &numAleatorio();
	print "Numero elegido :". $gameToPlay."\n";
	if ($nivel == 1){
		if($gameToPlay > 30){
			&Plantilla1();
		}
		elsif($gameToPlay > 20){
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

print "MAINARIZUMU \n";
print "Presione 1 si desea jugar una partida. Presione cualguier otro numero para salir\n";
$respuesta=<>;
if($respuesta == 1){
	&Menu();
}
else{
	print "Salir";
}
#Los parametros se manejan como un arreglo, es decir, yo le mando un parametro y
# lo recibe en el arreglo param[x], 
#le mando otro y lo recibe como param[x,y]
#y de esa manera se mandan a llamar

# NIVEL 1
# {
# #MAINA1

# #MAINA2

# #MAINA3
# }