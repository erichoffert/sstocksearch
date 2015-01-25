#!/usr/bin/perl
# import http::request perl package, installed from cpan via install http::request

use strict;
# UserAgent package needed to make http requests from Perl
use LWP::UserAgent;
# Mozilla certificate package is needed for https to function, see https://github.com/vsespb/mt-aws-glacier/issues/87
use Mozilla::CA; 
# Encode package is needed for conversions to/from utf-8, Unicode etc.
use Encode qw(decode encode);
# JSON package for parsing json data streams
use JSON qw( decode_json );

# sample usage: ./sstockjson.pl [images or videos or audio] [keyword] 
# syntax: sstockjson.pl  media-type keyword (search for micro stock media-type content based on keyword)

print "starting shutterstock API\n";
my $s1="https://api.shutterstock.com/v2/";
my $s2=$ARGV[0];
my $s3="/search?per_page=5&query=";
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
$req->header('content-type' => 'application/json');
$req->header('authorization' => 'Basic ' . 'MmY3MTAwNjdmNWIwNGY0NDNmZWE6NWRiM2QyODYxZDQ4ZDlmZmU0YzcxMzQ5NDQ4MjM5MDBlZmYzNDU2MA==');

print ("http basic authorization request\n", $req->header('authorization'), "\n");

# make the http request with header fields and print the successful or failed response 

my $resp = $ua->request($req);
if ($resp->is_success) {
    my $json_message = $resp->decoded_content;
    # encode the data as utf-8 and print it
    my $json_messageutf8 = encode("utf8",$json_message);
    print "utf-8 encoded API response", $json_messageutf8, "\n";
    my $decoded = decode_json($json_messageutf8);
    # This is a Perl example of parsing a JSON object.
    my $per_page = $decoded->{'per_page'};
    print "Number of results:", $per_page, "\n";
    foreach my $i (0..$per_page-1) {
     print "Video url $i = ";
     print $decoded->{'data'}[$i]{'assets'}{'preview_mp4'}{'url'}."\n";
     if ($s2 eq 'images') {
          print "Image url[$i] = " . $decoded->{'data'}[$i]{'assets'}{'preview'}{'url'} . "\n";
     }
     elsif ($s2 eq 'audio') {
          print "Audio url[$i] = " . $decoded->{'data'}[$i]{'assets'}{'preview_mp3'}{'url'} . "\n";
     }
     else {
          print "Video url[$i] = " . $decoded->{'data'}[$i]{'assets'}{'preview_mp4'}{'url'} . "\n";
    }
}
else {
    print "HTTP GET error code: ", $resp->code, "\n";
    print "HTTP GET error message: ", $resp->message, "\n";
}



