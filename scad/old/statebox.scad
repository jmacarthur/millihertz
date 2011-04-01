include <params.scad>

wallWidth = 6;
stateBoxInternalX = 4*gridSeparation;
stateBoxInternalY = 10*gridSeparation;

stateBoxCentreX = wallWidth + stateBoxInternalX/2;
stateBoxHeight = 25;
prodHeight = 72;
stateFlipAxleZ = 15;

module statebox() 
{
	union() {
        cube(size=[stateBoxInternalX+wallWidth*2,wallWidth,stateFlipAxleZ],center=false);	
        cube(size=[wallWidth,stateBoxInternalY+2*wallWidth,stateBoxHeight],center=false);	
	translate([0,stateBoxInternalY+wallWidth,0]) {
	        cube(size=[stateBoxInternalX+wallWidth,wallWidth,stateFlipAxleZ],center=false);	
        }
	translate([stateBoxInternalX+wallWidth,0,0]) {
        cube(size=[wallWidth,stateBoxInternalY+wallWidth*2,stateBoxHeight],center=false);	
	}
	// Support bars at back
	translate([-wallWidth,wallWidth+gridSeparation*2,0]) {
	cube(size=[wallWidth,wallWidth,prodHeight],center=false);
	}
	translate([-wallWidth,gridSeparation*8,0]) {
	cube(size=[wallWidth,wallWidth,prodHeight],center=false);
	}
	translate([-wallWidth,wallWidth+gridSeparation*2,prodHeight-5]) {
	cube(size=[35,wallWidth,wallWidth],center=false);
	}
	translate([-wallWidth,gridSeparation*8,prodHeight-5]) {
	cube(size=[35,wallWidth,wallWidth],center=false);
	}
	// Top bar to knock balls off
	translate([25,wallWidth,prodHeight-5]) 
	difference() {	
	cube(size=[5,gridSeparation*10,wallWidth],center=false);
	translate([1,-1,1])
	#	cube(size=[3,gridSeparation*10+2,wallWidth-2],center=false);
	}


	// State sep bars
	for(x=[1:4]) {
	translate([0,gridSeparation*2*x+wallWidth-0.5,0]) {
	cube(size=[stateBoxInternalX+wallWidth,1,15],center=false);
	}
	}


	// Location pins
	for(x=[0,1])
	for(y=[0,1])
	{
	translate([wallWidth/2+x*(wallWidth+dirBoxInternalX),wallWidth/2+y*(wallWidth+dirBoxInternalY),-5])
	rotate([0,0,270])
	cylinder(h=10,r=2);
	}
}	
}

module punchedStateBox()
{
	color([0.0,0.2,0.5]) 
	difference() {
		statebox();
		translate([stateBoxCentreX,-10,0]) rotate([270,0,0])
			cylinder(h=120,r=2);
		translate([stateBoxCentreX,-10,stateFlipAxleZ]) rotate([270,0,0])
			cylinder(h=120,r=2);

			// Now punch a load of holes
		if(lightening) 
		{
		for(y=([0:4]))
		{
		translate([-1,wallWidth+1+y*2*gridSeparation,1])
		#		cube([50,6,stateBoxHeight-2]);
		translate([-1,wallWidth+1+y*2*gridSeparation+7,1])
		#		cube([50,6,stateBoxHeight-2]);
		}

		for(z=[0,1,3])
		{
		translate([-1,wallWidth/2,3+6*z])
		rotate([0,90,0])	
		#cylinder(h=50,r=2);
		translate([-1,wallWidth*1.5+stateBoxInternalY,3+6*z])
		rotate([0,90,0])	
		#cylinder(h=50,r=2);
		}
		}
	}
}

