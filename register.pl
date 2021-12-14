#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header("text/XML");

my $user= "alumno";
my $password= 'pweb1';
my $userName = $q->param("userName");
my $password = $q->param("password");
my $firstName = $q->param("firstName");
my $lastName = $q->param("lastName");
my $dsn= "DBI:MariaDB:database=pweb1;host=192.168.1.69";
my $dbh= DBI->connect($dsn, $user, $password) or die ("No se ha podido establecer conectar");



