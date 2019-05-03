#!C:/Strawberry/perl/bin/perl.exe
#MODULOS
use strict;
use POSIX;

#VARIABLES
my $nivel=0;
my $numAzar=0;
my $gameToPlay=0;
my @simbolicPlaces;

#FUNCIONES
	# Xn+1=(2xo + c)mod m
sub numAleatorio {
	#modulo por division Euclidiana ???
	$numAzar=floor(($_[0]*2 + $_[1]) / $_[2]);
	return $numAzar;
}
	#Imprime la dimension de la matriz
sub cuadro {
	my $y=0;
	for(my $x=0;$x<$_[0];$x+=1){
		print "pos:".$x." [";	
		for(my $y=0;$y<$_[0];$y+=1){
			print "| |";
			if(@_[0]==1000){
				print ">";
			}
		}
		print "]\n";
	}
}

#PLANTILLAS
	#Plantilla 1
	#1000 es > ; 2000 es < ; x es numeroResiduo
sub Plant1 {
	# body...
}

sub Plantilla {
	@simbolicPlaces = ((1000,2),(1000,4),(1000,6));
	&cuadro($_[0],@simbolicPlaces);
}

#SCRIPT
print "MAINARIZUMU \n";
print "Niveles a Jugar: \n"."Nivel 1: 4x4 \n"."Nivel 2: 5x5 \n"."Nivel 3: 6x6 \n";
do{
	print "Ingresa el nivel que quieres jugar: ";	
	$nivel=<>;
}while($nivel < 1 || $nivel > 3);

#Llamar a subrutina
$gameToPlay = &numAleatorio($nivel,2,4);
print "Numero elegido". $gameToPlay;
&Plantilla();

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