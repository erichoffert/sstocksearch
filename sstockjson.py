# import json parsing and http get requests packages

import json
import requests 

def byteify(input):
    if isinstance(input, dict):
        return {byteify(key):byteify(value) for key,value in input.iteritems()}
    elif isinstance(input, list):
        return [byteify(element) for element in input]
    elif isinstance(input, unicode):
        return input.encode('utf-8')
    else:
        return input

# set the url for the video search along with the basic authorization

url='https://api.shutterstock.com/v2/videos/search?per_page=10&query=ocean&view=full'
head={'Authorization': 'Basic MmY3MTAwNjdmNWIwNGY0NDNmZWE6NWRiM2QyODYxZDQ4ZDlmZmU0YzcxMzQ5NDQ4MjM5MDBlZmYzNDU2MA=='}

# make an http request (like curl, but here in Python) to the video search url using the basic authentication

r=requests.get(url,headers=head)
r.text

# load the json data from the http data stream returned from the http url

decoded = byteify(json.loads(r.text))


# print out json data as needed

print decoded['page']
print decoded['per_page']

# loop over video search items and print out url etc.

for x in range(0, decoded['per_page']):
  print "Video %s url = %s" % (x, decoded['data'][x]['assets']['preview_mp4'])

