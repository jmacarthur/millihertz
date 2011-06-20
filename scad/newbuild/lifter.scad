include <params.scad>

// Here are  the lifter bars for the Turing machine. The centre is on the axis of
// The lifters, so they can be rotated to alter the position.

// mazeWidth needs to be known.

raiserWallWidth = 3;
raiser1Length = mazeHoleOffsetY+raiserWallWidth/2+gridSpacing;
raiser1Drop = 32;
raiser2Length = raiser1Length+10;
raiser2Drop = 35;
raiser3Length = raiser1Length+5*gridSpacing;
raiser3Drop = 40;

// Makes a generic lifter bar of a given length and step number (1-based)
// 1 is the innermost lifter.
module lifterBar(length, step)
{
  difference() {
  union() {
  for(side=[0:1]) {
    translate([mazeWidth*side+raiserWallWidth*(side*step*2)+(raiserWallWidth*side),0,0] )rotate([0,90,0]) cylinder(r=10,h=raiserWallWidth); 
    translate([mazeWidth*side+raiserWallWidth*(side*step*2)+(raiserWallWidth*side),-length,-10]) cube(size=[raiserWallWidth,length,20]);
  } 
  translate([0,-length,-10]) cube(size=[mazeWidth+raiserWallWidth*2*(step+1),raiserWallWidth,20]); // cross bar
  }
  translate([-10,0,0]) rotate([0,90,0]) cylinder(r=2.5,h=200); // Axle hole
  }
}

module lifter1()
{
	union() {

	lifterBar(raiser1Length,1);

	translate([mazeWidth/2+raiserWallWidth*2-38,-raiser1Length-raiserWallWidth,-raiser1Drop-10]) cube(size=[70,raiserWallWidth,raiser1Drop+20]);


	// MAGNETS
	for(x=[-2:2]) {
	translate([raiserWallWidth-mazeStartX+gridSpacing*10+gridSpacing*2*x,-raiser1Length-raiserWallWidth+raiserWallWidth*0.5,-raiser1Drop-10]) cylinder(r=2.5,h=2);
	}
	}
}

module lifter2()
{
	union() {

	lifterBar(raiser2Length,2);	

	translate([mazeWidth/2+raiserWallWidth*2-35,-raiser2Length-raiserWallWidth,-raiser2Drop-10]) cube(size=[70,raiserWallWidth,raiser2Drop+20]);
	translate([mazeWidth/2+raiserWallWidth*3-35,-raiser2Length-raiserWallWidth,-raiser2Drop-10]) cube(size=[70,raiser2Length-raiser1Length+10,raiserWallWidth]);
	}
}

module lifter3()
{
	rXrel=0-mazeStartX+raiserWallWidth*4+row1x;

	union() {

	lifterBar(raiser3Length,3);

	translate([mazeWidth/2+raiserWallWidth*3-35,-raiser3Length-raiserWallWidth,-raiser3Drop-10]) cube(size=[70,raiserWallWidth,raiser3Drop+20]); // Vertical plate


	difference()
	{
	translate([mazeWidth/2+raiserWallWidth*5-45,-raiser3Length-raiserWallWidth,-raiser3Drop-10]) cube(size=[80,raiser3Length-raiser1Length+10,raiserWallWidth]);
	for(x=[0:4]) {
	for(y=[-2:0]) {
	translate([rXrel+gridSpacing*2*x,-raiser1Length-raiserWallWidth+raiserWallWidth*0.5+gridSpacing*2*y,-raiser3Drop-10-1]) cylinder(r=5,h=20);
}
	translate([rXrel+gridSpacing*2*x-5,-raiser1Length-raiserWallWidth+raiserWallWidth*0.5,-raiser3Drop-10-1]) cube(size=[10,20,raiserWallWidth+2]);
	}
	}
	// Alignment beam - should all be in line with row1x
	color([255,0,0]) translate([rXrel,-raiser1Length,-100]) cylinder(r=0.5,h=300);
	}
}
