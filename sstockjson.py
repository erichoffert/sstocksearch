import json
import requests 
url='https://api.shutterstock.com/v2/videos/search?per_page=5&query=ocean&view=full'
head={'Authorization': 'Basic MmY3MTAwNjdmNWIwNGY0NDNmZWE6NWRiM2QyODYxZDQ4ZDlmZmU0YzcxMzQ5NDQ4MjM5MDBlZmYzNDU2MA=='}
r=requests.get(url,headers=head)
r.text
decoded = json.loads(r.text)
print decoded['page']
print decoded['per_page']
print decoded['data'][0]['assets']['preview_mp4']
