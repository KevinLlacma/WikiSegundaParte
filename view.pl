#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header("text/HTML");

my $user = "alumno";
my $password = 'pweb1';
my $owner = $q->param("owner");
my $title = $q->param("title");
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.69";
my $dbh = DBI->connect($dsn, $user, $password) or die ("No se pudo ha podido establecer la conxion");

my $sth = $dbh->prepare("SELECT text FROM Articles WHERE owner = ? and title = ?");
$sth->execute($owner, $title);

sub array {
my @datos;
my $lineas=$_[0]; 
my $var=0;
$linea =~ s/\n/\|/g;
while($lineas =~ /^([^|]+)\|(.+)/){
    $lineas = $2;
    $datos[$var] = $1;
    $var++;
}
$datos[$var] = $lineas;
$var++;
return @datos;
}



