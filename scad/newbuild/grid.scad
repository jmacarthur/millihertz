include <params.scad>

module grid()
{
	for(x=[0:30]) {	
	      translate([x*gridSpacing, 0, 0]) cube(size=[gridWallWidth, 30 * gridSpacing, gridThickness],center=false);
	      translate([0, x*gridSpacing, 0]) cube(size=[30 * gridSpacing, gridWallWidth, gridThickness],center=false);
	}	
}

