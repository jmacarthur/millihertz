include <params.scad>

returnerStart = gridWallWidth+gridHoleSize/2+gridSpacing*5;

returnerLen = 85;
angle = 5;
drop = returnerLen * sin(angle);
clearance = 1;
chassisInternalX = wheelWidth+chassisThickness+gridWallWidth;
returnerHeight = chassisTop - 5- ballBearingHeight - clearance;
returnerThickness = 3;

// How far along do we have to shift the baseplate so it clears the data?
baseShift = returnerThickness / sin(angle);
//The constraint is: baseShift*sin(angle) >= returnerThickness;

module returnerBase()
{
  union() {
    translate([returnerThickness,baseShift*cos(angle),ballBearingHeight+clearance+baseShift*sin(angle)]) 
      rotate([angle,0,0]) {
      cube(size=[chassisInternalSpacing-returnerThickness*2,returnerLen-baseShift,returnerThickness]);
    }
    translate([0,baseShift*cos(angle),ballBearingHeight+clearance+baseShift*sin(angle)]) 
      rotate([angle,0,0]) {
      cube(size=[chassisInternalSpacing,returnerLen-baseShift-10,returnerThickness]);
    }
  }

}

module returnerComb()
{
  translate([0,0,ballBearingHeight+clearance]) 
    rotate([angle,0,0]) {
    difference() 
    {
      cube(size=[chassisInternalSpacing-2*returnerThickness,returnerLen,returnerThickness]);
      for(x=[-2:2]) {
        translate([row1x+gridSpacing*2*x-returnerThickness,-thin,-thin])
          cube(size=[5,returnerLen-thin-20,returnerThickness+thin*2]);
      }
    }
  }
}

module returnerSide()
{
  trim = 3*cos(angle)-cutWidth/2;
  difference() {
    translate([0,0,ballBearingHeight+clearance])
      rotate([90,0,90])
      linear_extrude(height=returnerThickness) {
      polygon(points=[[0,returnerHeight],[returnerLen,returnerHeight],[returnerLen,drop+trim-10],[0,0+trim-10]],paths=[[0,1,2,3]]);
    } 
    translate([-thin,baseShift*cos(angle),ballBearingHeight+clearance+baseShift*sin(angle)-returnerThickness]) 
      rotate([angle,0,0]) {
      cube(size=[chassisInternalSpacing+thin*2,returnerLen-baseShift-10,returnerThickness]);
    }

    // Some holes for mounting
    for(holeY=[10,60]) {
      translate([-thin,holeY,ballBearingHeight+clearance+20])
        rotate([0,90,0])
        cylinder(r=1.5,h=returnerThickness+2*thin);
    }
  }
}




module returner()
{
  translate([chassisInternalX,0,0]) {
    translate([0,0,-returnerThickness*cos(angle)])
      color([0.1,0.8,0])
      returnerBase();
    color([0,0.5,0]) 
      translate([returnerThickness,0,0])
      returnerComb();
    returnerSide();
    translate([chassisInternalSpacing-returnerThickness,0,0])
      returnerSide();
  }
}
