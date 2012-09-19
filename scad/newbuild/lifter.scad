include <params.scad>

// Here are  the lifter bars for the Turing machine. The centre is on the axis of
// The lifters, so they can be rotated to alter the position.

// mazeWidth needs to be known.

raiser1Length = mazeHoleOffsetY+raiserWallWidth/2+gridSpacing+raiserWallWidth;
raiser1Drop = 32;
raiser2Length = raiser1Length+10;
raiser2Drop = 35;
raiser3Length = raiser1Length+5*gridSpacing;
raiser3Drop = 40;

raiser1Separation = chassisInternalSpacing+chassisThickness*2-raiserWallWidth*0;

// Makes a generic lifter bar of a given length and step number (1-based)
// 1 is the innermost lifter. InputAngle is of the bar with holes in attached
// to the cams.

module raiserArm(length,step,side,inputAngle) 
{
   difference() {
	translate([raiser1Separation*side+(raiserWallWidth+raiserSeparation)*(side*step*2)+(raiserWallWidth*side),0,0]) {
	translate([0,0,0] ) rotate([0,90,0]) cylinder(r=10,h=raiserWallWidth); 
        translate([0,-length+raiserWallWidth,-10]) cube(size=[raiserWallWidth,length-raiserWallWidth,20]);
        translate([0,-length,-10]) cube(size=[raiserWallWidth,raiserWallWidth,10]);
        rotate([inputAngle,0,0]) translate([0,0,-10]) cube(size=[raiserWallWidth,45,20]);
    }
    translate([-thin,0,0]) rotate([0,90,0]) cylinder(r=2.5,h=200); // Axle hole
    translate([-thin,-20,20])rotate([0,90,0]) cylinder(r=2.5,h=200); // Pull hole d=28.2
    translate([-thin,-25,30])rotate([0,90,0]) cylinder(r=2.5,h=200); // Pull hole d=39.1
    translate([-thin,-10,15])rotate([0,90,0]) cylinder(r=2.5,h=200); // Pull hole d=18.0
    }
}

module lifterBarSides(length, step, inputAngle)
{
  for(side=[0:1]) {
      raiserArm(length,step,side,inputAngle);
   }
}

module lifterBarDrop(length, step, inputAngle)
{
    union() {
      translate([raiserWallWidth,-length,-10]) cube(size=[raiser1Separation+(raiserWallWidth+raiserSeparation)*(2*step),raiserWallWidth,20]); // cross bar
      translate([0,-length,0]) cube(size=[raiserWallWidth,raiserWallWidth,10]); // cross bar tab
      translate([raiser1Separation+(raiserWallWidth+raiserSeparation)*(2*step)+raiserWallWidth,-length,0]) cube(size=[raiserWallWidth,raiserWallWidth,10]); // cross bar tab
    }
}



magnet1X = raiserWallWidth-chassisStartX+raiserSeparation+gridSpacing*10;
magnet2X = raiserWallWidth-chassisStartX+raiserSeparation*2+raiserWallWidth+gridSpacing*10;
magnetY = -raiser1Length-raiserWallWidth*0.5+raiserWallWidth;



module lifter1(startX)
{

        translate([startX,0,0]) lifterBarSides(raiser1Length,1,135);
 // 38 here is arbitrary; it's the start position of the drop plate, which isn't critical
        difference() {
          union() {
	translate([startX+raiser1Separation/2+raiserWallWidth*2-38+raiserSeparation,-raiser1Length,-raiser1Drop-10]) cube(size=[70,raiserWallWidth,raiser1Drop+20]);
        translate([startX,0,0]) lifterBarDrop(raiser1Length,1,135);
          }

	// Magnet holes

	for(x=[0:4]) {
          translate([row1x+gridSpacing*2*x-2.5,magnetY-2.5,-raiser1Drop-7]) color([0.5,0.5,0.5]) cube(size=[5,5,2]);
		translate([row1x+gridSpacing*2*x-1,magnetY-5,-raiser1Drop-11]) color([0.5,0.5,0.5]) cube(size=[2,10,5]);
	}
	}
	// Magnets
        if(drawMagnets) {
          for(x=[0:4]) {
            translate([row1x+gridSpacing*2*x,magnetY,-raiser1Drop-7]) color([0.5,0.5,0.5]) cylinder(r=2.5,h=2);
            translate([row1x+gridSpacing*2*x,magnetY,-raiser1Drop-10-raiserWallWidth]) color([1.0,0.5,0.5]) cylinder(r=1.5,h=3+raiserWallWidth);            
	}
        }
}

