
include <params.scad>

module statebox()
{
	difference()
	{
	cube(size=[gridSpacing*10+stateBoxWallWidth*2,gridSpacing*4+stateBoxWallWidth*2,stateBoxHeight]);
	translate([stateBoxWallWidth,stateBoxWallWidth,-1])	cube(size=[gridSpacing*10,gridSpacing*4,stateBoxHeight+2]);
	// Space for spring support
	translate([dirBoxWallWidth-10,-1,-1.5]) cube(size=[gridSpacing*4,dirBoxWallWidth+1.5,3]);
	}
}