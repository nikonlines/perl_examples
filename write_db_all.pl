#!/usr/bin/perl -wT

use strict;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

my $remote_ip = $ENV{ REMOTE_ADDR };
my $remote_host = $ENV{ REMOTE_HOST };
my $proxy_ip = $ENV{ HTTP_X_FORWARDED_FOR };
my $cookie = $ENV{ HTTP_COOKIE };
my $request_method = $ENV{ REQUEST_METHOD };

my $post_login = param('login');
my $post_password = param('password');

print header;

print "<form action=\"write_db_all.pl\" method=\"POST\">\n";
print "Login: <input type=\"text\" name=\"login\"><br>\n";
print "Password: <input type=\"password\" name=\"password\"><br>\n";
print "<input type=\"submit\">\n";
print "</form>\n";

print "Content-type: text/html\n\n"; 
print "IP: $remote_ip <br>";
print "Hostname: $remote_host <br>";
print "IP proxy: $proxy_ip <br>";
print "Cookie: $cookie <br>";
print "Request method: $request_method <br>";

print end_html;

#----------------------------

if ($post_login != "" or $post_password != "") {

use DBI;

#definition of variables
my $db="db";
my $db_host="mysql";
my $db_user="root";
my $db_password="root";

#connect to MySQL database
my $connection = DBI->connect ("DBI:mysql:database=$db:host=$db_host", $db_user, $db_password) 
  or die "Can't connect to database: $DBI::errstr\n";

# set the value of your SQL query
my $query = "insert into users (LOGIN, PASSWORD)
          values (?, ?)";

# prepare your statement for connecting to the database
my $statement = $connection->prepare($query);

# execute your SQL statement
$statement->execute($post_login, $post_password);

#---------------------

warn "Problem in retrieving results", $statement->errstr( ), "\n"
  if $statement->err( );

#disconnect  from database 
$connection->disconnect or warn "Disconnection error: $DBI::errstr\n";

exit;

}