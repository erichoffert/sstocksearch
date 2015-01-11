#!/bin/bash

# syntax: sstocksearch auth-token media-type keyword (search for micro stock media-type content based on keyword and auth-token)

echo starting shutterstock API…
S1="https://api.shutterstock.com/v2/"
S2=$2
S3="/search?per_page=1&query="
S4=$3
S5="&view=full"
S6=$S1$S2$S3$S4$S5
echo $S6

function imagesearchapi {
echo in imagesearchapi
curl -D- -X GET -H "Authorization: Basic $1" -H "Content-Type: application/json" $S6
}

function audiosearchapi {
echo in audiosearchapi
curl -D- -X GET -H "Authorization: Basic $1" -H "Content-Type: application/json" $S6
}

function videosearchapi {
echo in videosearchapi
curl -D- -X GET -H "Authorization: Basic $1" -H "Content-Type: application/json" $S6
}



if [ "$2" == "image" ]; then
 imagesearchapi $1 
elif [ "$2" == "video" ]; then
 videosearchapi $1 
elif [ "$2" == "audio" ]; then
 audiosearchapi $1 
else
 echo "no search"
fi
echo done
