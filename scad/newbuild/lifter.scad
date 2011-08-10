include <params.scad>

// Here are  the lifter bars for the Turing machine. The centre is on the axis of
// The lifters, so they can be rotated to alter the position.

// mazeWidth needs to be known.

raiser1Length = mazeHoleOffsetY+raiserWallWidth/2+gridSpacing+raiserWallWidth;
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
    translate([mazeWidth*side+(raiserWallWidth+raiserSeparation)*(side*step*2)+(raiserWallWidth*side),0,0] )rotate([0,90,0]) cylinder(r=10,h=raiserWallWidth); 
    translate([mazeWidth*side+(raiserWallWidth+raiserSeparation)*(side*step*2)+(raiserWallWidth*side),-length,-10]) cube(size=[raiserWallWidth,length,20]);
  } 
  translate([0,-length,-10]) cube(size=[mazeWidth+(raiserWallWidth+raiserSeparation)*(2*step)+raiserWallWidth,raiserWallWidth,20]); // cross bar
  }
  translate([-10,0,0]) rotate([0,90,0]) cylinder(r=2.5,h=200); // Axle hole
  }
}

magnet1X = raiserWallWidth-mazeStartX+raiserSeparation+gridSpacing*10;
magnet2X = raiserWallWidth-mazeStartX+raiserSeparation*2+raiserWallWidth+gridSpacing*10;
magnetY = -raiser1Length-raiserWallWidth*0.5+raiserWallWidth;



module lifter1()
{
	
	union() {

	lifterBar(raiser1Length,1);
 // 38 here is arbitrary; it's the start position of the drop plate, which isn't critical
        difference() {
	translate([mazeWidth/2+raiserWallWidth*2-38+raiserSeparation,-raiser1Length,-raiser1Drop-10]) cube(size=[70,raiserWallWidth,raiser1Drop+20]);


	// Magnet holes

	for(x=[-2:2]) {
		translate([magnet1X+gridSpacing*2*x,magnetY,-raiser1Drop-7]) color([0.5,0.5,0.5]) cylinder(r=2.5,h=2);
		translate([magnet1X+gridSpacing*2*x-1,magnetY-5,-raiser1Drop-11]) color([0.5,0.5,0.5]) cube(size=[2,10,5]);
	}
	}
	// Magnets
	for(x=[-2:2]) {
			translate([magnet1X+gridSpacing*2*x,magnetY,-raiser1Drop-7]) color([0.5,0.5,0.5]) cylinder(r=2.5,h=2);
			translate([magnet1X+gridSpacing*2*x,magnetY,-raiser1Drop-10-raiserWallWidth]) color([1.0,0.5,0.5]) cylinder(r=1.5,h=3+raiserWallWidth);

	}

	}
}

module lifter2()
{
	union() {

		lifterBar(raiser2Length,2);	

		translate([mazeWidth/2+raiserWallWidth*2-37+raiserSeparation*2,-raiser2Length,-raiser2Drop-10]) cube(size=[70,raiserWallWidth,raiser2Drop+20]);
		difference() {
		     	translate([mazeWidth/2+raiserWallWidth*3-37+raiserSeparation*2,-raiser2Length,-raiser2Drop-10]) cube(size=[70,raiser2Length-raiser1Length+10,raiserWallWidth]);
			for(x=[-2:2]) {
				translate([magnet2X+gridSpacing*2*x,magnetY,-raiser2Drop-11]) cylinder(r=3,h=5);
			}
       		}
	}
}

module lifter3()
{
	rXrel=0-mazeStartX+raiserWallWidth*4+row1x;

	union() {

	lifterBar(raiser3Length,3);

	translate([mazeWidth/2+raiserWallWidth*3-35+raiserSeparation*3,-raiser3Length,-raiser3Drop-10]) cube(size=[70,raiserWallWidth,raiser3Drop+20]); // Vertical plate


	difference()
	{
	translate([mazeWidth/2+raiserWallWidth*5-45+raiserSeparation*3,-raiser3Length,-raiser3Drop-10]) cube(size=[80,raiser3Length-raiser1Length+10,raiserWallWidth]);
	for(x=[0:4]) {
	for(y=[-2:0]) {
	translate([rXrel+gridSpacing*2*x+raiserSeparation*3,-raiser1Length+raiserWallWidth*0.5+gridSpacing*2*y,-raiser3Drop-10-1]) cylinder(r=5,h=20);
}
	translate([rXrel+gridSpacing*2*x-5+raiserSeparation*3,-raiser1Length+raiserWallWidth*0.5,-raiser3Drop-10-1]) cube(size=[10,20,raiserWallWidth+2]);
	}
	}
	// Alignment beam - should all be in line with row1x
	color([255,0,0]) translate([rXrel,-raiser1Length,-100]) cylinder(r=0.5,h=300);
	}
}
