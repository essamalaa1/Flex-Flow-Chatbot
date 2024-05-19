import requests

url = 'http://127.0.0.1:5000/post'
data = {'msg': 'Hello'}
response = requests.post(url, data=data)

print(response.text)