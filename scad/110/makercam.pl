#!/usr/bin/perl -w

# Generates cams in OpenSCAD format.
my $pi=3.14159;

my @coords = ();
for my $i (0..359)
{
    my $base = 16;
    my $max = 22; # Base-max needs to be about 7.5
    my $h;
    if($i<150 || $i>220) {
        $h = $base;
    }
    else
    {
        my $deadBand = 15;
        my $cycle = ($i-150)%35; # 0-35
        if($cycle<$deadBand) {$h = $base; }
        else
        {
            $h = ($max-$base)/(35-$deadBand)*($cycle-$deadBand)+$base;
        }
    }
    my $x = cos(2*$pi*$i/360)*$h;
    my $y = sin(2*$pi*$i/360)*$h;
    $xt = sprintf("%8.8f",$x);
    $yt = sprintf("%8.8f",$y);
    
    push @coords, "[$xt, $yt]"
}

print "module movercam(hh) {\n";
print "linear_extrude(height = hh, center = true, convexity = 10, twist = 0)\n";

print "polygon(points=[";
#[0,0],[100,0],[0,100],[10,10],[80,10],[10,80]], paths=[[0,1,2],[3,4,5]]);


print join(",",@coords);
print "], paths=[[";
print join(",",(0..359));
print "]]);\n";
print "}\n";
