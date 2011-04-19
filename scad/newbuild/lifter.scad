include <params.scad>

// Here are  the lifter bars for the Turing machine. The centre is on the axis of
// The lifters, so they can be rotated to alter the position.

// mazeWidth needs to be known.

raiserWallWidth = 2;
raiser1Length = 90;
raiser1Drop = 33;
raiser2Length = 100;
raiser2Drop = 35;

module lifter1()
{
	union() {
	rotate([0,90,0])	cylinder(r=10,h=raiserWallWidth);
	translate([0,-raiser1Length,-10])	cube(size=[raiserWallWidth,raiser1Length,20]) 
	rotate([0,90,0])	cylinder(r=2.5,h=10);

	translate([mazeWidth+raiserWallWidth,0,0]) rotate([0,90,0])	cylinder(r=10,h=raiserWallWidth);
	translate([mazeWidth+raiserWallWidth,-raiser1Length,-10])	cube(size=[raiserWallWidth,raiser1Length,20]) 
	translate([mazeWidth+raiserWallWidth,0,0])	rotate([0,90,0])	cylinder(r=2.5,h=10);
	translate([0,-raiser1Length,-10]) cube(size=[mazeWidth+raiserWallWidth*2,raiserWallWidth,20]);
	translate([mazeWidth/2+raiserWallWidth-35,-raiser1Length-raiserWallWidth,-raiser1Drop-10]) cube(size=[70,raiserWallWidth,raiser1Drop+20]);


	// MAGNETS
	for(x=[-2:2]) {
	translate([mazeWidth/2+raiserWallWidth+gridSpacing*2*x,-raiser1Length-raiserWallWidth+raiserWallWidth*0.5,-raiser1Drop-10]) cylinder(r=2.5,h=2);
	}
	}
}

module lifter2()
{
	union() {
	rotate([0,90,0])	cylinder(r=10,h=raiserWallWidth);
	translate([0,-raiser2Length,-10])	cube(size=[raiserWallWidth,raiser2Length,20]) 
	rotate([0,90,0])	cylinder(r=2.5,h=10);

	translate([mazeWidth+raiserWallWidth*3,0,0]) rotate([0,90,0])	cylinder(r=10,h=raiserWallWidth);
	translate([mazeWidth+raiserWallWidth*3,-raiser2Length,-10])	cube(size=[raiserWallWidth,raiser2Length,20]) 
	translate([mazeWidth+raiserWallWidth*3,0,0])	rotate([0,90,0])	cylinder(r=2.5,h=10);
	translate([0,-raiser2Length,-10]) cube(size=[mazeWidth+raiserWallWidth*4,raiserWallWidth,20]);
	translate([mazeWidth/2+raiserWallWidth*2-35,-raiser2Length-raiserWallWidth,-raiser2Drop-10]) cube(size=[70,raiserWallWidth,raiser2Drop+20]);
	translate([mazeWidth/2+raiserWallWidth*2-35,-raiser2Length-raiserWallWidth,-raiser2Drop-10]) cube(size=[70,raiser2Length-raiser1Length+10,raiserWallWidth]);
	}
}
