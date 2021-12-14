#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header("text/XML");
my $title = $q->param("title");
my $text = $q->param("text");
my $owner = $q->param("owner");

my $user = "alumno";
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.69";
my $dbh = DBI->connect($dsn, $user, $password) or die ("No se pudo ha podido establecer conexion");
my $sth = $dbh->prepare("SELECT * FROM users WHERE userName = ?");
$sth->execute($owner);
my $titulos = 0;
my $usuarios = 0;
if(my @arreglo = $sth->fetchrow_array){
 $usuarios = 1;
}
$sth = $dbh->prepare("SELECT * FROM Articles WHERE owner = ? AND title = ?");
$sth->execute($owner, $title); 
if(my @arreglo = $sth->fetchrow_array){
 $titulos = 1;
}
  
