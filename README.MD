# CConvert (cconvert.pl) recommmended solution

Converts cooordinates from GRCh37, to GRCh38
Uses ensembl JSON api
fast operation minimal dependencies and quick setup


# Usage
 Commandline:
 
`./cconvert.pl query [<from>, <to>]`

## Examples

### convert from GrCh37 to GrCh38
`./cconvert.pl X:1000000..1001000:1`

### Convert from NCBI36 tp GrCh38
`./cconvert.pl X:1000000..1001000:1 NCBI36 GrCH37`

### Convert from NCBI36 to GrCh37
`./cconvert.pl X:1000000..1001000:1 GrCH37`

# Installation

* Download this file
* Enable Script: 
`chmod +x cconvert.pl`

# Dependencies: Perl, JSON

`sudo apt-get install libjson-perl`


# convert_coord.pl

# Usage
 Commandline:
 
`./convert_coord.pl query [<from>, <to>]`
#### query
query format chromosome:start..end:strand from_assembly to_assembly
* chromosome: accepts a double digit numeric value or X
* start: The start index a numeric value
* end: the end index
* strand: optional, default value is 1 accepts +1, 1, or -1

#### from
Assembly to convert from e.g. GrCh37, NCBI36

#### to (optional)
default value is GrCh38 accepts GrCh37 or GrCh38 (case insensitive)

## Examples

### convert from GrCh37 to GrCh38
`./convert_coord.pl X:1000000..1001000:1 GrCh37`

### Convert from NCBI36 tp GrCh38
`./convert_coord.pl 13:31787617..31871809 NCBI36`

### Convert from NCBI36 to GrCh37
`./convert_coord.pl X:1000000..1001000:1 GrCH36 GrCh37`

# Installation
setup dependencies following the dcoumentation at http://www.ensembl.org/info/docs/api/api_installation.html
* Download this file
* Enable Script: 
`chmod +x convert_coord.pl`



