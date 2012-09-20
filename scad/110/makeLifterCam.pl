#!/usr/bin/perl -w

# Generates cams in OpenSCAD format.
my $pi=3.14159;

sub makeCoords
{
    my $inner = shift;
    my @coords = ();
    for my $i (0..359)
    {
        my $base;
        my $max;
        if($inner) {
            $base = 5;
            $max = 19;
        } else {
            $base = 8;
            $max = 22; # Base-max needs to be about 7.5
        }
        my $h;
        if($i<45) {
            $h = $base;
        }
        elsif ($i<160) {
            $h = ($max-$base)*($i-45)/(160-45)+$base
        }
        elsif ($i<200) {
            $h = $max;
        }
        elsif($i<315) {
            $h = ($max-$base)*(315-$i)/(115)+$base;
        }
        else {
            $h = $base;
        }
        my $x = cos(2*$pi*$i/360)*$h;
        my $y = sin(2*$pi*$i/360)*$h;
        $xt = sprintf("%8.8f",$x);
        $yt = sprintf("%8.8f",$y);
        
        push @coords, "[$xt, $yt]"
    }
    return \@coords;
}

my $coords = makeCoords(0);
my $innercoords = makeCoords(1);

print "module liftercam() {\n";
print "linear_extrude(height = 5, center = true, convexity = 10, twist = 0)\n";

print "polygon(points=[";
print join(",",@$coords);
print "], paths=[[";
print join(",",(0..359));
print "]]);\n";
print "}\n";

print "module liftercamCutout() {\n";
print "linear_extrude(height = 5, center = true, convexity = 10, twist = 0)\n";

print "polygon(points=[";
print join(",",@$innercoords);
print "], paths=[[";
print join(",",(0..359));
print "]]);\n";
print "}\n";
