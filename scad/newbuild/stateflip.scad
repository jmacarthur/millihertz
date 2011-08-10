// State flipper.
// Copied from the old Bare Metal source.

include <params.scad>

descent = 10; // Max descent of flipper plates
plateHeight = 12; // Height of top flipper plates above axis
spacing = 2; // Between each flipper
cellWidth = 2*gridSpacing-spacing;

finWidth = 3; // Fins on top bar
wallWidth =6; // Width of state box walls (should be defined elsewhere)

module flipperFin()
{
	translate([0,finWidth,0])
	rotate([90,0,0])

	linear_extrude(height=finWidth) {
		  polygon(points=[[-2,0],[2,0],[0,plateHeight]],paths=[[0,1,2]]);
}
}
module stateFlipper()
{
	offset = (cellWidth-3*finWidth)/2+finWidth;
	translate([0,offset*0,0]) flipperFin();
	translate([0,offset*1,0]) flipperFin();
	translate([0,offset*2,0]) flipperFin();
}

module stateflip()
{
	color([0.5,0.5,0.5]){
	difference() {
	union() {
	   rotate([270,0,0])
		{
		cylinder(h=90,r=2,$fn=40);
	}

	// The top flippers which guide the ball
	for(x=[0:4])
	{
		translate([0,wallWidth+gridSpacing*x*2+spacing/2,0]) rotate([0,-45,0]) 	stateFlipper();

	}

	// The base bits which flip state
	for(x=[2:4])
	{
	translate([0,wallWidth+gridSpacing*x*2+spacing/2,0]) rotate([0,0,0]) 	translate([0,0,-0.5]) cube(size=[descent,cellWidth,1],center=false);
	}
	for(x=[0:1])
	{
	translate([0,wallWidth+gridSpacing*x*2+spacing/2,0]) rotate([0,90,0]) 	translate([0,0,-0.5]) cube(size=[descent,cellWidth,1],center=false);
	}

	// Location bits
	translate([0,wallWidth,0])
	 rotate([270,0,0])
		{
		cylinder(h=1,r=3);
	}
	translate([0,wallWidth+gridSpacing*10-1,0])
	 rotate([270,0,0])
		{
			cylinder(h=1,r=3);
	}

	} // union
	translate([0,-1,0])
	   rotate([270,0,0])
		{
			cylinder(h=92,r=1.5);
	}
	
	rotate([0,-45,0])
	translate([0,0,4])
	rotate([270,0,0])
	{
		cylinder(h=92,r=0.8);
	}
	rotate([0,-45,0])
	translate([0,0,6])
	rotate([270,0,0])
	{
		cylinder(h=92,r=0.5);
	}

	} // difference
	} // colour
}
