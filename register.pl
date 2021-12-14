#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header("text/XML");

my $userB= "alumno";
my $passwordB= 'pweb1';
my $userName = $q->param("userName");
my $password = $q->param("password");
my $firstName = $q->param("firstName");
my $lastName = $q->param("lastName");
my $dsn= "DBI:MariaDB:database=pweb1;host=192.168.1.69";
my $dbh= DBI->connect($dsn, $userB, $passwordB) or die ("No se ha podido establecer conectar");
my $var = 1;
my @arreglo;
my $sth = $dbh->prepare("SELECT * FROM Users WHERE userName = ?"); 
$sth->execute($userName);
if (@rreglo = $sth->fetchrow_array){
    $var = 0;
}

print "<?xml version='1.0' encoding='UTF-8'?>\n";

if ($var == 1){
my $sth = $dbh->prepare("INSERT INTO Users (userName, password, lastName, firstName) VALUES (?,?,?,?)");
$sth->execute($userName, $password, $lastName, $firstName);
$sth = $dbh->prepare("SELECT userName, firstName, lastName FROM Users WHERE userName = ? AND password = ?");
$sth->execute($userName, $password);

  if (my @arreglo = $sth->fetchrow_array){
    print "<user>\n";
    print "<owner>$arreglo[0]</owner>\n";
    print "<firstName>$arreglo[1]</firstName>\n";
    print "<lastName>$arreglo[2]</lastName>\n";
    print "</user>\n";
  }
} else {
    print "<owner>$arreglo[0]</owner>\n";
  }
  $sth->finish;
  $dbh->disconnect;
