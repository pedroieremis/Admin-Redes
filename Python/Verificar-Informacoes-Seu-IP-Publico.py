import requests

wan_information = requests.get("https://ipinfo.io/json")
ip = wan_information.json()
print(ip)