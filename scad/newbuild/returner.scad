include <params.scad>

returnerStart = gridWallWidth+gridHoleSize/2+gridSpacing*5;

returnerLen = 95;
angle = 5;
drop = returnerLen * sin(angle);
clearance = 1;
chassisInternalX = wheelWidth+chassisThickness+gridWallWidth;
reducerHeight = chassisTop - 5- ballBearingHeight - clearance;

module returner()
{
translate([chassisInternalX,0,ballBearingHeight+clearance]) 
rotate([angle,0,0]) {

difference() 
{
  cube(size=[chassisInternalSpacing,returnerLen,3]);
  for(x=[-2:2]) {
    translate([row1x+gridSpacing*2*x,-5,-1])
    cube(size=[5,returnerLen,3+2]);
  }
}
}
translate([chassisInternalX,0,ballBearingHeight+clearance])
{
  cube(size=[3,returnerLen,reducerHeight]);
}
translate([chassisInternalX+chassisInternalSpacing-3,0,ballBearingHeight+clearance])
{
  cube(size=[3,returnerLen,reducerHeight]);
}

}

