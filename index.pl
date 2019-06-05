#!C:/Strawberry/perl/bin/perl.exe
#MODULOS
use strict;
use POSIX qw/strftime/;
use Time::Local;
use Term::Cap;

#Hora local de Laptop
my ($s, $min, $h, $d, $m, $y) = localtime();
my $time = timelocal $s, $min, $h, $d, $m, $y;
my $t = Term::Cap->Tgetent;
#VARIABLES
my $nivel=0;
my $numAzar=0;
my $gameToPlay=0;
my $sawInstructions;
my $verificado;
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
my $p=0;
my $res='si';
my $valorComparar=0;
my $correcto=0;
my $definidos=0;
my $continuar=0;
my $columna;
my $filas;
#FUNCIONES
	#Imprime la dimension de la matriz
sub cuadro {

	for(my $i=1; $i <= $level; $i+=1){
		print "[";
		for(my $j=1; $j <= $level; $j+=1){
			if($simbolicPlaces[$i][$j]==2000){
					print "|  >";
			}
			elsif($simbolicPlaces[$i][$j]==1000){
				print "|  <|";
			}
			else{
				print "|  |";
				$espacio=0;
			}
		}
		print "]\n";
	}
}

sub cuadroConNumeros {
	for(my $i=1; $i <= $level; $i+=1){
		print "[";
		for(my $j=1; $j <= $level; $j+=1){
			if($simbolicPlaces[$i][$j]==2000){
				if(defined $addedNumbers[$i][$j]){
					my $print = $addedNumbers[$i][$j];
					chop $print;     # Match! $str is now in UTF-8 format.
					print '| '.$print.'>';
				}
				else{
					print "|  >";
				}
			}
			elsif($simbolicPlaces[$i][$j]==1000){
				if(defined $addedNumbers[$i][$j]){
					print "|$addedNumbers[$i][$j]<|";
				}
				else{
					print "|  <|";
				}				
			}
			else{
				if(defined $addedNumbers[$i][$j]){
					my $print = $addedNumbers[$i][$j];
					chop $print;     # Match! $str is now in UTF-8 format.
					print '| '.$print.'|';
				}
				else{
					print "|  |";
				}
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
	#Coordenadas
	$h=0;
	$v=0;
	print "Las coordenadas en x son los lugares en horizontal empezando por 1 al $level\n";
	print "Las coordenadas en y son los lugares en vertical empezando por 1 al $level\n";
	print "Los valores permitidos en este nivel son del 1 al $level\n";
	$level=@_[0];
	do{
		print "Ingresa  la coordenada en x: ";
		$h = <STDIN>;
	}
	while ($h < 1 || $h > $level);
	do{
		print "Ingrese la coordenada en y: ";
		$v = <STDIN>;
	}
	while ($v < 1 || $v > $level);

	my $print= "(  $h , $v )\n";
	chop $print;
	print $print;
	do{
		print "Ingrese el numero que quiere ingresar : ";
		$numero = <STDIN>;
	}while($numero < 1 || $numero > $level);

	return $h,$v,$numero;
}

sub Verificar {
	for (my $i = 0; $i < $level; $i++) {		
		for(my $j=0; $j < $level; $j++){
			if(defined $addedNumbers[$i][$j]){
				$valorComparar=$addedNumbers[$i][$j];
				$correcto=0;
				for (my $columna = 0; $columna < $level; $columna++) {
					if(defined $addedNumbers[$i][$columna] and ($columna != $j)){
						$definidos++;
						if($valorComparar!=$addedNumbers[$i][$columna]){
							$correcto++;
						}
						else{
							$correcto=0;
						}
					}
				}
				for(my $filas =0; $filas < $level; $filas++){
					if(defined $addedNumbers[$filas][$j] and ($filas != $i)){
						$definidos++;
						if($valorComparar!=$addedNumbers[$filas][$j]){
							$correcto++;
						}
						else{
							$correcto=0;
						}
					}
				}

				if($correcto == $definidos){
					if($definidos == ($level*$level)){
						return 3;
					}
					else{
						print "Tienes un buen juego!\n";
						return 1;
					}
				}
				else{
					print "Tienes al menos, un error\n";
					return 0;
				}
				# print "¿Quieres seguir jugando? s/n ";
				# $continuar=<STDIN>;
				# if($continuar == "si" || $continuar == "s"){
				# 	return 1;
				# }
				# else{
				# 	return 0;
				# }
			}
		
		}
	
	}
	#Acepta el valor: print $addedNumbers[2][2];
}

sub VerificarSimbolic {
	for (my $i = 0; $i < $level; $i++) {		
		for(my $j=0; $j < $level; $j++){
			if(defined $addedNumbers[$i][$j]){
				$valorComparar=$addedNumbers[$i][$j];
				$correcto=0;
				for (my $columna = 0; $columna < $level; $columna++) {
					if(defined $addedNumbers[$i][$columna] and ($columna != $j)){
						$definidos++;
						if($valorComparar!=$addedNumbers[$i][$columna]){
							$correcto++;
						}
						else{
							$correcto=0;
						}
					}
				}
				for(my $filas =0; $filas < $level; $filas++){
					if(defined $addedNumbers[$filas][$j] and ($filas != $i)){
						$definidos++;
						if($valorComparar!=$addedNumbers[$filas][$j]){
							$correcto++;
						}
						else{
							$correcto=0;
						}
					}
				}
				if($correcto == $definidos){
					print "Tienes un buen juego!\n";
					return 1;
				}
				else{
					print "Tienes al menos, un error\n";
					return 0;
				}
			}
		
		}
	
	}
	#Acepta el valor: print $addedNumbers[2][2];	
}
#PLANTILLAS
	#1000 es > ; 2000 es < ; # es numeroResiduo
sub Plantilla1 {
	$simbolicPlaces[1][1]=2000;
	$simbolicPlaces[1][2]=2000;
	$simbolicPlaces[1][3]=2000;
	$simbolicPlaces[2][1]=2;
	$level = 4;
	if(@_[0]==0){
		&cuadro(@simbolicPlaces,$level);
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);
	print "¿Ingresar otro número? Elija un digito : 1. Si 2. No : ";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla1(1);
	}
	else{
		my $continuar = &Verificar(@addedNumbers);
		if ($continuar == 1){
			# my $continuar = &VerificarSimbolic(@addedNumbers);
			# my $continuar = &VerificarSimbolic(@simbolicPlaces,@addedNumbers);
			print "¿Deseas seguir jugando? Elija un digito : 1. Si 2. No : ";
			$continuar=<STDIN>;
			if($continuar == 1){
				&Plantilla1(1);
			}
			else{
				my $out = <STDIN>;
			}

		}
		elsif($continuar == 2){
			print "¿Deseas seguir jugando? Elija un digito : 1. Si 2. No";
			$continuar=<STDIN>;
			if($continuar == 1){
				&Plantilla1(1);
			}
			else{
				my $out = <STDIN>;
			}
		}
		else{
			
		}
		# my $continuar= &Verificar(@addedNumbers);
		# print "Continuar :" .$continuar;
		# if($continuar == 0){
		# 	@addedNumbers=[];
		# }
	}
}
sub Plantilla2 {
	@mayorQue = (2000,0,2);
	@menorQue = (2000,0,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 4;
	&cuadro(@simbolicPlaces,$level);
		for($p=0;$p<4;$p++){
		print "[";
		for(my $q=0;$q < 4 ; $q++){
			print "| |";
		}
		print "]\n";
	if(@_[0] == 1){
		&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);
	}
	else{
		&cuadro(@simbolicPlaces,$level);
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print "¿Ingresar otro número? Elija un digito : 1. Si 2. No";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla2(1);
	}
	else{
		my $continuar = &Verificar(@addedNumbers);
		if ($continuar == 1){
			my $continuar = &VerificarSimbolic(@addedNumbers);
			print "¿Deseas seguir jugando? Elija un digito : 1. Si 2. No";
			$continuar=<STDIN>;
			if($continuar == 1){
				&Plantilla2(1);
			}
			else{
				my $out = <STDIN>;
			}

		}
		else{
			print "¿Deseas seguir jugando? Elija un digito : 1. Si 2. No";
			$continuar=<STDIN>;
			if($continuar == 1){
				&Plantilla2(1);
			}
			else{
				my $out = <STDIN>;
			}
		}
		# my $continuar= &Verificar(@addedNumbers);
		# print "Continuar :" .$continuar;
		# if($continuar == 0){
		# 	@addedNumbers=[];
		# }
	}
	}
}
sub Plantilla3 {
	@mayorQue = (5,0,2);
	@menorQue = (1000,0,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 4;
	print "sol";
	print @_[0] . "\n";
	if(@_[0] == 1){
		&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);
	}
	else{
		&cuadro(@simbolicPlaces,$level);
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print "¿Ingresar otro número? Elija un digito : 1. Si 2. No";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla3(1);
	}
	else{
		my $continuar = &Verificar(@addedNumbers);
		if ($continuar == 1){
			my $continuar = &VerificarSimbolic(@addedNumbers);
			print "¿Deseas seguir jugando? Elija un digito : 1. Si 2. No";
			$continuar=<STDIN>;
			if($continuar == 1){
				&Plantilla3(1);
			}
			else{
				my $out = <STDIN>;
			}

		}
		else{
			print "¿Deseas seguir jugando? Elija un digito : 1. Si 2. No";
			$continuar=<STDIN>;
			if($continuar == 1){
				&Plantilla3(1);
			}
			else{
				my $out = <STDIN>;
			}
		}
		# my $continuar= &Verificar(@addedNumbers);
		# print "Continuar :" .$continuar;
		# if($continuar == 0){
		# 	@addedNumbers=[];
		# }
	}
}
sub Plantilla4 {
	@mayorQue = (1000,1,1);
	@menorQue = ((2000,0,1),(2000,2,2),(2000,2,3));
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 4;
	if(@_[0] == 0){
		&cuadro(@simbolicPlaces,$level);	
	}
	else{
		&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);

	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print "¿Ingresar otro número? Elija un digito : 1. Si 2. No";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla4(1);
	}
	else{
		my $continuar = &Verificar(@addedNumbers);
		if ($continuar == 1){
			my $continuar = &VerificarSimbolic(@addedNumbers);
			print "¿Deseas seguir jugando? Elija un digito : 1. Si 2. No";
			$continuar=<STDIN>;
			if($continuar == 1){
				&Plantilla4(1);
			}
			else{
				my $out = <STDIN>;
			}

		}
		else{
			print "¿Deseas seguir jugando? Elija un digito : 1. Si 2. No";
			$continuar=<STDIN>;
			if($continuar == 1){
				&Plantilla4(1);
			}
			else{
				my $out = <STDIN>;
			}
		}
		# my $continuar= &Verificar(@addedNumbers);
		# print "Continuar :" .$continuar;
		# if($continuar == 0){
		# 	@addedNumbers=[];
		# }
	}
}
sub Plantilla5{
	@mayorQue = (1000,1,3);
	@menorQue = ((2000,0,1),(2000,2,1));
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 4;
	&cuadro(@simbolicPlaces,$level);
		for($p=0;$p<4;$p++){
		print "[";
		for(my $q=0;$q < 4 ; $q++){
			print "| |";
		}
		print "]\n";
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print "¿Ingresar otro número?";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla5();
	}
	else{
		&Verificar();
	}
}
sub Plantilla6{
	@mayorQue = ((1000,1,4),(1000,3,5));
	@menorQue = (2000,1,1);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 5;
	&cuadro(@simbolicPlaces,$level);
		for($p=0;$p<5;$p++){
		print "[";
		for(my $q=0;$q < 5 ; $q++){
			print "| |";
		}
		print "]\n";
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print "¿Ingresar otro número?";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla6();
	}
	else{
		&Verificar();
	}
}
sub Plantilla7{ #Imprime el las dimensiones y+1
	@mayorQue = ((1000,4,0),(1000,1,4),(1000,4,5));
	@menorQue = (2000,1,0);
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 5;
	&cuadro(@simbolicPlaces,$level);
	for($p=0;$p<5;$p++){
		print "[";
		for(my $q=0;$q < 5 ; $q++){
			print "| |";
		}
		print "]\n";
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print "¿Ingresar otro número?";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla7();
	}
	else{
		&Verificar();
	}
}
sub Plantilla8{
	@mayorQue = (1000,2,0);
	@menorQue = ((2000,1,2),(2000,4,2),(2000,1,5));
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 5;
	&cuadro(@simbolicPlaces,$level);
		for($p=0;$p<6;$p++){
		print "[";
		for(my $q=0;$q < 5 ; $q++){
			print "| |";
		}
		print "]\n";
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print "¿Ingresar otro número?";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla8();
	}
	else{
		&Verificar();
	}
}
sub Plantilla9{
	@mayorQue = ((1000,1,3),(1000,4,4),(1000,4,5));
	@menorQue = ((2000,0,1),(2000,1,2),(2000,5,1),(2000,3,4),(2000,1,4),(2000,1,5));
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 6;
	&cuadro(@simbolicPlaces,$level);
		for($p=0;$p<6;$p++){
		print "[";
		for(my $q=0;$q < 6 ; $q++){
			print "| |";
		}
		print "]\n";
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print "¿Ingresar otro número?";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla9();
	}
	else{
		&Verificar();
	}
}
sub Plantilla10{
	@mayorQue = ((1000,2,1),(1000,0,3),(1000,3,3));
	@menorQue = ((2000,1,0),(2000,4,0),(2000,4,3),(2000,3,5));
	@simbolicPlaces = (\@mayorQue,\@menorQue);
	$level= 6;
	&cuadro(@simbolicPlaces,$level);
		for($p=0;$p<6;$p++){
		print "[";
		for(my $q=0;$q < 6 ; $q++){
			print "| |";
		}
		print "]\n";
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	print "¿Ingresar otro número?";
	my $verificacion = <STDIN>;
	if($verificacion == 1){
		&Plantilla10();
	}
	else{
		&Verificar();
	}
}

#SCRIPT
sub Menu {
	if(@_[0]==0){
		print "Instrucciones cortas: ";
		print "En 'Mainarizumu' se presenta un tablero vacio\n, en donde tendras que rellenar los recuadros con numeros del 1 hasta el numero de filas que juegues.\n";
		print "Habra simbolos como: '>' mayor que, y '<' menor que.\nSi estos s1mbolos conectan dos recuadros, tendras que escribir valores que cumplan esta condicion.\n";
		print "Si dos recuadros estan conectados por un numero,\n tendras que escribir valores en estos recuadros que cumplan una resta que de como resultado el numero que se presente.\n";	
	}
	
	do{
		print "Niveles a Jugar: \n"."Nivel 1: 4x4 \n";
		# \n"."Nivel 2: 5x5 \n"."Nivel 3: 6x6 \n
		print "Ingresa el nivel que quieres jugar: ";
		$nivel=<>;
	}while($nivel < 1 || $nivel > 3);
	
	#Llamar a subrutina
	$gameToPlay = &numAleatorio();
	print "N\243mero elegido:". $gameToPlay."\n";
	if ($nivel == 1){
		&Plantilla1(0);
		# if($gameToPlay > 21){
		# 	&Plantilla1(0);
		# }
		# elsif($gameToPlay > 11){
		# 	&Plantilla2(0);
		# }
		# else{
		# 	&Plantilla3(0);
		# }
	}
	elsif ($nivel == 2){
		print "Nivel 2: ";
	}
	else {
		print "Nivel 3: ";
	}
}

sub Instrucciones {
	print "Instrucciones.\n";
	print "Para poder jugar este puzzle, deber\240s saber sus reglas:\n";
	print "Los n\243meros no deben repetirse en fila \242 columna.\n";
	print "Habr\240 s\241mbolos c\242mo : '<' \242 '>', esto significa, que cada vez que encuentres uno, tendr\240s que poner n\241meros en los cuadros adyacentes que cumplan esta regla, por ejemplo:\n";
	print "|5|(>)|2|  Aqu\241, esta regla es cumplida, por lo tanto, ñpuedes continuar.\n";
	&Menu(1);
}

#SCRIPT
print "MAINARIZUMU \n";
print "Presione '1' si desea jugar una partida. Presione '2' si eres Nuevo Jugador, \242 cualquier otra tecla si deseas salir.\n";

$respuesta=<STDIN>;
if($respuesta == 1){
	&Menu(0);
}

elsif($respuesta == 2){
	&Instrucciones();
}