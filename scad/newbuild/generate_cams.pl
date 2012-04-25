#!/usr/bin/perl -w
use Math::Trig;

# This is for the mover cam
my $lowRadius = 34;
my $engageRadius = 40;
my $highRadius = 50;
my $camWidth = 5;

# This is for all other cams
my $baseRadius = 42;

# Gives position of lifter cam at a given angle - argument is in degrees
sub moverCamFunction
{
    my $t = shift;

    if($t < 170) {
        $r = $lowRadius;
    }
    elsif($t < 320){
	$r = 	$r = $lowRadius + ($t-170)*($highRadius-$lowRadius)/(320-170);
    }
    elsif($t < 330){
	$r = 	$r = $highRadius - ($t-320)*($highRadius-$lowRadius)/(330-320);
    }
    else
    {
	$r = $lowRadius;
    }
    return $r;
}

sub lifterCamFunction
{
    my $t = shift;
    my $lifterBase = $baseRadius - 4;
    if($t<100)
    {
	return $lifterBase+16*($t/100);
    }
    elsif($t<330)
    {
	return $lifterBase+16-12*($t-100)/(330-100);
    }
    else
    {
	return $lifterBase+4-4*($t-330)/(360-330);
    }
}

sub resetCamFunction
{
    my $t = shift;
    if($t<40) {
        return $baseRadius;
    }
    elsif($t<50)
    {
	return $baseRadius+5*($t-40)/(50-40);
    }
    elsif($t<60)
    {
	return $baseRadius+5-5*($t-50)/(60-50);
    }
    else
    {
	return $baseRadius;
    }
}


sub dirAmpCamFunction()
{
    my $t = shift;
    if($t<20) {
        return $baseRadius+2.5*($t-0)/(20-0);
    }
    elsif($t<140) {
        return $baseRadius+2.5;
    }
    elsif($t<160) {
        return $baseRadius+2.5-2.5*($t-140)/(160-140);
    }
    else
    {
        return 42;
    }
}

sub createCam
{
    my ($moduleName, $funcRef) = @_;

    print "module $moduleName"."() { \n";
    print "difference () { \n";
    print "linear_extrude (height=$camWidth) polygon( points=[";
    my $n=0;
    my $points1 = "";
    my $points2 = "";
    my $paths2 = "";
    for(my $t=0;$t<360.0;$t+=5)
    {
	my $r = $funcRef->(360-$t); # Reversing direction here
	# Calculate radius by inequalities
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
    print "translate([-boxWidth/2,-boxWidth/2,-1]) cube(size=[boxWidth,boxWidth,10]);\n";
    print "translate([-10,0,-1]) cylinder(r=1.5,h=10);\n";
    print "translate([10,0,-1]) cylinder(r=1.5,h=10);\n";
    print "}\n"; # Closes difference
    print "}\n"; # Closes module

}


createCam("moverCam",\&moverCamFunction);
createCam("lifterCam",\&lifterCamFunction);
createCam("resetCam",\&resetCamFunction);
createCam("dirAmpCam",\&dirAmpCamFunction);
