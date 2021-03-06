include <params.scad>
include <generated_cams.scad>

lifterFollowerLen = 80;
lifterFollowerPos = 35;	
resetFollowerLen = 70;
resetFollowerPos = 35;

moverCamRotate = $t*360;
lifterCamRotate = $t*360;
followerMaxAngle = 20;
followerAngle = ($t>0.25 && $t<0.75)?followerMaxAngle:0;

dirAmpCamRotate = $t*360;
dirAmpFollowerRotate = ($t<0.45?5:0);

pull = lifterFollowerLen*sin(followerMaxAngle);
echo("Lifter pull: ",pull);

camShaftHeight = 55;
camWidth = 5;
resetCamRotate = $t*360;
drawMoverCam = true;
drawLifterCam = true;
drawDirAmpCam = true;
drawResetCam = true;
drawSupports = false; // Obsolete.
drawCamAxle = false;
bossHeight = 50;

module makeConRod(length, width)
{
  difference() {
    union() {
      rotate([0,90,0])
	cylinder(r=5,h=width);
      translate([0,-5,-length]) {
	cube(size=[width,10,length]);
      }
      translate([0,0,-length]) {
	rotate([0,90,0])
          cylinder(r=5,h=width);
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
  if(drawSupports) {
    
    for(outside=[0,1]) 
      for(side=[0:1]) {
        translate([wheelWidth+chassisThickness+gridWallWidth+(chassisInternalSpacing-5)*side+((side*2-1)*outside*(chassisThickness)),yOffset-20,chassisTop-chassisThickness]) {
          difference() {
            cube(size=[5,80,120]);
            translate([-1,-50,90]) rotate([-45,0,0]) cube(size=[7,50,150]);
            translate([-1,20,75]) rotate([0,90,0])	cylinder(r=bearingRadius,h=7);
            translate([-1,70,110]) rotate([0,90,0])	cylinder(r=2.5,h=7);
          }
        }		
      }
  }

  translate([0, yOffset, chassisTop+camShaftHeight])
  {
    translate([puntPosX-5,0,0])
      if(drawMoverCam) {
	rotate([0,90,0]) 
	{
          rotate([0,0,moverCamRotate]) color([0,1,1]) moverCam();
	}
      }
    // This one runs the lifters.
    // There should be an identical one on the other side.
    if(drawLifterCam) {
      translate([gridWallWidth+wheelWidth+5,0,0])
        rotate([0,90,0])
      {
        color([1,0,1]) {
          rotate([0,0,lifterCamRotate]) lifterCam();
          translate([0,0,chassisInternalSpacing+chassisThickness])		rotate([0,0,lifterCamRotate]) lifterCam();
        }
      }
    }

    // This one is meant to hold off the dir amp
    if(drawDirAmpCam) {
      translate([gridWallWidth+wheelWidth+30,0,0])
        rotate([dirAmpCamRotate,0,0])
        rotate([0,90,0])
      {
        color([0,1,0]) dirAmpCam();
      }
    }
  }

  // Axles
  if(drawCamAxle) {
    translate([-5,yOffset,chassisTop+camShaftHeight]) {
      rotate([0,90,0])
        color([0.5,0.5,0.5]) cylinder(r=2.5,h=180);
    }
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
    rotate([dirAmpFollowerRotate,0,0]) {
    makeConRod(resetFollowerLen,3);
    translate([-bearingWidth,0,-lifterFollowerPos])
      rotate([0,90,0]) cylinder(r=bearingRadius,h=bearingWidth);
    }
  }


  if(drawResetCam) {
    translate([gridWallWidth+wheelWidth+chassisThickness+80-camWidth,yOffset,chassisTop+camShaftHeight]) 
      rotate([resetCamRotate,0,0])
    {
        rotate([0,90,0]) resetCam();
    }
  }

  // Input pulley
  if(drawPulley) {
    color([1,0,0])
      translate([gridWallWidth+wheelWidth+chassisThickness+60-camWidth,yOffset,chassisTop+camShaftHeight]) 
      union()
    {
      rotate([0,90,0]) cylinder(r=40,h=5);
      translate([-1,0,0]) rotate([0,90,0]) cylinder(r=45,h=1);
      translate([5,0,0]) rotate([0,90,0]) cylinder(r=45,h=1);
    }
  }

  // Input sprocket (alternative)
  if(drawSprocket) {
    color([0.5,0.5,0.5])
      translate([gridWallWidth+wheelWidth+chassisThickness+130-camWidth,yOffset,chassisTop+camShaftHeight]) 
      rotate([0,90,0]) cylinder(r=40,h=5);
  }

}
