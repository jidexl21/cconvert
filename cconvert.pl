cconvert.pl
#!/usr/bin/perl

 use strict;
 use warnings;
 use HTTP::Tiny;

 my $http = HTTP::Tiny->new();
 # read  and validate input
 my ($query, $from, $to) = @ARGV;

 if (not defined $query) {
  die "Query not set.\nEnter your query in format \'chromsome:start..end:strand\' e.g 13:31787617..3181809";
 }
 if  (not defined $from){ $from =  "GRCh37"; }
 if (not defined $to) { $to = "GRCh38"; }

 if ($query !~ m/^(([0-2]*[0-9])|[X]):(\d+)..(\d+)(:1)*/i){
   print "Invalid query\n";   exit;
 }

 my $allowed = qr/^GrCH\d{2}|NCBI\d{2}/i;
 if($from !~ /$allowed/ || $to !~ /$allowed/ ){
    die "Cannot convert from $from to $to\n" ;
 }


 my $server = 'http://rest.ensembl.org';
 my $ext = '/map/human/'.$from.'/'.$query .'/'.$to.'?';

 my $response = $http->get($server.$ext, {
      headers => { 'Content-type' => 'application/json' }
  });

 die "Failed!\n" unless $response->{success};


 use JSON;
 use Data::Dumper;
    if(length $response->{content}) {
      my $hash = decode_json($response->{content});
      local $Data::Dumper::Terse = 1;
      local $Data::Dumper::Indent = 1;
      print Dumper $hash;
      print "\n";
    }
