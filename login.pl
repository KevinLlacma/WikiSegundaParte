#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q=CGI->new;
print $q->header("text/XML");

my $user = $q->param("user");
my $password = $q->param("password");
my $userB = "alumno";
my $passwordB = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.69";
my $dbh = DBI->connect($dsn, $userB, $passwordB) or die ("No se ha podido establecer la conexion");

my $sth = $dbh->prepare("SELECT userName, firstName, lastName FROM users WHERE userName = ? AND password = ?");
$sth->execute($user, $password);

