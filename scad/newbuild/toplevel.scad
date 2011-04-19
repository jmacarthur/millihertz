include <grid.scad>
include <wheel.scad>
include <chassis.scad>
include <maze.scad>
include <lifter.scad>
include <dirbox.scad>
include <statebox.scad>

grid();

for(x=[0,1]) 
{
  for(y=[0,1]) 
  {
    translate([gridSpacing*19*x,gridSpacing*30*y,0]) wheel();
  }
}
x=$t*120;
y = (x<105)?x:105;

translate([gridWallWidth+wheelWidth,0,axleHeight+axleRadius]) chassis();

chassisTop = axleHeight+axleRadius+chassisThickness;
mazeStartX =  gridWallWidth+wheelWidth+chassisThickness-(mazeWidth-chassisInternalSpacing)/2;
translate([mazeStartX,0,chassisTop]) maze();
translate([mazeStartX-raiserWallWidth,76.5,chassisTop+13]) rotate([-x,0,0]) lifter1();
translate([mazeStartX-raiserWallWidth*2,76.5,chassisTop+13]) rotate([-y,0,0])lifter2();

translate([mazeStartX + dirBoxOffsetX,dirBoxOffsetY,chassisTop+mazeHeight]) dirbox();
translate([mazeStartX + dirBoxOffsetX,dirBoxOffsetY,chassisTop+mazeHeight+dirBoxHeight]) statebox();


translate([gridSpacing*5.5,gridSpacing*-1.5,4.76]) sphere(r=4.76);