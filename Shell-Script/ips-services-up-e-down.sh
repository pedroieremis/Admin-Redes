#!/bin/bash

echo "Digite o range de IP a ser vasculhado, no seguinte formato: 192.168.0.0-255:"
#Definição de INPUT para variável dos IPs
read ips
echo "------------------------ Aguarde um momento -------------------------"

#Definição de variáveis para uso de informação no arquivos a serem gerados
range=$(echo $ips | cut -d "." -f 4)
momento=$(date | cut -d " " -f 2,3,4,5)

#Criação e formatação de arquivo para máquinas ativas e serviços nelas
echo "Maquinas Ativas e Serviços das mesmas no range: $range" > Servicos-Maquinas-Ativas.txt
echo "Momento da averiguação: $momento" >> Servicos-Maquinas-Ativas.txt
echo >> Servicos-Maquinas-Ativas.txt

#Criação e formatação de arquivo para máquinas desativas
echo "Maquinas Desativas no range: $range" > IPs-Maquinas-Desativas.txt
echo "Momento da averiguação: $momento" >> IPs-Maquinas-Desativas.txt
echo >> IPs-Maquinas-Desativas.txt

#Criação e formatação de arquivo para Máquinas Ativas, sem os sossível serviços
echo "IPS ATIVOS no Range: $range" > IPs-Maquinas-Ativas.txt
echo "Momento da averiguação: $momento" >> IPs-Maquinas-Ativas.txt
echo >> IPs-Maquinas-Ativas.txt

#Escaneamento com NMAP
nmap -sn -v $ips > /tmp/res.txt
nmap $ips >> Servicos-Maquinas-Ativas.txt

#Leitura de arquivo temporário, para criação de maquinas desativas, com filtragem de resultado
while read x
do
echo $x | grep "host down" | cut -d " " -f 5 1>> IPs-Maquinas-Desativas.txt 2>>/dev/null
done < /tmp/res.txt

#Leitura de arquivo temporário, para criação de maquinas ativas, com filtragem de resultado
while read y
do
echo $y | grep "Nmap scan report" | grep -v "host down" | cut -d " " -f 5 1>> IPs-Maquinas-Ativas.txt 2>>/dev/null
done < Servicos-Maquinas-Ativas.txt

#Exclusão de arquivo temporário
rm /tmp/res.txt

#Escrita final na tela
echo
echo "------------------------------ Processo finalizado! ------------------------------"
echo
echo "--------------------------- Verifique os arquivos abaixo -------------------------"
echo "IPs-Maquinas-Ativas.txt, IPs-Maquinas-Desativas.txt e Servicos-Maquinas-Ativas.txt"
echo "----------------------------------------------------------------------------------"
