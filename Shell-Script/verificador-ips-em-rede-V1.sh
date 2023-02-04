#!/bin/bash

echo "Insira o IP ou range de IPs na seguinte formatação: 192.168.0.1-255"
read IP

echo "-------------- Aguarde um momento --------------"
nmap -sn -v $IP > resultado.txt

echo " ------------ HOSTS DESATIVOS ------------ " > resultado-desativos.txt
echo " -------- HOSTS ATIVOS -------- " > resultado-ativos.txt

while read x
do

echo $x | grep "host down" 1>> resultado-desativos.txt 2> /dev/null
echo $x | grep -v "host down" | grep "Nmap scan report" 1>> resultado-ativos.txt 2> /dev/null

done < resultado.txt

rm resultado.txt
echo "------------- Processo finalizado! -------------"
echo
echo "--------- Verifique os arquivos abaixo ---------"
echo "resultados-ativos.txt e resultados-desativos.txt"
