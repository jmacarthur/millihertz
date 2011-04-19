include <params.scad>

// The chassis is a ladder frame which supports all the rest of the equipment.
// It's made of 20mm square box section aluminium. 

// Measured from the original machine
chassisInternalSpacing = 95;
chassisWallThickness = 1.5;
chassisThickness = 20;

module squareBoxSection(l)
{
	difference() {
  	  cube(size=[chassisThickness,l,chassisThickness]);
	  translate([chassisWallThickness,-1,chassisWallThickness]) cube (size=[chassisThickness-chassisWallThickness*2, l+2, chassisThickness-chassisWallThickness*2]);
	}
}

module chassis()
{
	translate([0,0,0]) squareBoxSection(405);
	translate([chassisThickness+chassisInternalSpacing,0,0]) squareBoxSection(405);
	translate([chassisThickness,140,0]) rotate([0,0,270]) squareBoxSection(chassisInternalSpacing);
	translate([chassisThickness,140+222.5,0]) rotate([0,0,270]) squareBoxSection(chassisInternalSpacing);
}