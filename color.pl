#!/usr/bin/perl
use strict;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

my %colors = (  red     => "#ff0000",
                green   => "#00ff00",
                blue    => "#0000ff",
                gold    => "#cccc00");

print header;

my $color = param('color');

# do some validation - be sure they picked a valid color
if (exists $colors{$color}) {
   print start_html(-title=>"Pick a Color", -bgcolor=>$color);
   #print "You picked $color.<br>\n";
} else {
   print start_html(-title=>"Pick a Color");
   #print "You didn't pick a color! (You picked '$color')\n";
}

print "<form action=\"color.pl\" method=\"POST\">\n";
print "<input type=\"radio\" name=\"color\" value=\"red\"> Red<br>\n";
print "<input type=\"radio\" name=\"color\" value=\"green\"> Green<br>\n";
print "<input type=\"radio\" name=\"color\" value=\"blue\"> Blue<br>\n";
print "<input type=\"radio\" name=\"color\" value=\"gold\"> Gold<br>\n";
print "<input type=\"submit\">\n";
print "</form>\n";

print end_html;
