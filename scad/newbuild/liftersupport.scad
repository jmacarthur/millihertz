include <params.scad>

numRaisers = 3;
supportInternalX = numRaisers*raiserWallWidth+(numRaisers+1)*raiserSeparation;

supportWallWidth = 3;
supportOverallWidth = supportInternalX + supportWallWidth*2;

  length = 20;
supportY1 = -length-10-supportWallWidth;
supportYd = length*2+supportWallWidth*2+10;
supportY2 = supportY1 + supportYd;

supportX1 = supportWallWidth+supportInternalX;

module support2D()
{
    polygon(points=[[0,-10-supportWallWidth],[supportX1+supportWallWidth,-10-supportWallWidth],[supportX1+supportWallWidth,10],[30,10],[30,-10],[30,-20],[0,-35],[0,-20],[supportWallWidth,-20],[supportWallWidth,-10-supportWallWidth]], paths=[[0,1,2,3,4,5,6,7,8,9]]);
}

module centreSupportPlate()
{
    difference() {
    union() {
    translate([0,-length*2,-10-supportWallWidth]) cube(size=[supportWallWidth,length*4,20+supportWallWidth]);
        translate([0,length*2-20,-30-supportWallWidth]) cube(size=[supportWallWidth,20,31]);
        translate([0,-length*2,-30-supportWallWidth]) cube(size=[supportWallWidth,10,31]);
	}
  translate([-1,-length*2+10-supportWallWidth,-10-supportWallWidth]) cube(size=[supportWallWidth+2,supportYd,supportWallWidth]);
  translate([-1,-length*2+10-supportWallWidth,-30-supportWallWidth]) cube(size=[supportWallWidth+2,supportYd,10+supportWallWidth]);
  translate([-1,-length*2+10,-30-supportWallWidth]) cube(size=[supportWallWidth+2,supportYd-supportWallWidth*2,20+supportWallWidth]);
    }

}

module lifterSupport1()
{
  difference() {
  union() {

    centreSupportPlate();    
    color([0,0,1])
    translate([supportX1,supportY1,-10]) cube(size=[supportWallWidth,supportYd,20]); // Short vertical

//    color([0,1,1])
//    translate([0,supportY1,-10-3]) cube(size=[supportWallWidth*2+supportInternalX,supportYd,supportWallWidth]); // Horizontal

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

  }
}

module lifterSupport()
{
  translate([chassisInternalSpacing+chassisThickness*2,0,0]) lifterSupport1();
  translate([0,0,0]) scale([-1,1,1]) lifterSupport1();

}