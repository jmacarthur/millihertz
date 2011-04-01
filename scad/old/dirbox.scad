include <params.scad>

dirBoxCentreX = dirBoxInternalX/2+dirBoxWallWidth;

module hollowtube(l,r)
{
	difference() {
		     cylinder(h=l,r=r);
		     translate([0,0,-l*0.01])
		     #cylinder(h=l*1.02,r=r*0.75);
		     }

}
module dirbox()
{
	color([0.2,0.2,0.0])
	{
	difference() {
		union() {
			cube(size=[dirBoxSizeX,dirBoxWallWidth,dirBoxSizeZ],center=false);	
			cube(size=[dirBoxWallWidth,dirBoxSizeY+2.5,dirBoxSizeZ],center=false);	
			translate([-2.5,dirBoxInternalY+dirBoxWallWidth,0]) {
			        cube(size=[dirBoxSizeX+2.5,dirBoxWallWidth,dirBoxSizeZ],center=false);	
		        }
			translate([dirBoxInternalX+dirBoxWallWidth,0,0]) {
			        cube(size=[dirBoxWallWidth,dirBoxInternalY+2*dirBoxWallWidth,10],center=false);	
			}
			// Internal gates

			for(x=[1:4]) {
			translate([dirBoxWallWidth,dirBoxWallWidth+gridSeparation*2*x-0.5,0])
			cube([dirBoxInternalX,1,dirBoxSizeZ]);
			}

			// Locator pins
			translate([dirBoxWallWidth+gridSeparation*3,dirBoxWallWidth-gridSeparation,-5])
			rotate([0,0,270])
			hollowtube(5+dirBoxSizeZ,2.5);
			translate([dirBoxWallWidth-gridSeparation,dirBoxWallWidth+gridSeparation*11,-5])
			rotate([0,0,270])
			hollowtube(5+dirBoxSizeZ,2.5);
		}

		// Cut out axle hole
		translate([dirBoxSizeX/2,-1,dirBoxSizeZ])
		{
			rotate([270,0,0]){
				cylinder(h=dirBoxSizeY+2, r=2, center=false);
			}
		}

		// Drill lots of holes to save volume
		for (x=[0:6])
		{
		translate([dirBoxWallWidth/2+x*6, dirBoxWallWidth/2, -1])
		rotate([0,0,270])
		#cylinder(r=2,h=dirBoxSizeZ+2);
		translate([dirBoxWallWidth/2+x*6, dirBoxInternalY+dirBoxWallWidth*1.5, -1])
		rotate([0,0,270])
		#cylinder(r=2,h=dirBoxSizeZ+2);

		translate([dirBoxWallWidth/2+x*6, -1, 5])
		rotate([270,0,0])
		#cylinder(r=2,h=dirBoxSizeY+10);
		}
		for (x=[1:12])
		{
		translate([dirBoxWallWidth/2, dirBoxWallWidth/2+x*6.2, -1])
		rotate([0,0,270])
		#cylinder(r=2,h=dirBoxSizeZ+2);
		translate([dirBoxWallWidth*1.5+dirBoxInternalX, dirBoxWallWidth/2+x*6.2, -1])
		rotate([0,0,270])
		#cylinder(r=2,h=dirBoxSizeZ+2);
		}
	}
	}
}

// direction flipper
module dirbar()
{
	color([0.5,0.5,0.5])
	difference()
	{
	union(){
			translate([dirBoxInternalX/2+dirBoxWallWidth,-15,10])
			rotate([270,0,0]) 
			cylinder(h=105,r=2,$fn=40); // Central bar

				translate([dirBoxCentreX,-5,10])
				rotate([270,0,0])
				cylinder(h=5,r=3); // End stop 1

				translate([dirBoxCentreX,dirBoxInternalY+2*dirBoxWallWidth,10])
				rotate([270,0,0])
				cylinder(h=5,r=3); // End stop 2

			// Output bar
			translate([0,-21+6,10-2.5])
			cube([42,1,5]);

			// Flippers
			translate([dirBoxCentreX-10,dirBoxWallWidth+gridSeparation,10])
			rotate([0,90,0]) 
			hollowtube(20,2);

			translate([dirBoxCentreX-10,dirBoxWallWidth+9*gridSeparation,10])
			rotate([0,90,0])
				hollowtube(20,2);
	} // union
	translate([dirBoxInternalX/2+dirBoxWallWidth,-17,10])	
	rotate([270,0,0]) 
	#cylinder(h=150,r=1); // Central hollow axle

	for (x=[-18,18,-12,12,6,-6]) {
	translate([dirBoxInternalX/2+dirBoxWallWidth+x,-17,10])	
	rotate([270,0,0]) 
	#cylinder(h=5,r=1.5,$fn=20); // Eyelet hole
	}
	} // diff
}

