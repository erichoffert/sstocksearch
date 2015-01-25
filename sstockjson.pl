# import http::request package

use strict
use LWP::UserAgent;

# sample usage: ./sstockjson.pl [images or videos or audio] [keyword]
# syntax: sstockjson.py  media-type keyword (search for micro stock media-type content based on keyword)

print "starting shutterstock API"
$S1="https://api.shutterstock.com/v2/"
$S2=$ARGV[0]
$S3="/search?per_page=1&query="
$S4=$ARGV[1]
$S5="&view=full"
$S6=$S1 + $S2 + $S3 + $S4 + $S5
print "shutterstock api url $S6"

# initialize the user agent for the http request to query for media content

my $ua = LWP::UserAgent->new;

# set the url for the http request

my $server_endpoint = $S6;
 
# set the custom HTTP request header fields for content-type and basic authorization

my $req = HTTP::Request->new(GET => $server_endpoint);
$req->header('content-type' => 'application/json');
$req->header('authorization' => 'Basic MmY3MTAwNjdmNWIwNGY0NDNmZWE6NWRiM2QyODYxZDQ4ZDlmZmU0YzcxMzQ5NDQ4MjM5MDBlZmYzNDU2MA==');

# make the http request with header fields and print the successful or failed response 

my $resp = $ua->request($req);
if ($resp->is_success) {
    my $message = $resp->decoded_content;
    print "Received reply: $message\n";
}
else {
    print "HTTP GET error code: ", $resp->code, "\n";
    print "HTTP GET error message: ", $resp->message, "\n";
}

# encode the data as utf-8 and print it

my $message-utf8 = encode_utf8($message);

print "utf-8 encoded message $message\n";



    

    




