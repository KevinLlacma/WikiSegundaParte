#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
my $user = "alumno";
my $password = 'pweb1';
my $owner = $q->param("owner");
my $title = $q->param("title");
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.69";
my $dbh = DBI->connect($dsn, $user, $password) or die ("No se ha podido establecer conexion");
my $sth = $dbh->prepare("SELECT owner, title, text FROM Articles WHERE owner = ? and title = ?");
$sth->execute($owner, $title);
print $q->header("text/XML");

while (my @arreglo = $sth->fetchrow_array){
  print <<BLOCK;
  <?xml version='1.0' encoding='utf-8'?>
   <article>
    <owner>$owner</owner>
    <title>$arreglo[0]</title>
    <text>$arreglo[1]</text>
   </article>
  BLOCK
} 
  $sth->finish;
  $dbh->disconnect;
