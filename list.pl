#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header("text/XML");
my $owner = $q->param("owner");

my $user = "alumno";
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.69";
my $dbh = DBI->connect($dsn, $user, $password) or die ("No se pudo ha podido establecer conexion");

my $sth = $dbh->prepare("SELECT owner, title FROM Articles WHERE owner = ?");
$sth->execute($owner);

print "<?xml version='1.0' encoding='UTF-8'?>\n";
print "<articles>\n";
while (my @arreglo = $sth->fetchrow_array){
  print "  <article>\n";
  print "    <owner>$arreglo[0]</owner>\n";
  print "    <title>$arreglo[1]</title>\n";
  print "  </article>\n";
}
print "</articles>\n";
$sth->finish;
$dbh->disconnect;
