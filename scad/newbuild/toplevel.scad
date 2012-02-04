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
include <engine.scad>

include <reducerpulley.scad>

// Add all four wheels
wheel1X = -gridSpacing;
wheel2X = gridSpacing*19*1;

// Toggle top level elements on and off
// Some elements are commented on/off at the bottom of this file.
drawWheels = false;
drawLifters = false;
drawMazeAndLifters = false;
drawDirAmp = false;
drawData = true;
drawStateFlip = false;

if(drawWheels) {
  for(y=[axle1Y,axle2Y]) 
  {
    for(x=[wheel1X,wheel2X]) 
    { 			   
      translate([x,y,0]) wheel();
    }
    translate([chassisStartX,gridWallWidth+gridHoleSize/2+y,0]) axle();
  }
}

// Configure the animation
x=$t*120;
y = (x<105)?x:105;
z = 0;

echo("Maze starts at ",mazeStartX,",",mazeStartY,",",chassisTop);

if(drawMazeAndLifters) {
  translate([0,mazeStartY,chassisTop]) {
    translate([mazeStartX,0,0]) maze();
    
    translate([chassisStartX+supportWallWidth*0,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([0,0,0]) lifterSupport();
    
    if(drawLifters) {
      translate([0,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-x,0,0]) lifter1(-raiserWallWidth*2-(raiserWallWidth+raiserSeparation)*1+chassisStartX+supportWallWidth);
      
      translate([0,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-y,0,0])lifter2(-raiserWallWidth*2-(raiserWallWidth+raiserSeparation)*2+chassisStartX+supportWallWidth);
      
      translate([0,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-z,0,0])lifter3(-raiserWallWidth*2-(raiserWallWidth+raiserSeparation)*3+chassisStartX+supportWallWidth);
    }
  }
}

// Top level elements that have boolean toggles

if(drawData) {
  for(d=[-1:10]) {
    translate([row1x,gridSpacing*2*d+gridWallWidth+gridHoleSize/2,ballBearingHeight-ballRadius]) sphere(r=ballRadius,$fn=20);
  }
}

if(drawStateFlip) 
{
  translate([mazeStartX + dirBoxOffsetX, dirBoxOffsetY +gridSpacing*2+dirBoxWallWidth,chassisTop+mazeHeight+25]) rotate([0,0,270])stateflip();
}

if(drawDirAmp)
{
  translate([mazeStartX + dirBoxOffsetX+70, dirBoxOffsetY+55,chassisTop+mazeHeight+10-1.5]) diramp();
}

// Below here should be a list of top-level elements, one per line. 
// These can be easily commented out while working on specific elements.

returner();
//punt(120);
//cams(235);
//translate([0,0,chassisTop])engine(300);
//reducerPulley(280);
//translate([mazeStartX + dirBoxOffsetX,dirBoxOffsetY,chassisTop+mazeHeight]) dirbox();
//translate([mazeStartX + dirBoxOffsetX,dirBoxOffsetY,chassisTop+mazeHeight+dirBoxHeight]) statebox();
//translate([chassisStartX,0,axleHeight+axleRadius]) chassis();
translate([chassisStartX,0,axleHeight+axleRadius]) acrylicChassis();
grid();

