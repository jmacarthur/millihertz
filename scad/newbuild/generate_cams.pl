#!/usr/bin/perl -w
use Math::Trig;

# This is for the mover cam
my $lowRadius = 34;
my $engageRadius = 40;
my $highRadius = 50;
my $camWidth = 6;

# This is for all other cams
my $baseRadius = 42;

# Gives position of lifter cam at a given angle - argument is in degrees
sub moverCamFunction
{
    my $t = shift;

    if($t < 70) {
	$r = $lowRadius + ($t)*($highRadius-$lowRadius)/70;
    }
    elsif($t < 180){
	$r = $lowRadius;     
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
    if($t<90)
    {
	return $baseRadius;
    }
    elsif($t<180)
    {
	return $baseRadius+12*($t-90)/(90);
    }
    else
    {
	return $baseRadius+12;
    }
}

sub resetCamFunction
{
    my $t = shift;
    if($t<150 && $t >120)
    {
	return $baseRadius+5*($t-120)/(150-120);
    }
    else
    {
	return $baseRadius;
    }
}


sub dirAmpCamFunction()
{
    my $t = shift;
    if($t<(360*0.45)) {
        return 42+2.5;
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
    print "union () { \n";
    print "linear_extrude (height=$camWidth) scale([-1,1]) polygon( points=[";
    my $n=0;
    my $points1 = "";
    my $points2 = "";
    my $paths2 = "";
    for(my $t=0;$t<360.0;$t+=5)
    {
	my $r = $funcRef->($t);
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
    

    print "cylinder(r=5,h=10);\n";
    print "}\n";
    print "}\n";
    print "}\n";

}


createCam("moverCam",\&moverCamFunction);
createCam("lifterCam",\&lifterCamFunction);
createCam("resetCam",\&resetCamFunction);
createCam("dirAmpCam",\&dirAmpCamFunction);
