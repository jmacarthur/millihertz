include <params.scad>
include <movercam.scad>

lifterFollowerLen = 70;

module makeConRod(length, width)
{
	difference() {
	union() {
	rotate([0,90,0])
	cylinder(r=5,h=width);
	translate([0,0,-length]) {
	rotate([0,90,0])
	cylinder(r=5,h=width);
	}
	translate([0,-5,-length]) {
	cube(size=[width,10,length]);
	}
	}
	translate([-1,0,0])
	rotate([0,90,0])
	cylinder(r=2.5,h=width+2);
	translate([-1,0,-length])
	rotate([0,90,0])
	cylinder(r=2.5,h=width+2);
	}
}


module cams(yOffset)
{
	for(outside=[0,1]) 
	for(side=[0:1]) {
	translate([wheelWidth+chassisThickness+gridWallWidth+(chassisInternalSpacing-5)*side+((side*2-1)*outside*(chassisThickness+5)),yOffset-20,chassisTop-chassisThickness]) {
	difference() {
		cube(size=[5,80,120]);
		translate([-1,-50,80]) rotate([-45,0,0]) cube(size=[7,50,150]);
		translate([-1,20,70]) rotate([0,90,0])	cylinder(r=2.5,h=7);
		translate([-1,70,110]) rotate([0,90,0])	cylinder(r=2.5,h=7);
		}
}		
	}

	translate([0, yOffset, chassisTop+50])
	{
	translate([puntPosX-5,0,0])
	rotate([0,90,0]) difference()
	{
		rotate([0,0,180]) moverCam();
		//cylinder(r=47,h=5); // 30ish up to 47ish
		translate([0,0,-1]) cylinder(r=2.5,h=7);
	}

	// This one runs the lifters.
	// There should be an identical one on the other side.
	translate([gridWallWidth+wheelWidth,0,0])
	rotate([0,90,0]) difference()
	{
	union() {
		cylinder(r=25,h=5); // Needs to vary by 10.5
                translate([0,11,0])cylinder(r=25,h=5); // Needs to vary by 10.5
		}
		translate([0,0,-1]) cylinder(r=2.5,h=7);
	}



	// This one is meant to hold off the dir amp
	translate([gridWallWidth+wheelWidth+10,0,0])
	rotate([0,90,0]) difference()
	{
	union() {
		cylinder(r=25,h=5); // Unknown
                translate([0,11,0])cylinder(r=25,h=5); 
		}
		translate([0,0,-1]) cylinder(r=2.5,h=7);
	}

	}


	// Axle
	translate([-5,yOffset,chassisTop+50]) {
		rotate([0,90,0])
		color([0.5,0.5,0.5]) cylinder(r=2.5,h=150);
         }
	translate([-5,yOffset+50,chassisTop+90]) {
		rotate([0,90,0])
		color([0.5,0.5,0.5]) cylinder(r=2.5,h=150);
         }
	 // Follower levers for the cams
	translate([gridWallWidth+wheelWidth,yOffset+50,chassisTop+90]) 
	makeConRod(lifterFollowerLen,3);

	translate([gridWallWidth+wheelWidth+10,yOffset+50,chassisTop+90]) 
	makeConRod(lifterFollowerLen,3);

}