module lifter2(startX)
{
    translate([startX,0,0])	lifterBarSides(raiser2Length,2,180);	
    dropBarX = startX+raiser1Separation/2+raiserWallWidth*2-35+raiserSeparation*2;
    union() {
      translate([startX,0,0])	lifterBarDrop(raiser2Length,2,180);	
    
      // Drop bar...
      translate([dropBarX,-raiser2Length,-raiser2Drop-10+raiserWallWidth]) cube(size=[70,raiserWallWidth,raiser2Drop+20-raiserWallWidth]);

      for(x=[0:3]) {
      translate([dropBarX+20*x,-raiser2Length,-raiser2Drop-10]) cube(size=[10,raiserWallWidth,raiser2Drop+20]);
      }
    }
    difference() {
      translate([dropBarX-5,-raiser2Length,-raiser2Drop-10]) cube(size=[80,raiser2Length-raiser1Length+10,raiserWallWidth]);
      for(x=[0:4]) {
        translate([row1x+gridSpacing*2*x,magnetY,-raiser2Drop-10-thin]) cylinder(r=3,h=5);
        translate([row1x+gridSpacing*2*x-3,magnetY,-raiser2Drop-10-thin]) cube(size=[6,50,raiserWallWidth+thin*2]);
      }

      for(x=[0:3]) {
        translate([dropBarX+x*20,-raiser2Length-thin,-raiser2Drop-10-thin]) cube(size=[10,raiserWallWidth+thin,raiserWallWidth+thin*2]);
      }
      
    }
}

module lifter3(startX)
{
    translate([startX,0,0])	lifterBarSides(raiser3Length,3,135);
    union() {
    translate([startX,0,0])	lifterBarDrop(raiser3Length,3,135);
    difference() {
      translate([startX+raiser1Separation/2+raiserWallWidth*3-40+raiserSeparation*3,-raiser3Length,-raiser3Drop-10]) cube(size=[80,raiserWallWidth,raiser3Drop+20]); // Vertical plate
      for(x=[0:3]) {
        translate([startX+raiser1Separation/2+raiserWallWidth*3-40+raiserSeparation*3+5+20*x,-raiser3Length-thin,-raiser3Drop-10-thin]) cube(size=[10,raiserWallWidth+thin*2,raiserWallWidth+thin]); // Vertical plate
      }
    }
    }
    
    difference()
    {
      translate([startX+raiser1Separation/2+raiserWallWidth*3-40+raiserSeparation*3,-raiser3Length,-raiser3Drop-10]) cube(size=[80,raiser3Length-raiser1Length+10,raiserWallWidth]);
      for(x=[0:4]) {
	for(y=[-2:0]) {
          translate([row1x+gridSpacing*2*x,-raiser1Length+raiserWallWidth*0.5+gridSpacing*2*y,-raiser3Drop-10-thin]) cylinder(r=5,h=20);
        }
	translate([row1x+gridSpacing*2*x-5,-raiser1Length+raiserWallWidth*0.5,-raiser3Drop-10-thin]) cube(size=[10,20,raiserWallWidth+2]);
      }
      for(x=[0:4]) {
        translate([startX+raiser1Separation/2+raiserWallWidth*3-40+raiserSeparation*3-5+20*x,-raiser3Length-thin,-raiser3Drop-10-thin]) cube(size=[10,raiserWallWidth+thin,raiserWallWidth+2*thin]);
      }
    }
    // Alignment beam - should all be in line with row1x
    color([255,0,0]) translate([row1x,-raiser1Length,-100]) cylinder(r=0.5,h=300);
}
