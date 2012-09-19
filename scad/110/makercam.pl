#!/usr/bin/perl -w

# Generates cams in OpenSCAD format.
my $pi=3.14159;

my @coords = ();
for my $i (0..359)
{
	my $base = 21;
	my $h;
	if($i<150 || $i>220) {
	   $h = $base;
	}
	else
	{
	if((($i-150)%35)>25)
{
	$h = $base;
}
else
{
	    $h=(($i-150)%35)/2+$base;
}
	}
		my $x = cos(2*$pi*$i/360)*$h;
		my $y = sin(2*$pi*$i/360)*$h;
		$xt = sprintf("%8.8f",$x);
		$yt = sprintf("%8.8f",$y);
		
		push @coords, "[$xt, $yt]"
}
print "module movercam() {\n";
print "linear_extrude(height = 5, center = true, convexity = 10, twist = 0)\n";

print "polygon(points=[";
#[0,0],[100,0],[0,100],[10,10],[80,10],[10,80]], paths=[[0,1,2],[3,4,5]]);


print join(",",@coords);
print "], paths=[[";
print join(",",(0..359));
print "]]);\n";
print "}\n";
