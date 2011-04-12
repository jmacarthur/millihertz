include <grid.scad>
include <wheel.scad>
include <chassis.scad>

grid();

for(x=[0,1]) 
{
  for(y=[0,1]) 
  {
    translate([gridSpacing*12*x,gridSpacing*20*y,0]) wheel();
  }
}


translate([gridWallWidth+wheelWidth,0,axleHeight+axleRadius]) chassis();