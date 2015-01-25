#!/usr/bin/perl
# import http::request perl package, installed from cpan via install http::request

use strict;
use LWP::UserAgent;
use Encode qw(decode encode);

# sample usage: ./sstockjson.pl [images or videos or audio] [keyword]
# syntax: sstockjson.pl  media-type keyword (search for micro stock media-type content based on keyword)

print "starting shutterstock API\n";
my $s1="https://api.shutterstock.com/v2/";
my $s2=$ARGV[0];
my $s3="/search?per_page=1&query=";
my $s4=$ARGV[1];
my $s5="&view=full";
my $s6=$s1 . $s2 . $s3 . $s4 . $s5;
print "shutterstock api url\n", $s6, "\n";

# initialize the user agent for the http request to query for media content

my $ua = LWP::UserAgent->new;

# set the url for the http request

my $server_endpoint = $s6;
 
# set the custom HTTP request header fields for content-type and basic authorization

my $req = HTTP::Request->new(GET => $server_endpoint);
#$req->header('content-type' => 'application/json');
$req->default_header(Authorization => "Basic " . "MmY3MTAwNjdmNWIwNGY0NDNmZWE6NWRiM2QyODYxZDQ4ZDlmZmU0YzcxMzQ5NDQ4MjM5MDBlZmYzNDU2MA==");

print ("http basic authorization request", $req->default_header('Authorization'), "\n");

# make the http request with header fields and print the successful or failed response 

my $resp = $ua->request($req);
if ($resp->is_success) {
    my $message = $resp->decoded_content;
    print "Received reply: $message\n";
    # encode the data as utf-8 and print it
    my $messageutf8 = encode_utf8($message);
    print "utf-8 encoded message $message\n";
}
else {
    print "HTTP GET error code: ", $resp->code, "\n";
    print "HTTP GET error message: ", $resp->message, "\n";
}


