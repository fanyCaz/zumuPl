#!C:/Strawberry/perl/bin/perl.exe
#MODULOS
use strict;
use POSIX;

#VARIABLES
my $nivel=0;
my $numAzar=0;
my $gameToPlay=0;
my $n=1;
my $x;
my @simbolicPlaces;
my $respuesta="no";

#FUNCIONES
	#Imprime la dimension de la matriz
sub cuadro {
	# my $y=0;
	# my(@simbolicPlaces) = @_;
	# for(my $x=0;$x<$_[0];$x+=1){
	# 	print "pos:".$x." [";	
	# 	for(my $y=0;$y<$_[0];$y+=1){
	# 		print "| |";
	# 		if(@_==1000){
	# 			print ">";
	# 		}
	# 	}
	# 	print "]\n";
	# }

	# &resolve(@simbolicPlaces,);
}

# sub resolve {
# 	print "Ingrese la coordenada";
# 	my $coordenada=<STDIN>;

# }


	# Xn+1=(2xo + c)mod m
sub numAleatorio {
	for(my $i=0;$i<$n;$i++){
		$numAzar=(5*$x + 15)%32;
		#Semilla modular diferente => tiempo de laptop
	}
	$n++;
	$x=$numAzar;
	return $numAzar;
}

#PLANTILLAS
	#Plantilla 1
	#1000 es > ; 2000 es < ; # es numeroResiduo
sub Plantilla1 {
	@simbolicPlaces = ((1000,2),(1000,4),(1000,6));
}

sub Plantilla2 {
	@simbolicPlaces = ((1000,$x),(2000,$n));
}
#SCRIPT
do{

print "MAINARIZUMU \n";
print "Niveles a Jugar: \n"."Nivel 1: 4x4 \n"."Nivel 2: 5x5 \n"."Nivel 3: 6x6 \n";
do{
	print "Ingresa el nivel que quieres jugar: ";	
	$nivel=<>;
}while($nivel < 1 || $nivel > 3);

#Llamar a subrutina
$gameToPlay = &numAleatorio($nivel);
print "Numero elegido". $gameToPlay."\n";
if($gameToPlay > 30){
	&Plantilla1();
}
elsif($gameToPlay > 20){
	&Plantilla2();
}
else{
	print "X Y Z LKJFAKJAL";
}
# &Plantilla1($nivel+3);
print "¿Desea jugar de nuevo?";
$respuesta=<STDIN>;
}while($respuesta=="si");

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