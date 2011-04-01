#!/usr/bin/perl -w
use Math::Trig;

my $lowRadius = 18.3;
my $engageRadius = 36.2;
my $highRadius = 60.5;

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
    $paths2 .= "$n+72,";
    $n++;
    print "t=$t; r=$r\n";
}

print "$points1 $points2], \n";
print "paths = [[$paths 0],[$paths2 72]] );\n";

# Some spokes
print "cylinder(r=5,h=10);\n";
print "cube([$lowRadius-2.5,5,10]);\n";
print "cube([5,$lowRadius-2.5,10]);\n";
print "translate([-2.5,-45,0]) cube([5,45,10]);\n";
print "rotate([0,0,-45]) translate([-2.5,-50,0]) cube([5,50,10]);\n";
print "translate([-$highRadius+5,-2.5,0]) cube([$highRadius-5,5,10]);\n";
print "}\n";
print "# translate([0,0,-1]) cylinder(r=3,h=12);\n";
print "}\n";
print "}\n";
