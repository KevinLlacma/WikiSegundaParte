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
my $lineas = $_[0]; 
my $var = 0;
$lineas =~ s/\n/\|/g;
while($lineas =~ /^([^|]+)\|(.+)/){
    $lineas = $2;
    $datos[$var] = $1;
    $var++;
}
$datos[$var] = $lineas;
$var++;
return @datos;
}


if(my @arreglo = $sth->fetchrow_array){
   my @text = &array($arreglo[0]);
   my $var = 0;
   foreach my $linae (@text){
     if(!($var == 1)&&($linae !~ /^```/)){
        $linae = &conversor($linae);
     }else{
       if ($var == 1){
         if($linae !~ /^```/){
            print "$linae\n";
         }else{
           $var = 0;
           print "</code></pre>\n";
          }
      }else{
        print "<pre><code>\n";
        $var = 1;
      }
      next;
     }
     if($linae =~ /.+\[(.+)\]\((.+)\)/){
       print "<p><a href='$2'>$1</a></p>";
       next;
     }
     print $linae;
   }
  }

sub conversor{
my $linae = $_[0];
if ($linae =~ /^#/){ 
  if($linae =~ /^# /){
      $linae =~ s/# /<h1>/g;
      $linae =  $linae."</h1>\n";
   }elsif ($linae =~ /^## /){ 
     $linae =~ s/## /<h2>/g;
     $linae =  $linae."</h2>\n";
    }elsif ($linae =~ /^### /){ 
      $linae =~ s/### /<h3>/g;
      $linae =  $linae."</h3>\n";
     }elsif ($linae =~ /^###### /){ 
       $linae =~ s/###### /<h6>/g;
       $linae =  $linae."</h6>\n";
     }                 
}
else{
  $linae = "<p>".$linae."</p>\n";
}                 
if ($linae =~ /~~/){
  $linae =~ s/~~/<del>/;
  $linae =~ s/~~/<\/del>/;
}
if ($linae =~ /\*\*\*/){ 
   $linae =~ s/\*\*\*/<strong><em>/;
   $linae =~ s/\*\*\*/<\/em><\/strong>/;
}
if ($linae =~ /\*\*/){ 
   $linae =~ s/\*\*/<strong>/;
   $linae =~ s/\*\*/<\/strong>/;
}
      
if ($linae =~ /\*/){ 
   $linae =~ s/\*/<em>/;
   $linae =~ s/\*/<\/em>/;
}
if ($linae =~ /\s_/){
   $linae =~ s/_/<em> /;
   $linae =~ s/_/<\/em> /;
}
return $linae;
}

$sth->finish;
$dbh->disconnect;
