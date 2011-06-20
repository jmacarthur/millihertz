include <params.scad>

module grid()
{
	color([0.5,0.5,0.5]) {
	for(x=[-5:30]) {	
	      translate([x*gridSpacing, -30, 0]) cube(size=[gridWallWidth, 30 * gridSpacing, gridThickness],center=false);
	      translate([-30, x*gridSpacing, 0]) cube(size=[30 * gridSpacing, gridWallWidth, gridThickness],center=false);
	}	
}
}

