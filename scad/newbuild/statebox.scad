
include <params.scad>

module stateLongWall()
{
  difference() {
    union() {
      cube(size=[gridSpacing*10+stateBoxWallWidth*2,stateBoxWallWidth,stateBoxHeight]);
      translate([gridSpacing*4,0,-5])
      cube(size=[gridSpacing*2,stateBoxWallWidth,5]);
    }
    for(x=[1:4]) {
      translate([stateBoxWallWidth+x*gridSpacing*2,-thin,stateBoxHeight-10])
        cube(size=[1,stateBoxWallWidth+thin*2,10+thin]);
    }
  }
}

module stateShortWall()
{
  difference() {
    union() {
      cube(size=[stateBoxWallWidth,gridSpacing*4,stateBoxHeight]);
      translate([0,0,-5])
      cube(size=[stateBoxWallWidth,gridSpacing,5]);
      translate([0,gridSpacing*4-gridSpacing,-5])
      cube(size=[stateBoxWallWidth,gridSpacing,5]);
    }
    translate([-thin,gridSpacing*2,stateBoxHeight]) {
      rotate([0,90,0])
        cylinder(r=1.5,h=stateBoxWallWidth+thin*2);
    }
    translate([-thin,gridSpacing*2,0]) {
      rotate([0,90,0])
        cylinder(r=1.5,h=100);
    }

  }
}


module statebox()
{
  color([0.5,0.5,1]) 
    difference() {
    stateLongWall();
    // Space for spring support
    translate([dirBoxWallWidth-10,-1,-1.5]) cube(size=[gridSpacing*4,dirBoxWallWidth+1.5,3]);
  }
  translate([0,gridSpacing*4+stateBoxWallWidth,0])
    stateLongWall();

  difference() {
    union() {
      translate([0,stateBoxWallWidth,0]) {
        stateShortWall();
      }
      translate([gridSpacing*10+stateBoxWallWidth,stateBoxWallWidth,0]) {
        stateShortWall();
      }
    }
  }  
}
