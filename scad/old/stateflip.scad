// State flipper. 

include <params.scad>
include <statebox.scad>

descent = 10; // Max descent of flipper plates
plateHeight = 12; // Height of top flipper plates above axis
spacing = 2; // Between each flipper
cellWidth = 2*gridSeparation-spacing;

finWidth = 3; // Fins on top bar

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
		flipperFin();
	offset = (cellWidth-3*finWidth)/2+finWidth;
	translate([0,offset*1,0]) flipperFin();
	translate([0,offset*2,0]) flipperFin();
}

module stateflip()
{
	color([0.5,0.5,0.5]){
	difference() {
	union() {
          translate([0,5,0])
	   rotate([270,0,0])
		{
		cylinder(h=78,r=2.5,$fn=40);
	}

	// The top flippers which guide the ball
	for(x=[0:4])
	{
		translate([0,wallWidth+gridSeparation*x*2+spacing/2,0]) rotate([0,-45,0]) 	stateFlipper();

	}

	// The base bits which flip state
	for(x=[2:4])
	{
	translate([0,wallWidth+gridSeparation*x*2+spacing/2,0]) rotate([0,0,0]) 	translate([0,0,-0.5]) cube(size=[descent,cellWidth,1],center=false);
	}
	for(x=[0:1])
	{
	translate([0,wallWidth+gridSeparation*x*2+spacing/2,0]) rotate([0,90,0]) 	translate([0,0,-0.5]) cube(size=[descent,cellWidth,1],center=false);
	}


	} // union
	translate([0,-1,0])
	   rotate([270,0,0])
		{
                  cylinder(h=92,r=1.5,$fn=30);
	}
	

	} // difference
	} // colour
}
