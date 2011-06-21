#!/usr/bin/perl -w
use Math::Trig;

my $lowRadius = 30;
my $engageRadius = 40;
my $highRadius = 47;

print "module moverCam() { \n";
print "difference () { \n";
print "union () { \n";
print "linear_extrude (height=10) scale([-1,1]) polygon( points=[";
my $n=0;
my $points1 = "";
my $points2 = "";
my $paths2 = "";
for(my $t=0;$t<360.0;$t+=5)
{
    # Calculate radius by inequalities
    if($t < 90) {
	$r = $lowRadius + (90-$t)*($highRadius-$lowRadius)/90;
    }
    elsif($t < 180){
	$r = $lowRadius;     
    }
    elsif($t < 200) {
	$r = $lowRadius + ($t-180)*($engageRadius-$lowRadius)/20;
    }
    elsif($t < 350) {
	$r = $engageRadius + ($t-200)*($highRadius-$engageRadius)/(350-200);
    }
    else
    {
	$r = $highRadius;
    }
    my $x = $r*cos(deg2rad($t));
    my $y = $r*sin(deg2rad($t));
    $points1 .= sprintf("[%0.5f,%0.5f],",$x,$y);

    $ir = $r - 5;
    my $x2 = $ir*cos(deg2rad($t));
    my $y2 = $ir*sin(deg2rad($t));
    $points2 .= sprintf("[%0.5f,%0.5f],",$x2,$y2);
    $paths .= "$n,";
    $n++;
}

print "$points1], \n";
print "paths = [[$paths 0]] );\n";


print "cylinder(r=5,h=10);\n";
print "}\n";
print "}\n";
print "}\n";
