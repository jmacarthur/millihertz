include <params.scad>

// Defines wheels for the Turing machine. Wheels need to fit into holes
// in the grid to provide some keying for the machine's position.

// Wheels are Z adjusted to ride on a double-thickness grid. X,Y are adjusted so without translation, the wheel will fit into the grid hole nearest (0,0).

// The wheels used on the first Turing machine were 37mm "flight wheels"
// from technobots, but these seem to have been discontinued. 

//Technobots do however sell a 38mm wheel which looks appropriate

module wheel()
{
	translate([gridWallWidth,gridWallWidth+gridHoleSize/2,axleHeight]) rotate([0,90,0]) {
	difference() {
    	  cylinder(r=wheelRadius,h=wheelWidth);
	  translate([0,0,-1]) cylinder(r=axleBearingDiameter/2,h=wheelWidth+2);
	}
	}
}


