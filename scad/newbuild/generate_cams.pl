#!/usr/bin/perl -w
use Math::Trig;

my $lowRadius = 30;
my $engageRadius = 40;
my $highRadius = 47;
my $camWidth = 6;

# Gives position of lifter cam at a given angle - argument is in degrees
sub moverCamFunction
{
    my $t = shift;
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
    return $r;
}

sub lifterCamFunction
{
    my $t = shift;
    if($t<180)
    {
	return 42;
    }
    else
    {
	return 54;
    }
}

sub resetCamFunction
{
    my $t = shift;
    if($t<330)
    {
	return 42;
    }
    else
    {
	return 52;
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
