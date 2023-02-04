#!/bin/bash

echo "Digite o range de IP a ser vasculhado, no seguinte formato: 192.168.0.0-255"
read ips
echo "------------------------ Aguarde um momento -------------------------"

range=$(echo $ips | cut -d "." -f 4)
momento=$(date | cut -d " " -f 2,3,4,5)

echo "Maquinas Ativas e Serviços das mesmas no range: $range" > Maquinas-Ativas-e-Servicos.txt
echo >> Maquinas-Ativas-e-Servicos.txt

nmap $ips >> Maquinas-Ativas-e-Servicos.txt
nmap -sn -v $ips > res.txt

echo "Maquinas Desativas no range: $range" > Maquinas-Desativas.txt
echo "Momento da averiguação: $momento" >> Maquinas-Desativas.txt
echo >> Maquinas-Desativas.txt

while read x
do
echo $x | grep "host down" 1>> Maquinas-Desativas.txt 2>>/dev/null
done < res.txt

echo "IPS ATIVOS:" > IPs-Maquinas-Ativas.txt
echo >> IPs-Maquinas-Ativas.txt
while read y
do
echo $y | grep "Nmap scan report" | cut -d " " -f 5 1>> IPs-Maquinas-Ativas.txt 2>>/dev/null
done < Maquinas-Ativas-e-Servicos.txt

rm res.txt
echo
echo "----------------------- Processo finalizado! ------------------------"
echo
echo "-------------------- Verifique os arquivos abaixo -------------------"
echo "IPs-Maquinas-Ativas.txt, Maquinas-Desativas.txt e Maquinas-Ativas.txt"
echo "---------------------------------------------------------------------"
