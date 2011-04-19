include <grid.scad>
include <wheel.scad>
include <chassis.scad>
include <maze.scad>
include <lifter.scad>

grid();

for(x=[0,1]) 
{
  for(y=[0,1]) 
  {
    translate([gridSpacing*12*x,gridSpacing*20*y,0]) wheel();
  }
}


translate([gridWallWidth+wheelWidth,0,axleHeight+axleRadius]) chassis();

chassisTop = axleHeight+axleRadius+chassisThickness;
mazeStartX =  gridWallWidth+wheelWidth+chassisThickness-(115+12-chassisInternalSpacing)/2;
translate([mazeStartX,0,chassisTop]) maze();

translate([mazeStartX-raiserWallWidth,76.5,chassisTop+13]) lifter1();