import requests

ip_p = input('\nDigite o IP Público com o ".";(Exemplo: 8.8.8.8): ')
wan_information = requests.get(f"https://ipinfo.io/{ip_p}/json/")
info = wan_information.json()
print(info)