#!/usr/bin/env perl

use warnings;
use strict;

if ( @ARGV != 2 )
{
	die "usage: gradient.pl <width> <height>";
}

my $WIDTH  = shift;
my $HEIGHT = shift;

my $last_x = $WIDTH  - 1;
my $last_y = $HEIGHT - 1;

for my $y ( 0 .. $last_y )
{
	for my $x ( 0 .. $last_x )
	{
		my $r = 0;
		my $g = $x * 255 / $last_x;
		my $b = ($last_y - $y) * 255 / $last_y;
		
		my $pixel = join "", map {chr} $b, $g, $r, 0xFF;
		
		print $pixel;
	}
}
