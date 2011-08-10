////////////////////////////////////////////////////////////////
// Turing Machine Revision 2 ///////////////////////////////////
//////////////////////////////////// Jim MacArthur /////////////
////////////////////////////////////////////////////////////////

include <grid.scad>
include <wheel.scad>
include <chassis.scad>
include <maze.scad>
include <lifter.scad>
include <liftersupport.scad>
include <dirbox.scad>
include <statebox.scad>
include <stateflip.scad>
include <diramp.scad>
include <returner.scad>
include <punt.scad>
include <cams.scad>
include <axle.scad>
//grid();



// Add all four wheels
for(x=[0,1]) 
{
  for(y=[0,1]) 
  {
      translate([gridSpacing*19*x,axle1Y+gridSpacing*30*y,0]) wheel();
      translate([chassisStartX,gridWallWidth+gridHoleSize/2+axle1Y+gridSpacing*30*y,0]) axle();
  }
}


// Configure the animation
x=$t*120;
y = (x<105)?x:105;
z = 0;
translate([chassisStartX,0,axleHeight+axleRadius]) chassis();

echo("Maze starts at ",mazeStartX,",",mazeStartY,",",chassisTop);
if(true) {
translate([mazeStartX,mazeStartY,chassisTop]) {
    //maze();

    translate([0,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-x,0,0]) lifterSupport();

    //translate([-raiserWallWidth-(raiserWallWidth+raiserSeparation)*1,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-x,0,0]) lifter1();

    //translate([-raiserWallWidth-(raiserWallWidth+raiserSeparation)*2,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-y,0,0])lifter2();

    //translate([-raiserWallWidth-(raiserWallWidth+raiserSeparation)*3,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-z,0,0])lifter3();
}
}

//translate([mazeStartX + dirBoxOffsetX,dirBoxOffsetY,chassisTop+mazeHeight]) dirbox();
//translate([mazeStartX + dirBoxOffsetX,dirBoxOffsetY,chassisTop+mazeHeight+dirBoxHeight]) statebox();

if(false) {
for(d=[-1:10]) {
translate([row1x,gridSpacing*2*d+gridWallWidth+gridHoleSize/2,ballBearingHeight-ballRadius]) sphere(r=ballRadius,$fn=20);
}
}
//translate([mazeStartX + dirBoxOffsetX, dirBoxOffsetY +gridSpacing*2+dirBoxWallWidth,chassisTop+mazeHeight+25]) rotate([0,0,270])stateflip();

//translate([mazeStartX + dirBoxOffsetX+70, dirBoxOffsetY+55,chassisTop+mazeHeight+10-1.5]) diramp();

//color([0,1,0]) returner();

punt(120);

cams(235);