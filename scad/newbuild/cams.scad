include <params.scad>
include <generated_cams.scad>

lifterFollowerLen = 70;
lifterFollowerPos = 35;	
resetFollowerLen = 70;
resetFollowerPos = 35;

moverCamRotate = $t*360;
lifterCamRotate = $t*360;
followerAngle = ($t>0.25 && $t<0.75)?17:0;

camShaftHeight = 55;
camWidth = 6;
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
  supports = false;
  if(supports) {
    
    for(outside=[0,1]) 
      for(side=[0:1]) {
        translate([wheelWidth+chassisThickness+gridWallWidth+(chassisInternalSpacing-5)*side+((side*2-1)*outside*(chassisThickness+5)),yOffset-20,chassisTop-chassisThickness]) {
          difference() {
            cube(size=[5,80,120]);
            translate([-1,-50,90]) rotate([-45,0,0]) cube(size=[7,50,150]);
            translate([-1,20,75]) rotate([0,90,0])	cylinder(r=2.5,h=7);
            translate([-1,70,110]) rotate([0,90,0])	cylinder(r=2.5,h=7);
          }
        }		
      }
  }

	translate([0, yOffset, chassisTop+camShaftHeight])
	{
	translate([puntPosX-5,0,0])
	rotate([0,90,0]) difference()
	{
		rotate([0,0,moverCamRotate]) color([0,1,1]) moverCam();
		translate([0,0,-1]) cylinder(r=2.5,h=7);
	}

	// This one runs the lifters.
	// There should be an identical one on the other side.
	translate([gridWallWidth+wheelWidth+5,0,0])
	rotate([0,90,0]) difference()
	{
	color([1,0,1])
	union() {
		rotate([0,0,lifterCamRotate]) lifterCam();
		translate([0,0,chassisInternalSpacing+chassisThickness])		rotate([0,0,lifterCamRotate]) lifterCam();
		}
		translate([0,0,-1]) cylinder(r=2.5,h=7);
	}



	// This one is meant to hold off the dir amp
	translate([gridWallWidth+wheelWidth+30,0,0])
	rotate([0,90,0]) difference()
	{
	color([0,1,0])
	union() {
		cylinder(r=25,h=5); // Unknown
                translate([0,11,0])cylinder(r=25,h=5); 
		}
		translate([0,0,-1]) cylinder(r=2.5,h=7);
	}

	}


	// Axles
	translate([-5,yOffset,chassisTop+camShaftHeight]) {
		rotate([0,90,0])
		color([0.5,0.5,0.5]) cylinder(r=2.5,h=150);
         }
	translate([-5,yOffset+50,chassisTop+90]) {
		rotate([0,90,0])
		color([0.5,0.5,0.5]) cylinder(r=2.5,h=150);
         }

	 // Follower levers for the cams
	 for(c=[0:1]) {
	translate([gridWallWidth+wheelWidth+10+(chassisInternalSpacing+chassisThickness)*c,yOffset+50,chassisTop+90]) 
	{
          rotate([followerAngle,0,0]) {
	makeConRod(lifterFollowerLen,3);
	  translate([-bearingWidth,0,-lifterFollowerPos])
	    rotate([0,90,0]) cylinder(r=bearingRadius,h=bearingWidth);
          }
	    }
	    }

	translate([gridWallWidth+wheelWidth+chassisThickness+80,yOffset+50,chassisTop+90]) 
	{
	makeConRod(resetFollowerLen,3);
	  translate([-bearingWidth,0,-lifterFollowerPos])
	    rotate([0,90,0]) cylinder(r=bearingRadius,h=bearingWidth);
	    }

	translate([gridWallWidth+wheelWidth+35,yOffset+50,chassisTop+90]) 
	{
	makeConRod(resetFollowerLen,3);
	  translate([-bearingWidth,0,-lifterFollowerPos])
	    rotate([0,90,0]) cylinder(r=bearingRadius,h=bearingWidth);
	    }

	translate([gridWallWidth+wheelWidth+chassisThickness+80-camWidth,yOffset,chassisTop+camShaftHeight]) 
	{
		rotate([0,90,0]) resetCam();
	}

	// Input pulley
	color([1,0,0])
	translate([gridWallWidth+wheelWidth+chassisThickness+60-camWidth,yOffset,chassisTop+camShaftHeight]) 
	union()
	{
		rotate([0,90,0]) cylinder(r=40,h=5);
		translate([-1,0,0]) rotate([0,90,0]) cylinder(r=45,h=1);
		translate([5,0,0]) rotate([0,90,0]) cylinder(r=45,h=1);
	}

}
