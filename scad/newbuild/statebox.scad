
include <params.scad>

module statebox()
{
	difference()
	{
	cube(size=[gridSpacing*10+stateBoxWallWidth*2,gridSpacing*4+stateBoxWallWidth*2,stateBoxHeight]);
	translate([stateBoxWallWidth,stateBoxWallWidth,-1])	cube(size=[gridSpacing*10,gridSpacing*4,stateBoxHeight+2]);
	}
}