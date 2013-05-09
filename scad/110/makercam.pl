#!/usr/bin/perl -w

# Generates cams in OpenSCAD format.
my $pi=3.14159;

my @coords = ();
for my $i (0..359)
{
    my $base = 16;
    my $max = 25; # Base-max needs to be about 7.5
    my $h;
    if($i<150 || $i>240) {
        $h = $base;
    }
    else
    {
        my $deadBand = 25;
        my $cycle = ($i-150)%45; # 0-35
        if($cycle<$deadBand) {$h = $base; }
        else
        {
            $h = ($max-$base)/(45-$deadBand)*($cycle-$deadBand)+$base;
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

print join(",",@coords);
print "], paths=[[";
print join(",",(0..359));
print "]]);\n";
print "}\n";
