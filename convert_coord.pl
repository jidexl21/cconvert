#!/usr/bin/perl
use Bio::EnsEMBL::Registry;
use Time::Piece;
use Time::Seconds qw/ ONE_DAY /;
use Data::Dumper;

#use strict;

# read prameters
my ( $qry, $_assembly, $to ) = @ARGV;
my @words = split /:/, $qry;
my ( $_chrom, $_range, $_strand) = @words;
my @range = split /\.\./, $_range;

my ($_start, $_end ) = @range;

# validations
 if ( not defined $qry ) {
  die "Query not set.\nEnter your query in format \'chromsome:start..end:strand\' e.g 13:31787617..31871809";
 }
 if ( not defined $_assembly ) { die "Specifiy assembly to convert from"; }

 if ( $qry !~ m/^(([0-2]*[0-9])|[X]):(\d+)..(\d+)(:([+-]{1})*1)*$/i){ die "Invalid query\n"; }

 my $allowed = qr/^GrCH\d{2}|NCBI\d{2}/i;
 if( $_assembly !~ /$allowed/ ){ die "Cannot convert from $_assembly\n" ; }

 if( not defined $_strand ) { $_strand = "1"; }
 if( not defined $to ) { $to = 'GrCh38';}
 if( $to !~ m/^GrCH37|GRCH38$/i ) { die "Conversion only to GrCh37 and GrCh38 is allowed"; }
 print "$_chrom $_start $_end $_strand $_assembly $to\n";

 #exit;
 my $registry = 'Bio::EnsEMBL::Registry';
 #print "loading registry from db\n";
 my $start_time = localtime;

 my $prt = 3337;
if ( $to =~ m/GRCh38/i){ undef $prt; }
 $registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org', # alternatively 'useastdb.ensembl.org'
    -user => 'anonymous',
    -port => $prt
 );

 $end_time = localtime;
 my $duration = ($end_time - $start_time)->pretty;
 #print "registry loaded in $duration\n";

 my $slice_adaptor = $registry->get_adaptor( 'Human', 'Core', 'Slice' );
# my $slice = $slice_adaptor->fetch_by_region( 'chromosome', $_chrom, int($_start), int($_end), int($_strand), $_assembly );
 my $slice = $slice_adaptor->fetch_by_region('chromosome', $_chrom, int($_start), int($_end), int( $_strand ), 'NCBI36');
 my $coord_sys  = $slice->coord_system_name();
 my $seq_region = $slice->seq_region_name();
 my $_version   = $slice->coord_system()->version();


foreach my $sl ( @{ $slice->project('chromosome') } ) {

  printf( "%s:%s:%s:%d:%d:%d\t%s\n", $coord_sys, $_version, $seq_region, int( $_start ) + $sl->from_start() - 1,
        int( $_start ) + $sl->from_end() - 1, int($_strand), $sl->to_Slice()->name() );

}
print "\n";