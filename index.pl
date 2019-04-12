#!C:/Strawberry/perl/bin/perl.exe
use strict;

#Solicitar la dimension
#Llamar a funcion cuadro.
#imprimir el cuadro en la funcion
#Una funcion por template elegido
# my $dimension=3;

#Imprime la dimension de la matriz
sub cuadro {
#holi
	for(my $x=0;$x<$_[0];$x+=1){
		print "pos:".$x." [";	
		for(my $y=0;$y<$_[0];$y+=1){
			if($y==0){
				print "(>)"
			}
			print " |_ ".$y."_|";
		}
		print "]\n";
	}
}

#Los parametros se manejan como un arreglo, es decir, yo le mando un parametro y
# lo recibe en el arreglo param[x], 
#le mando otro y lo recibe como param[x,y]
#y de esa manera se mandan a llamar
#m1= Mainarizumu 1 y asi
sub m1 {
	my @matriz;
	$matriz[0]=[52];
	#Seleccionar el lugar de la matriz por coordenada
	print $matriz[0];
}
#Crear una tabla hash, que sea la solucion al cuadro, y se compara con el arreglo
#que forme el usuario, si son iguales, está correcto
#Mandar a llamar a la funcion
#El nivel 1 es 4, nivel 2 es 5, nivel 3 es 6
print "Niveles a Jugar: \n"."Nivel 1: 4x4 \n"."Nivel 2: 5x5 \n"."Nivel 3: 6x6 \n";
print "Ingresa el nivel que quieres jugar: ";
my $nivel=<>;
&cuadro($nivel + 3);

# my $random=0;
# do{
# 	$random=int(rand(4));	
#random no . Hay que una subrutina que genere numeros aleatorios
# }while($random==0);
# print $random;

# &m1();