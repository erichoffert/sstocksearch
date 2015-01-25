# import json parsing and http get requests packages

import json
import requests #http get/post library, installed as Python packages via separate step
import sys
import re # regular expression matching including http link matching

# sample usage: ./sstocksearch.py [images or videos or audio] [keyword]
# syntax: sstocksearch.py  media-type keyword (search for micro stock media-type content based on keyword)

print "starting shutterstock API"
S1="https://api.shutterstock.com/v2/"
S2=sys.argv[1]
S3="/search?per_page=15&query="
S4=sys.argv[2]
S5="&view=full"
S6=S1 + S2 + S3 + S4 + S5
print "shutterstock api url %s" % (S6)

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

if (S6 != ""):
    url = S6
else:
    url='https://api.shutterstock.com/v2/videos/search?per_page=10&query=ocean&view=full'
    
print "url = %s" % (url)

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
  if (sys.argv[1] == 'videos'):
    print "Video %s url = %s" % (x, decoded['data'][x]['assets']['preview_mp4']['url'])
  elif (sys.argv[1] == 'audio'):
    print "Audio %s url = %s" % (x, decoded['data'][x]['assets']['preview_mp3']['url'])
  elif (sys.argv[1] == 'images'):
    print "Image %s url = %s" % (x, decoded['data'][x]['assets']['preview']['url'])

    

    




