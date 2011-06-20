include <params.scad>

numRaisers = 3;

module lifterSupport()
{
  length = 20;
  difference() {
  union() {
  for(sideA=[0:1]) {
  for(sideB=[0:1]) {
    translate([mazeWidth*sideA+(raiserWallWidth*(numRaisers+2)*sideA),-length,-10]) cube(size=[raiserWallWidth,length*2,20]);
    translate([mazeWidth*sideA+(raiserWallWidth*(numRaisers+2)*sideA)-(raiserWallWidth*(numRaisers+1)*sideB),-length,-10]) cube(size=[raiserWallWidth,length*2,20]);
  } 
    translate([mazeWidth*sideA+(raiserWallWidth*(numRaisers+2)*sideA)-(raiserWallWidth*(numRaisers+1)),-length,-10-3]) cube(size=[raiserWallWidth*(numRaisers+2),length*2,3]);
}
  }
  translate([-15,0,0]) rotate([0,90,0]) cylinder(r=2.5,h=200); // Axle hole
  }


}
