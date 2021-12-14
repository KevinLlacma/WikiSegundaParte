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
