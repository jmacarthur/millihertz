include <params.scad>

numRaisers = 3;
supportInternalX = numRaisers*raiserWallWidth+(numRaisers+1)*raiserSeparation;

supportWallWidth = 3;
supportOverallWidth = supportInternalX + supportWallWidth*2;

module lifterSupport1()
{
  length = 20;
  difference() {
  union() {
    translate([0,-length*2,-10-supportWallWidth]) cube(size=[supportWallWidth,length*4,20+supportWallWidth]);
    translate([supportWallWidth+supportInternalX,-length,-10]) cube(size=[supportWallWidth,length*2,20]);
    translate([0,-length,-10-3]) cube(size=[supportWallWidth*2+supportInternalX,length*2,supportWallWidth]);
  }
  translate([-15,0,0]) rotate([0,90,0]) cylinder(r=2.5,h=200); // Axle hole
  }
}

module lifterSupport()
{
  translate([chassisInternalSpacing+chassisThickness*2-supportWallWidth*2,0,0]) lifterSupport1();
  translate([0,0,0]) rotate([0,0,180]) lifterSupport1();

}