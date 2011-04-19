include <params.scad>

// Here are  the lifter bars for the Turing machine. The centre is on the axis of
// The lifters, so they can be rotated to alter the position.

// mazeWidth needs to be known.

raiserWallWidth = 2;
module lifter1()
{
	rotate([0,90,0])	cylinder(r=10,h=raiserWallWidth);
	translate([0,-90,-10])	cube(size=[raiserWallWidth,90,20]) 
	rotate([0,90,0])	cylinder(r=2.5,h=10);

	translate([mazeWidth+raiserWallWidth,0,0]) rotate([0,90,0])	cylinder(r=10,h=raiserWallWidth);
	translate([mazeWidth+raiserWallWidth,-90,-10])	cube(size=[raiserWallWidth,90,20]) 
	translate([mazeWidth+raiserWallWidth,0,0])	rotate([0,90,0])	cylinder(r=2.5,h=10);
}