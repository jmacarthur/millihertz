// Comment this line out if you want a 'solid' model. lightening is done 
// for shapeways models where we're charged by the cubic mm.
lightening = true;

gridSeparation = 7.58;
mazeSizeX = 95;
railSeparation = 10*gridSeparation; // Internal space between rails
railWidth = 20; // Rail width & height (assumed square)

// Direction box

dirBoxWallWidth = 6;
dirBoxInternalX = 4*gridSeparation;
dirBoxInternalY = 10*gridSeparation;
dirBoxSizeX = dirBoxInternalX+2*dirBoxWallWidth;
dirBoxSizeZ = 10;
dirBoxSizeY = dirBoxInternalY+2*dirBoxWallWidth;


gridMetalWidth = gridSeparation-6;
gridHeight = 1;

axle1X = -gridSeparation*30;
axle2X = 0;
axle3X = gridSeparation*30;


wheelDiameter=37.6;
wheelRadius = wheelDiameter/2;
wheelAxleZ = -2;

wheelAxleRadius = 1.5;

// Centre of the camshaft, relative to this model
camZ = 70;
camX = -70;

camDistance = sqrt((camZ-followerZ)*(camZ-followerZ) + (camX-followerX)*(camX-followerX));

camRadius = camDistance - followerRadius;


/* Hollow bar, extends along the Z axis */
module hollowBar(h)
{
	difference() {
		     cube([5,5,h]);

		     translate([0.7,0.7,-1])
		     #cube([3.6,3.6,h+2]);

		     // Drain hole
		     translate([-1,2.5,h/2])
	    		rotate([0,90,0])	
			cylinder(r=1.5,h=7);

		     }

}
