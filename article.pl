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


