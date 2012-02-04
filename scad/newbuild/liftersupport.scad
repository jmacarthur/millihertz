include <params.scad>

numRaisers = 3;
supportInternalX = numRaisers*raiserWallWidth+(numRaisers+1)*raiserSeparation;

supportWallWidth = 3;
supportOverallWidth = supportInternalX + supportWallWidth*2;

length = 20;
supportY1 = -length-40;
supportY2 = length*2-35-30;
supportYd = 50;
supportX1 = supportWallWidth+supportInternalX;

/*

 +---+4
 |   |
 | +-+3
 | |
 | +--+ 0
6|   ++ 11,12
 \   |
  \  ++ 10, 9
   \  |
    \-+ 
    7 8*/

module support2D()
{
  polygon(points=[[0,-10-supportWallWidth],
                  [supportX1+supportWallWidth,-10-supportWallWidth],
                  [supportX1+supportWallWidth,5],
                  [supportX1,5],
                  [supportX1,10],
                  [30,10],
                  [30,-10],
                  [30,-20],
                  [0,-35],
                  [0,-10-supportWallWidth-10],
                  [supportWallWidth,-10-supportWallWidth-10],
                  [supportWallWidth,-10-supportWallWidth-5],
                  [0,-10-supportWallWidth-5]
            ], paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,0]]);
}

module centreSupportPlate()
{
  difference() {
    union() {
      translate([0,-length*2,-10-supportWallWidth]) cube(size=[supportWallWidth,length*4,20+supportWallWidth]);
      translate([0,length*2-35,-30-supportWallWidth]) cube(size=[supportWallWidth,20,31]);
      translate([0,-length*2,-30-supportWallWidth]) cube(size=[supportWallWidth,10,31]);
      translate([0,-length*2+10,-30-supportWallWidth+10]) cube(size=[supportWallWidth,supportWallWidth,5]);
      translate([0,length*2-35-supportWallWidth,-30-supportWallWidth+10]) cube(size=[supportWallWidth,supportWallWidth,5]);
    }
  }
  
}

module lifterSupport1()
{
  difference() {
    union() {
      
      translate([0,-30,0]) centreSupportPlate();    
      color([0,0,1])
        difference() {
        translate([supportX1,supportY1,-10]) cube(size=[supportWallWidth,supportYd+20,20]); // Short vertical
        translate([supportX1-thin,supportY1-thin,5]) cube(size=[supportWallWidth+thin*2,supportWallWidth+thin,10+thin]); // Short vertical
        translate([supportX1-thin,supportY2-supportWallWidth,5]) cube(size=[supportWallWidth+thin*2,supportWallWidth,10+thin]); // Short vertical
      }
      
    color([0,1,1])
      translate([supportWallWidth,supportY1,-10-3]) cube(size=[supportWallWidth+supportInternalX,supportYd,supportWallWidth]); // Horizontal
      
      // Angle Brackets
      color([1.0,0,0])
        translate([0,supportY1+supportWallWidth,0])
        rotate([90,0,0]) 
        linear_extrude(height = supportWallWidth) {
        support2D();
      }
      
      color([0,1.0,0])
        translate([0,supportY2,0])
        rotate([90,0,0]) 
        linear_extrude(height = supportWallWidth) {
        support2D();
      }
      
    }
    translate([-15,0,0]) rotate([0,90,0]) cylinder(r=2.5,h=200); // Axle hole
    for(mountHoleY=[10,60])
      translate([-thin,-mazeHoleOffsetY+mountHoleY,-mazeHoleOffsetZ-chassisTop+ballBearingHeight+clearance+20]) rotate([0,90,0]) cylinder(r=1.5,h=200); // Mounting hole
    
  }
}

module lifterSupport()
{
  translate([chassisInternalSpacing+chassisThickness*2,0,0]) lifterSupport1();
  translate([0,0,0]) scale([-1,1,1]) lifterSupport1();
}
