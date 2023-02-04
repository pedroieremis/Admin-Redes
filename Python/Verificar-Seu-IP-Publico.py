import requests, json

wan_information = requests.get("https://ipinfo.io/json")
ip = json.loads(wan_information.text)["ip"]

print(f'\nSEU IP PÚBLICO É: {ip}\n')