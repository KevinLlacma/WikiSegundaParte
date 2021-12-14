#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header("text/XML");

my $user = "alumno";
my $password= 'pweb1';
my $owner = $q->param("owner");
my $title = $q->param("title");
my $text = $q->param("text");
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.69";
my $dbh = DBI->connect($dsn, $user, $password) or die ("No se ha podido establecer conexion");
my $sth = $dbh->prepare("UPDATE Articles SET text = ? WHERE owner = ? AND title = ?");
$sth->execute($text, $owner, $title);
$sth= $dbh->prepare("SELECT title, text FROM Articles WHERE owner = ? AND title = ?");
$sth->execute($owner, $title);
print "<?xml version='1.0' encoding='UTF-8'?>\n";
if (my @arreglo = $sth->fetchrow_array){
    print "<article>\n";
    print "<title>$arreglo[0]</title>\n";
    print "<text>$arreglo[1]</text>\n";
    print "</article>\n";
}
$sth->finish;
$dbh->disconnect;
