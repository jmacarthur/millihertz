include <params.scad>

// Direction amplifier bar

module diramp()
{
	color([0.5,1,1]) {
	difference() {
		union () {
		translate([-80,-7.5,0]) cube(size=[90,15,3]);
		translate([-85,-23.5,0]) cube(size=[10,31,3]);
		}
		// Main axle
		translate([0,0,-1]) cylinder(r=2.5,h=10);
		// Output holes
		translate([-70,2.5,-1]) cylinder(r=1.5,h=10);
		translate([-75,2.5,-1]) cylinder(r=1.5,h=10);
		translate([-80,2.5,-1]) cylinder(r=1.5,h=10);

		// Input (spring) hole
		translate([-82.5,-20,-1]) cylinder(r=1.5,h=10);
		}
}
}