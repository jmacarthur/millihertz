include <params.scad>

/* This defines the 'mover tower', and the three levers which
   move in it to move the whole machine forwards and backwards.

   The 'flipper' sits near the bottom and decides which way
   the mover will go.
   The three rods are the 'pusher' (bottom), rod2 (middle)
   and the top rod. The top and middle rods are called con rods.

*/



rollerDiam = 16;
flipperPos =  -45; // Rotation of flipper 
followerRadius = 10;

// Contact position: rollerHeight=12, pusherRotate = 18; rodRotate = 23.5;
// Downposition: rollerHeight=2, pusherRotate = 43; rod2Rotate = 0;
// Up position: rollerHeight = 40; pusherRotate = 0; rod2Rotate = 47;

{
	rollerHeight = 12;
	pusherRotate = 18; // positive goes forward
	rod2Rotate = 23.5;
}


/* A note on positioning
   The data is assumed to be central, that is the centre data row
   runs directly down the centre of the rails.
   this means the pusher must be offset to one side.
   The rails are 10  grid spaces apart, i.e 75.8mm.
   The centre line is at 5 grid spaces in
   And the ideal location for the pusher will be at 4 or 6.
*/
pusherWidth = 1;

pushRodY = 4*gridSeparation-pusherWidth/2; // This is critical - it determines where the 
	 // mover pin falls. It must be in the grid space between
	 // Two rows of data and must be as central as possible.


conRodLen=60; // Length of 'con rods'

towerWidthY = 29;
towerPosY = pushRodY-15;

// Assert : 2*conRodLen*sin(rod2Rotate)+rollerHeight = 2*conRodLen+2;
// X,Z positions of the follower - used to calibrate cam diameters
followerX = -conRodLen*sin(rod2Rotate);
followerZ = rollerHeight+conRodLen*cos(rod2Rotate);



module hollowBarY(h)
{
	translate([0,0,5])
	rotate([-90,0,0])
	hollowBar(h);
}
module hollowBarX(h)
{
	cube([h,5,5]);
/*	translate([0,0,5])
	rotate([0,90,0])
	hollowBar(h);*/
}

module conrod(x)
{
	color([0.5,0.5,0.5])
	difference()
	{
		union() {
			translate([-5,0,0]) cube([10,1,x]);
			translate([ 0,0,0]) rotate([270,0,0]) cylinder(h=1,r=5);
			translate([ 0,0,x]) rotate([270,0,0]) cylinder(h=1,r=5);
		}
		translate([0,-1,0]) rotate([270,0,0]) cylinder(h=20,r=2);
		translate([0,-1,x]) rotate([270,0,0]) cylinder(h=20,r=2);
	}
}


module flipper()
{
	translate([-0.5,pushRodY-2,0])
		cube([1,5,4]);
	translate([-0.5,0,0])
	   cube([1,5,30]);

	rotate([270,0,0])
	cylinder(r=1.5,h=railSeparation); // Axle

	translate([0,-35,30])
	rotate([270,0,0])
	cylinder(r=1.5,h=40); // Handle

}

flipperBlockLength=10;

module flipperBlock()
{
	color([0.8,0.2,0])
	{
	  difference(){
	    translate([-rollerDiam/2,0,-5])
		cube([rollerDiam,flipperBlockLength,10]);

		translate([0,-1,0])
		rotate([270,0,0])
		#cylinder(r=2,h=flipperBlockLength+2);

		translate([0,-1,-1])
		rotate([0,-45,0])
		#cube([10,flipperBlockLength+2,10]);
	  }
	}

}

module scaffold()
{
	// The four vertical bars
	for(x=[-rollerDiam/2-5,rollerDiam/2]) 
	for(y=[towerPosY,towerPosY+towerWidthY-5])
	translate([x,y,-15])
		hollowBar(150);

	// Slide guide middle bracing
	for(y=[0,towerWidthY-5])
	translate([-rollerDiam/2,towerPosY+y,50])
		hollowBarX(rollerDiam);
	translate([rollerDiam/2,towerPosY+5,50])
		hollowBarY(towerWidthY-10);

	// Braces out under chassis
	for(x=[0,rollerDiam+5]) {
	translate([-rollerDiam/2-5+x,towerPosY+towerWidthY,-15])
	hollowBarY(railSeparation-towerPosY-towerWidthY+railWidth);

	translate([-rollerDiam/2-5+x,-railWidth,-15])
	hollowBarY(towerPosY+railWidth);
	}

	// Top supports
	for(y=[towerPosY,towerPosY+towerWidthY-5])
		translate([-rollerDiam/2,y,120])
		hollowBarX(rollerDiam);

	translate([-rollerDiam/2-5,towerPosY+5,120])
	hollowBarY(towerWidthY-10);
	translate([+rollerDiam/2,towerPosY+5,120])
	hollowBarY(towerWidthY-10);

	// Low bracing
	translate([+rollerDiam/2,towerPosY+5,10])
	hollowBarY(towerWidthY-10);

	translate([-rollerDiam/2-5,towerPosY+5,10])
	hollowBarY(towerWidthY-10);

	

	// Supports out to camshaft body (done by eye!)
	translate([-rollerDiam/2,towerPosY,65])
	rotate([0,0,270-76])	
	translate([0,-5,5])
	rotate([0,90,0])
		difference() {
		hollowBar(62);
		}
	translate([-rollerDiam/2,towerPosY+towerWidthY,70])
	rotate([0,0,90+61])	
	rotate([0,90,0])
		hollowBar(65);

}

module mover()
{
	// The pusher
	translate([0,pushRodY,rollerHeight]) rotate([0,pusherRotate+180,0])conrod(40);

	// The middle conrod
	translate([0,pushRodY+1,rollerHeight]) rotate([0,-rod2Rotate,0]) conrod(conRodLen);

	// Long axle for location
	color([0.6,0.6,0.6])
	translate([0,0,rollerHeight] ){
	rotate([270,0,0]) {
	cylinder(h=65,r=2.5);
	}
	}

	// Roller bearings (followers)
	color([1,1,1]) {
		       translate([0,towerPosY+towerWidthY-5,rollerHeight]) 
		       rotate([270,0,0])
		       cylinder(h=5,r=rollerDiam/2);

		       translate([0,towerPosY,rollerHeight] ) 
		       rotate([270,0,0])
		       cylinder(h=5,r=rollerDiam/2);
	}

	// Slide guides
	// Flipper, off the bottom
	translate([0,0,-10])
	{
		rotate([0,flipperPos,0])	
			flipper();
		flipperBlock();

		translate([0,railSeparation-flipperBlockLength,0])
		flipperBlock();
	}

	// scaffold
	scaffold();


	// Top rod
	translate([0,pushRodY,conRodLen*2+2])
	rotate([0,rod2Rotate+180,0]) conrod(conRodLen);

	// Cam followers
	translate([followerX,pushRodY+2,followerZ])
	{
	rotate([270,0,0])
	cylinder(r=followerRadius,h=5);
	}
	translate([followerX,pushRodY-5,followerZ])
	{
	rotate([270,0,0])
	cylinder(r=followerRadius,h=5);
	}
}