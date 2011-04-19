
include <params.scad>

module dirbox()
{
	difference()
	{
	cube(size=[gridSpacing*10+dirBoxWallWidth*2,gridSpacing*4+dirBoxWallWidth*2,dirBoxHeight]);
	translate([dirBoxWallWidth,dirBoxWallWidth,-1])	cube(size=[gridSpacing*10,gridSpacing*4,dirBoxHeight+2]);
	}
}