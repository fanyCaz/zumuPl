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
my $repetidos=0;
my $comparadores=0;
#FUNCIONES
	#Imprime la dimension de la matriz
sub cuadro {
	print "  ";
	for(my $i=1; $i<=$level ; $i++){
		print "   ".$i."  ";
	}
	print "\n";
	for(my $i=1; $i <= $level; $i+=1){
		print $i;
		print "[";
		for(my $j=1; $j <= $level; $j+=1){
			if($simbolicPlaces[$i][$j]==2000){
					print "|    >";
			}
			elsif($simbolicPlaces[$i][$j]==1000){
				print "|    <";
			}
			elsif(defined $simbolicPlaces[$i][$j]){
				print "|   .".$simbolicPlaces[$i][$j];
			}
			else{
				print "|    |";
				$espacio=0;
			}
		}
		print "]\n";
	}
}

sub cuadroConNumeros {
	print "  ";
	for(my $i=1; $i<=$level ; $i++){
		print "   ".$i."  ";
	}
	print "\n";
	for(my $i=1; $i <= $level; $i+=1){
		print $i;
		print "[";
		for(my $j=1; $j <= $level; $j+=1){
			if($simbolicPlaces[$i][$j]==2000){
				if(defined $addedNumbers[$i][$j]){
					my $print = $addedNumbers[$i][$j];
					chop $print;
					print '|  '.$print.' >';
				}
				else{
					print "|    >";
				}
			}
			elsif($simbolicPlaces[$i][$j]==1000){
				if(defined $addedNumbers[$i][$j]){
					my $print = $addedNumbers[$i][$j];
					chop $print;
					print '|  '.$print.' <';
				}
				else{
					print "|    <";
				}
			}
			elsif(defined $simbolicPlaces[$i][$j]){
				if(defined $addedNumbers[$i][$j]){
					my $print = $addedNumbers[$i][$j];
					chop $print;
					print '| '.$print." .$simbolicPlaces[$i][$j]";
				}
				else{
					print "|   .".$simbolicPlaces[$i][$j];
				}
				# print "|  ".$simbolicPlaces[$i][$j];
			}
			else{
				if(defined $addedNumbers[$i][$j]){
					my $print = $addedNumbers[$i][$j];
					chop $print;     # Match! $str is now in UTF-8 format.
					print '|  '.$print.' |';
				}
				else{
					print "|    |";
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
	print "\n";
	return $numAzar;
}

sub input {
	#Coordenadas
	$h=0;
	$v=0;
	print "La coordenadas en x es la fila (horizontal) empezando por 1 al $level\n";
	print "La coordenadas en y es la columna (vertical) empezando por 1 al $level\n";
	print "Los valores permitidos a ingresar en este nivel son del 1 al $level\n";
	$level=@_[0];
	print "Ingresa el n".chr(163)."mero de la coordenada en x: ";
	$h = <STDIN>;
	while ($h < 1 || $h > $level){
		print "Los valores permitidos en x son del 1 al $level: ";
		$h = <STDIN>;
	}
	print "Ingresa el n".chr(163)."mero de la coordenada en y: ";
	$v = <STDIN>;
	while ($v < 1 || $v > $level){
		print "Los valores permitidos en y son del 1 al $level: ";
		$v = <STDIN>;
	}
	
	printf "Ingrese el n".chr(163)."mero que quiere ingresar : ";
	$numero = <STDIN>;
	while($numero < 1 || $numero > $level){
		print "El número que quiera ingresar debe ser del 1 al $level : ";
		$numero = <STDIN>;
	}

	return $h,$v,$numero;
}

sub Verificar {
	$repetidos=0;
	$definidos=0;
	for (my $i = 1; $i <= $level; $i++) {		
		for(my $j=1; $j <= $level; $j++){
			if(defined $addedNumbers[$i][$j]){
				$definidos++;
				# print "[$i][$j]";
				$valorComparar=$addedNumbers[$i][$j];
				for (my $columna = 1; $columna <= $level; $columna++) {
					if((defined $addedNumbers[$i][$columna]) and ($columna != $j)){
						# print "LLEGUE AQUI".$j."Y LA I".$i."\n";
						if($valorComparar==$addedNumbers[$i][$columna]){
							$repetidos++;
							print "\tTienes al menos, un valor repetido en la fila $i\n";
						}
					}
				}
				for(my $filas =1; $filas <= $level; $filas++){
					if(defined $addedNumbers[$filas][$j] and ($filas != $i)){
						if($valorComparar==$addedNumbers[$filas][$j]){
							$repetidos++;
							print "\tTienes al menos, un valor repetido en la columna $j\n";
						}
					}
				}
			}
		
		}
		if($repetidos>0){
			#Break porque si hay un solo error ya no recorre todo
			last;
		}
	}
	if($repetidos==0){
		return 1;
	}
	else{
		# print "Tienes al menos, un valor repetido en la matriz \n";
		return 0;
	}
	#Acepta el valor: print $addedNumbers[2][2];
}

sub VerificarSimbolic {
	$comparadores=0;
	$definidos=0;
	for (my $i = 1; $i <= $level; $i++) {		
		for(my $j=1; $j <= $level; $j++){
			if(defined $addedNumbers[$i][$j]){
				$definidos++;
				# print "Simbolos [$i][$j]";
				if($simbolicPlaces[$i][$j]==2000){#2000 es mayor que, entonces la condicion contraria:--><
					if(defined $addedNumbers[$i][$j+1]){
						if($addedNumbers[$i][$j] < $addedNumbers[$i][$j+1]){
							$comparadores++;
							print "\tTienes un error en la condici".chr(162)."n entre las casillas [$i][$j] \n";
						}
					}
				}
				elsif($simbolicPlaces[$i][$j]==1000){
					if(defined $addedNumbers[$i][$j+1]){
						if($addedNumbers[$i][$j] > $addedNumbers[$i][$j+1]){
							$comparadores++;
							print "\tTienes un error en la condici".chr(162)."n entre las casillas [$i][$j] \n";
						}
					}
				}
				elsif(defined $simbolicPlaces[$i][$j]){
					if(defined $addedNumbers[$i][$j+1]){
						if(($addedNumbers[$i][$j] - $addedNumbers[$i][$j+1]) != $simbolicPlaces[$i][$j]  or  ($addedNumbers[$i][$j+1] - $addedNumbers[$i][$j]) != $simbolicPlaces[$i][$j] ){
							# or !(($addedNumbers[$i][$j+1] - $addedNumbers[$i][$j]) == $simbolicPlaces[$i][$j])
							$comparadores++;
							print $addedNumbers[$i][$j]."-".$addedNumbers[$i][$j+1]."=".$simbolicPlaces[$i][$j]."\n";
							print "\tTienes un DE 1 A 2 en la condici".chr(162)."n entre las casillas [$i][$j] \n";
						}
						# elsif(($addedNumbers[$i][$j+1] - $addedNumbers[$i][$j]) != $simbolicPlaces[$i][$j]){
						# 	$comparadores++;
						# 	print $addedNumbers[$i][$j+1]."-".$addedNumbers[$i][$j]."=".$simbolicPlaces[$i][$j]."\n";
						# 	print "\tTienes un DE 2 A 1  en la condici".chr(162)."n entre las casillas [$i][$j] \n";
						# }
					}
				}
			}
		
		}
	
	}
	if($comparadores == 0){
			# print "Tienes un buen juego en condiciones!\n";
		return $definidos;
		
	}
	else{
		# print "Tienes un error en una condicion fuera";
		return 0;
	}
	#Acepta el valor: print $addedNumbers[2][2];	
}

sub Exit{
	exit();
}

sub Win{
	print chr(173)."Has Ganado esta partida!\n";
	@addedNumbers=();
	print chr(168)."Quieres jugar otra vez? Selecciona '1' si eso deseas, o cualquier tecla para salir : ";
	my $continuar=<STDIN>;
	if($continuar == 1 ){
		&Menu(1);
	}
	else{
		&Exit();
	}
}

#PLANTILLAS
	#1000 es > ; 2000 es < ; # es numeroResiduo
sub Plantilla1 {
	$simbolicPlaces[1][1]=2000;
	$simbolicPlaces[1][2]=2000;
	$simbolicPlaces[1][3]=2000;
	$simbolicPlaces[2][1]=1000;
	$simbolicPlaces[3][3]=2000;
	$simbolicPlaces[4][2]=1000;
	$simbolicPlaces[4][1]=2;
	$level = 4;
	if(@_[0]==0){
		&cuadro(@simbolicPlaces,$level);
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);

	#VERIFICACION POR USUARIO
	printf "\n".chr(168)."Desea seguir jugando?\n";
	printf "Seleccione el d".chr(161)."gito para su decision:\n";
	printf "1. Continuar jugando\n2. Comprobar el puzzle\n3. Regresar a Menu\n";
	my $continuar=<STDIN>;
	while($continuar < 1 || $continuar > 3){
		print "Seleccione un n".chr(163)."mero v".chr(160)."lido del men".chr(163).", porfavor";
		$continuar=<STDIN>;
	}
	if($continuar == 1){
		&Plantilla1(1);
	}
	elsif($continuar == 2 ){
		my $verificar = &Verificar(@addedNumbers);
		if($verificar == 1){
			my $verificar = &VerificarSimbolic(@simbolicPlaces,@addedNumbers);
			if($verificar > 0){
				if($verificar == ($level*$level)){
					&Win();
				}
				else{
					print "\t".chr(173)." Excelente ! No has tenido errores\n\n";
					&Plantilla1(1);
				}
			}
			else{
				&Plantilla1(1);
			}
		}
		else{
			&Plantilla1(1);
		}
	}
	else{
		system("cls");
		&Menu(1);
		@addedNumbers=();
	}
	#FIN VERIFICACION POR USUARIO

	#VERIFICACION AUTOMATICA

	# my $verificar = &Verificar(@addedNumbers);
	# if($verificar == 1){
	# 	my $verificar = &VerificarSimbolic(@simbolicPlaces,@addedNumbers);
	# 	if($verificar > 0){
	# 		if($verificar == ($level*$level)){
	# 			&Win();
	# 		}
	# 		else{
	# 			print chr(173)." Tienes un buen juego !\n";
	# 		}
	# 	}
	# }
	# printf chr(168)."Desea seguir jugando?\n";
	# printf "Seleccione el digito para su decision:\n";
	# printf "1. Continuar jugando\n2. Volver al menu\n 3., o cualquier otra tecla para salir \n";
	# my $continuar = <STDIN>;
	# if($continuar == 1){
	# 	&Plantilla1(1);
	# }
	# elsif($continuar==2){
	# 	&Menu(1);
	# 	@addedNumbers=[];
	# }
	# else{
	# 	&Exit();
	# }
	#FIN VERIFICACION AUTOMATICA
}

sub Plantilla2 {
	$simbolicPlaces[1][1]=1000;
	$simbolicPlaces[1][3]=2000;
	$simbolicPlaces[2][1]=2000;
	$simbolicPlaces[3][3]=1000;
	$simbolicPlaces[4][3]=2000; 

	
	$level = 4;
	if(@_[0]==0){
		&cuadro(@simbolicPlaces,$level);
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);

	#VERIFICACION POR USUARIO
	printf "\n".chr(168)."Desea seguir jugando?\n";
	printf "Seleccione el d".chr(161)."gito para su decision:\n";
	printf "1. Continuar jugando\n2. Comprobar el puzzle\n3. Regresar a Menu\n";
	my $continuar=<STDIN>;
	while($continuar < 1 || $continuar > 3){
		print "Seleccione un n".chr(163)."mero v".chr(160)."lido del men".chr(163).", porfavor";
		$continuar=<STDIN>;
	}
	if($continuar == 1){
		&Plantilla2(1);
	}
	elsif($continuar == 2 ){
		my $verificar = &Verificar(@addedNumbers);
		if($verificar == 1){
			my $verificar = &VerificarSimbolic(@simbolicPlaces,@addedNumbers);
			if($verificar > 0){
				if($verificar == ($level*$level)){
					&Win();
				}
				else{
					print "\t".chr(173)." Excelente ! No has tenido errores\n\n";
					&Plantilla2(1);
				}
			}
			else{
				&Plantilla2(1);
			}
		}
		else{
			&Plantilla2(1);
		}
	}
	else{
		system("cls");
		&Menu(1);
		@addedNumbers=();
	}
	#FIN VERIFICACION POR USUARIO
}
sub Plantilla3 {
	$simbolicPlaces[1][1]=2000;
	$simbolicPlaces[2][3]=1000;
	$simbolicPlaces[3][1]=2000;
	$simbolicPlaces[4][3]=1000;
	$level = 4;
	if(@_[0]==0){
		&cuadro(@simbolicPlaces,$level);
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);

	#VERIFICACION POR USUARIO
	printf "\n".chr(168)."Desea seguir jugando?\n";
	printf "Seleccione el d".chr(161)."gito para su decision:\n";
	printf "1. Continuar jugando\n2. Comprobar el puzzle\n3. Regresar a Menu\n";
	my 	$continuar=<STDIN>;
	while($continuar < 1 || $continuar > 3){
		print "Seleccione un n".chr(163)."mero v".chr(160)."lido del men".chr(163).", porfavor";
		$continuar=<STDIN>;
	}
	if($continuar == 1){
		&Plantilla3(1);
	}
	elsif($continuar == 2 ){
		my $verificar = &Verificar(@addedNumbers);
		if($verificar == 1){
			my $verificar = &VerificarSimbolic(@simbolicPlaces,@addedNumbers);
			if($verificar > 0){
				if($verificar == ($level*$level)){
					&Win();
				}
				else{
					print "\t".chr(173)." Excelente ! No has tenido errores\n\n";#agregar pergunat de volver a jugar? lol
					&Plantilla3(1);
				}
			}
			else{
				&Plantilla3(1);
			}
		}
		else{
			&Plantilla3(1);
		}
	}
	else{
		system("cls");
		&Menu(1);
		@addedNumbers=();
	}
	#FIN VERIFICACION POR USUARIO
}
sub Plantilla4 {
	$simbolicPlaces[1][1] = 1000;
	$simbolicPlaces[2][4] = 1000;
	$simbolicPlaces[2][2] = 1000;
	$simbolicPlaces[4][2] = 2000;
	$simbolicPlaces[4][3] = 1000;
	$level= 5;
	if(@_[0]==0){
		&cuadro(@simbolicPlaces,$level);
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);
	my $verificar = &Verificar(@addedNumbers);
	if($verificar == 1){
		my $verificar = &VerificarSimbolic(@simbolicPlaces,@addedNumbers);
		if($verificar > 0){
			if($verificar == ($level*$level)){
				&Win();
			}
			else{
				print chr(173)." Tienes un buen juego !\n";
			}
			#- print "verifi".$verificar;
		}
	}
	printf chr(168)."Desea seguir jugando? Seleccione 1 si es asi, 2 para volver al menu , o cualquier otra tecla para salir \n";
	my $continuar = <STDIN>;
	if($continuar == 1){
		&Plantilla4(1);
	}
	elsif($continuar==2){
		&Menu(1);
		@addedNumbers=[];
	}
	else{
		&Exit();
	}
}
sub Plantilla5{
	$simbolicPlaces[1][2] = 1000;
	$simbolicPlaces[2][3] = 2000;
	$simbolicPlaces[4][2] = 2000;
	$simbolicPlaces[1][4] = 1000;
	$level = 5;
	if(@_[0]==0){
		&cuadro(@simbolicPlaces,$level);
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);
	my $verificar = &Verificar(@addedNumbers);
	if($verificar == 1){
		my $verificar = &VerificarSimbolic(@simbolicPlaces,@addedNumbers);
		if($verificar > 0){
			if($verificar == ($level*$level)){
				&Win();
			}
			else{
				print chr(173)." Tienes un buen juego !\n";
			}
			#- print "verifi".$verificar;
		}
	}
	printf chr(168)."Desea seguir jugando? Seleccione 1 si es asi, 2 para volver al menu , o cualquier otra tecla para salir \n";
	my $continuar = <STDIN>;
	if($continuar == 1){
		&Plantilla5(1);
	}
	elsif($continuar==2){
		&Menu(1);
		@addedNumbers=[];
	}
	else{
		&Exit();
	}
}
sub Plantilla6{
	$simbolicPlaces[1][3] = 1000;
	$simbolicPlaces[1][2] = 2000;
	$simbolicPlaces[2][1] = 2000;
	$level = 5;
	if(@_[0]==0){
		&cuadro(@simbolicPlaces,$level);
	}
	@coordenadas=input($level);
	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
	&cuadroConNumeros(@simbolicPlaces,$level,@addedNumbers);
	my $verificar = &Verificar(@addedNumbers);
	if($verificar == 1){
		my $verificar = &VerificarSimbolic(@simbolicPlaces,@addedNumbers);
		if($verificar > 0){
			if($verificar == ($level*$level)){
				&Win();
			}
			else{
				print chr(173)." Tienes un buen juego !\n";
			}
			#- print "verifi".$verificar;
		}
	}
	printf chr(168)."Desea seguir jugando? Seleccione 1 si es asi, 2 para volver al menu , o cualquier otra tecla para salir \n";
	my $continuar = <STDIN>;
	if($continuar == 1){
		&Plantilla6(1);
	}
	elsif($continuar==2){
		&Menu(1);
		@addedNumbers=[];
	}
	else{
		&Exit();
	}
}
# sub Plantilla7{ #Imprime el las dimensiones y+1
# 	@mayorQue = ((1000,4,0),(1000,1,4),(1000,4,5));
# 	@menorQue = (2000,1,0);
# 	@simbolicPlaces = (\@mayorQue,\@menorQue);
# 	$level= 5;
# 	&cuadro(@simbolicPlaces,$level);
# 	for($p=0;$p<5;$p++){
# 		print "[";
# 		for(my $q=0;$q < 5 ; $q++){
# 			print "| |";
# 		}
# 		print "]\n";
# 	}
# 	@coordenadas=input($level);
# 	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
# 	print "¿Ingresar otro número?";
# 	my $verificacion = <STDIN>;
# 	if($verificacion == 1){
# 		&Plantilla7();
# 	}
# 	else{
# 		&Verificar();
# 	}
# }
# sub Plantilla8{
# 	@mayorQue = (1000,2,0);
# 	@menorQue = ((2000,1,2),(2000,4,2),(2000,1,5));
# 	@simbolicPlaces = (\@mayorQue,\@menorQue);
# 	$level= 5;
# 	&cuadro(@simbolicPlaces,$level);
# 		for($p=0;$p<6;$p++){
# 		print "[";
# 		for(my $q=0;$q < 5 ; $q++){
# 			print "| |";
# 		}
# 		print "]\n";
# 	}
# 	@coordenadas=input($level);
# 	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
# 	print "¿Ingresar otro número?";
# 	my $verificacion = <STDIN>;
# 	if($verificacion == 1){
# 		&Plantilla8();
# 	}
# 	else{
# 		&Verificar();
# 	}
# }
# sub Plantilla9{
# 	@mayorQue = ((1000,1,3),(1000,4,4),(1000,4,5));
# 	@menorQue = ((2000,0,1),(2000,1,2),(2000,5,1),(2000,3,4),(2000,1,4),(2000,1,5));
# 	@simbolicPlaces = (\@mayorQue,\@menorQue);
# 	$level= 6;
# 	&cuadro(@simbolicPlaces,$level);
# 		for($p=0;$p<6;$p++){
# 		print "[";
# 		for(my $q=0;$q < 6 ; $q++){
# 			print "| |";
# 		}
# 		print "]\n";
# 	}
# 	@coordenadas=input($level);
# 	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
# 	print "¿Ingresar otro número?";
# 	my $verificacion = <STDIN>;
# 	if($verificacion == 1){
# 		&Plantilla9();
# 	}
# 	else{
# 		&Verificar();
# 	}
# }
# sub Plantilla10{
# 	@mayorQue = ((1000,2,1),(1000,0,3),(1000,3,3));
# 	@menorQue = ((2000,1,0),(2000,4,0),(2000,4,3),(2000,3,5));
# 	@simbolicPlaces = (\@mayorQue,\@menorQue);
# 	$level= 6;
# 	&cuadro(@simbolicPlaces,$level);
# 		for($p=0;$p<6;$p++){
# 		print "[";
# 		for(my $q=0;$q < 6 ; $q++){
# 			print "| |";
# 		}
# 		print "]\n";
# 	}
# 	@coordenadas=input($level);
# 	$addedNumbers[$coordenadas[0]][$coordenadas[1]] = $coordenadas[2];
# 	print "¿Ingresar otro número?";
# 	my $verificacion = <STDIN>;
# 	if($verificacion == 1){
# 		&Plantilla10();
# 	}
# 	else{
# 		&Verificar();
# 	}
# }

#SCRIPT
sub SelectGame {
	#Vaciar arreglo
	print "Niveles a Jugar: \nNivel 1: 4x4 \nNivel 2: 5x5 \n";
	#."Nivel 3: 6x6 \n
	print "Ingresa el d".chr(161)."gito del nivel que quieres jugar : ";
	$nivel=<STDIN>;
	while($nivel < 1 || $nivel > 2){
		print "Selecciona un nivel de 1 al 2, porfavor\n";
		$nivel=<>;
	}
	# &Plantilla1();
	#Llamar a subrutina para generar numero que eligira tablero
	$gameToPlay = &numAleatorio();
	printf "\n";
	if ($nivel == 1){
		if($gameToPlay > 21){
			&Plantilla1(0);
		}
		elsif($gameToPlay > 11){
			&Plantilla2(0);
		}
		else{
			&Plantilla3(0);
		}
	}
	elsif ($nivel == 2){
		if($gameToPlay > 21){
			&Plantilla4(0);
		}
		elsif($gameToPlay > 11){
			&Plantilla5(0);
		}
		else{
			&Plantilla6(0);
		}
	}
}

sub Instrucciones {
	print "\n";
	printf "Instrucciones.\n";
	printf "Para poder jugar este puzzle, deber".chr(160)."s saber sus reglas:\n";
	printf "-En 'Mainarizumu' se presenta un tablero vacio, en donde tendr".chr(160)."s que rellenar los recuadros con numeros del 1 hasta la cantidad de filas que estes jugando.\n";
	printf "-Los n".chr(163)."meros no deben repetirse en fila ni columna.\n";
	printf "-Habr".chr(160)." s".chr(161)."mbolos como : '<' o '>', esto significa, que cada vez que encuentres uno, tendr".chr(160)."s que poner n".chr(163)."meros en los cuadros adyacentes que cumplan esta regla.\n";
	printf "\tEjemplo: Aqu".chr(161).", esta regla es cumplida, por lo tanto, puedes continuar.\n";
	printf "\t| 3 (>) 1 (<) 2 | \n";
	printf "\t| 1  || 2  || 3 | \n";
	printf "\t| 2  || 3  || 1 | \n\n";

	printf "-Si encuentras un n".chr(163)."mero en el tablero, eso significa que los valores que pongas en los cuadros adyacentes, si son restados deben dar como resultado el n".chr(163)."mero que haya entre ambos.\n";
	printf "\tPor ejemplo: Si restamos 3 - 1 , el resultado es igual a 2. El orden no importa, por lo cual tambi".chr(130)."n puedes escribir |1|(2)|3|\n";
	printf "\t| 3 (2) 1  || 4  || 2 ||\n";
	printf "\t| 4  || 2  || 3  || 1 ||\n";
	printf "\t| 2  || 3  || 1 (3) 4 ||\n";
	printf "\t| 1  || 4 (>) 2  || 3 ||\n\n";

	printf "-Puedes cambiar un valor en la cuadr".chr(161)."cula que hayas agregado simplemente volviendo a ingresarlo\n\n";
	printf "Presiona cualquier tecla para volver al men".chr(163).".";
	my $r=<STDIN>;
	system("cls");
	&Menu();
}

sub Menu{
	@addedNumbers=();
	@simbolicPlaces=();
	#SCRIPT
		print "\n\t\t...Men".chr(163)."...\n";
		print "Presione el n".chr(163)."mero de lo que desea hacer\n";
		print "1. Ver instrucciones\n";
		print "2. Jugar una partida\n";
		print "3. Salir\n";
	# printf "Presione '1' si eres Nuevo Jugador.\nPresione '2' si quieres jugar una nueva partida, o cualquier otra tecla si deseas salir.\n";
	$respuesta=<STDIN>;
	while($respuesta < 1 || $respuesta > 3){
		print "Seleccione un n".chr(163)."mero v".chr(160)."lido del men".chr(163).", porfavor";
		$respuesta=<STDIN>;
	}
	if($respuesta == 1){
		&Instrucciones();
	}
	elsif($respuesta == 2){
		&SelectGame();
	}
	else{
		exit();
	}
}

print "\t\t\t\t\tMAINARIZUMU \n";
&Menu();
