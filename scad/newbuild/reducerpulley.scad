include <params.scad>


module pulley()
{
	difference() {
		union() {
		
		cylinder(r=40,h=5);
		translate([0,0,-15]) {
		cylinder(r=5,h=20);
		}
		}

		translate([0,0,-20]) 
		cylinder(r=2.5,h=50);
}
}

pulley1Z = 53;

module reducerPulley(ypos) 
{
	translate([90,ypos,pulley1Z]) {
		rotate([0,90,0])
		pulley();
		}

	translate([95,ypos+120,pulley1Z]) {
		rotate([0,90,0])
		pulley();
		}

	translate([0,ypos,pulley1Z]) {
	rotate([0,90,0]) 
	color([0.5,0.5,0.5])
	cylinder(r=2.5,h=150);
	}
}
