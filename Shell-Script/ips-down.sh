#!/bin/bash

#Definição de Variável para capturar o Range dos IPs
read -p "Digite o Range de IPs para Escanear e Gerar o Relatório (Formato: 192.168.0.0-255): " ips

#Definição de variávels - Range certinho colocado para pesquisa e o horário de execução
range=$(echo $ips | cut -d "." -f 4)
horario=$(date | cut -d " " -f 2,3,4,5)

echo
echo "---------------------------------- | Aguarde um Momento | ---------------------------------"

#Comando "nmap", já aplicando filtros para efetuar as verificações
nmap -sn -v $ips | grep "host down" | cut -d " " -f 5 > /tmp/ips-testes-nmap.txt

#Criação de variáveis para colocar no início do arquivo que será gerado
cabecalho=$(echo "HOSTS SEM RECEPÇÃO DE SOLICITAÇÃO DE PING POR ESCANEAMENTO COM NMAP")
msg=$(echo "Sem recepção de Ping:	")

#Criação e indexação de conteúdo inicial em arquivo de saída
echo "$cabecalho - HORÁRIO: $horario " > Relatorio-Range-IPs-Down.txt
echo "RANGE DE IPs ESCANEADOS: $range " >> Relatorio-Range-IPs-Down.txt
echo >> Relatorio-Range-IPs-Down.txt

#Loop sobre o arquivo de origem gerado para a formatação de arquivo de saída
while read x
do
echo "$msg$x" >> Relatorio-Range-IPs-Down.txt
done < /tmp/ips-testes-nmap.txt
rm /tmp/ips-testes-nmap.txt

#Formatação de saída na tela do terminal e criação de variável para as opções de abertura do arquivo
echo
echo "-------------------------------------------------------------------------------------------"
echo "-------------------- | ARQUIVO GERADO: Relatorio-Range-IPs-Down.txt | ---------------------"
echo "-------------------------------------------------------------------------------------------"

echo
echo "Abrir com:"
echo " 0 - Para sair"
echo " 1 - Vim"
echo " 2 - Nano"
echo " 3 - VsCode"
echo " 4 - LibreOffice"
echo " 5 - Gedit"
read -p "Digite o Número da Opção > " op

#Opções de aberturas do arquivo a partir de programas editores
case $op in
	0)
		exit;;
	1)
		vim Relatorio-Range-IPs-Down.txt;;
	2)
		nano Relatorio-Range-IPs-Down.txt;;
	3)
		code Relatorio-Range-IPs-Down.txt;;
	4)
		libreoffice Relatorio-Range-IPs-Down.txt 2>>/dev/null;;
	5)
		gedit Relatorio-Range-IPs-Down.txt;;
	*)
		echo "Opção Inválida!"
esac
