					
                  ###########################################################
                  #              DOS SCRIPT BY HACKER ORIENTADO             #
                  #         CannonBytes v0.9.1 ( Denial of Servide )        #
                  #     NÃO ME RESPONSABILIZO PELO USO DE OUTRAS PESSOAS    #
                  ###########################################################



FORMAS DE USO:
- USE NORMALMENTE -- "ABRINDO" O SCRIPT OU USE O MODO LINHA DE COMANDO.

EXEMPLO:
c:\xxx\xxx\>perl CannonBytes.pl

OU MODO LINHA DE COMANDO:

c:\xxx\xxx\>CannonBytes.pl ( IP ou URL ) PORTA PACOTE VEZES PROTOCOLO INTERVALO

c:\xxx\xxx\>CannonBytes.pl www.yahoo.com.br 80 64000 5000 tcp 30


PARA VERSÕES 0.9+

c:\xxx\xxx\>CannonBytes.pl www.yahoo.com.br 80 64000 5000 tcp 30
* FAZ O ATAQUE NORMALMENTE COM APENAS 1 THREAD *

c:\xxx\xxx\>CannonBytes.pl www.yahoo.com.br 80 64000 5000 tcp 30 -threads
* COM O USO DO COMANDO " -threads " VOCÊ PODERม USAR 2 THREADS PARA FAZER O ATAQUE *
* PS: EDITE CASO QUEIRA MAIS DE DUAS THREADS *

c:\xxx\xxx\>CannonBytes.pl www.yahoo.com.br 80 64000 5000 tcp 30 -h
* ASSIM IRม ANULAR TODO O CÓDIGO ESCRITO E IRÁ APENAS PRINTAR NA TELA O COMANDO DE AJUDA BÁSICO *

c:\xxx\xxx\>CannonBytes.pl www.yahoo.com.br -threads
* IRม GERAR UM ERRO POIS APENAS 1 THREAD SERม INICIADA E A SEGUNDA NรO IRÁ TER OS DADOS PARA CONTINUAR, JÁ QUE VC USOU O COMANDO THREADS QUE USA MAIS DE UMA. *
* PS: EM BREVE IREI CORRIGIR ISSO! * D:


===============================================================================================================

CHANGELOG:
v 0.6
- VERSÃO INICIAL! :D



v 0.7
- MUDANÇA NA ESTRUTURA DO CÓDIGO

- DETALHES ADICIONADOS SOBRE CADA PARTE DO CÓDIGO

- ADICIONADO A OPÇÃO DE AJUDA 
c:\xxx\xxx\>perl CannonBytes.pl -h

- MUDANÇA DO NOME DE JabDoS.pl para CannonBytes *-*

- ADICIONADA VERIFICAÇÃO DO SISTEMA OPERACIONAL PARA COMANDOS DO SISTEMA

- DETECÇÃO ENTRE SITE OU IP

- MUDANÇA NO MANUAL


v 0.8
- CORREÇÃO CRÍTICA NO CÓDIGO QUE FAZIA COM QUE O ATAQUE FOSSE INTERROMPIDO DEVIDO AO USO DO MESMO SOCKET SEMPRE! D:
PS: ESTOU ABISMADO COMIGO MESMO DE NUNCA TER VISTO ISSO..... ME DESCULPE MESMO!

- LEVE MUDANวA NO MANUAL.

- LEVE MUDANวA NO BANER *-*


v 0.9
- FINALMENTE AGORA DA PARA SE USAR O MULTI THREADS ( por padrão vem apenas com duas threads ao mesmo tempo. se quiser, você pode editar o código fonte adicionando mais de 2 threads bem facilmente! ), DANDO ASSIM UMA POTÊNCIA MAIOR PARA O ATAQUE! *-*

- MUDANÇA NO CÓDIGO FONTE PARA SE ADAPTAR A NOVA FUNÇÃO DE THREADS.

- LEVE MUDANÇA NO BANER DE NOVO :D

- 0.9.1
- ADICIONADO UM BANER DECENTE COMPARADO AO ANTIGO ( HAHAHA =P ).

- CORRIGIDO ERRO QUE NÃO FAZIA UMA PARTE DO CÓDIGO SER PRINTADA.

- LEVE MUDANÇA NOS "print" DO COMANDO DE AJUDA.

																		                   
PS: EU ESTOU DESPONIBILIZANDO ESTE SCRIPT POIS ACHO QUE CONHECIMENTO DEVE SER LIVRE E DE TODOS! USE, EDITE E COMPILE MAS SEMPRE COMPARTILHE O CÓDIGO FONTE!
																		                                                                                                                         

ESTE PROGRAMA É PARA ESTUDO E NÃO FOI DISPONIBILIZADO PARA EFETUAR A QUEDA DA INTERNET DE OUTRAS PESSOAS POIS ISSO É CRIME!
EU NÃO ME RESPONSABILIZO PELO USO DE OUTRAS PESSOAS.
O USO INCORRETO DESTE SCRIPT RESULTARม EM PENA PERANTE AS LEIS DO ESTADO E DA FEDERAÇÃO DE ONDE O USUÁRIO RESIDE.

USE COM SABEDORIA! ;D