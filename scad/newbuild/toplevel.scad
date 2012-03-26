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
drawLifters = true;
drawMazeAndLifters = true;
drawDirAmp = true;
drawData = false;
drawStateFlip = false;
drawMaze = false;

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

// Configure the animation. Here are the rough steps:
// At time zero, the main raiser starts lifting.
// At time (0.25), the main raiser should be at the top.
// At time (0.50), the mover should start depressing. The outer lifter should start raising at this point.

maxLifterAngle = 120;
maxOuterRaiserAngle = 10;
x= ($t<0.25)?($t/0.25)*maxLifterAngle:($t<0.75)?maxLifterAngle:((1-$t)/0.25)*maxLifterAngle;
y = (x<105)?x:105;
z = ($t<0.5)?0:($t<0.75)?($t-0.5)*(1/0.25)*maxOuterRaiserAngle:($t<0.9)?maxOuterRaiserAngle:(1-$t)*(1/0.1)*maxOuterRaiserAngle;

lifterHolePos=18.0; // See lifter.scad
lifterPullReq = lifterHolePos*(1+sin(maxLifterAngle-90));
echo("lifter pull requires ",lifterPullReq,"mm");
echo("Maze starts at ",mazeStartX,",",mazeStartY,",",chassisTop);

if(drawMazeAndLifters) {
  translate([0,mazeStartY,chassisTop]) {
    if(drawMaze) {
    translate([mazeStartX,0,0]) maze();
    }
    
    translate([chassisStartX+supportWallWidth*0,mazeHoleOffsetY,mazeHoleOffsetZ]) lifterSupport();
    
    if(drawLifters) {
      translate([0,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-x,0,0]) lifter1(-raiserWallWidth*2-(raiserWallWidth+raiserSeparation)*1+chassisStartX+supportWallWidth);
      
      translate([0,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-y,0,0])lifter2(-raiserWallWidth*2-(raiserWallWidth+raiserSeparation)*2+chassisStartX+supportWallWidth);
      
      translate([0,mazeHoleOffsetY,mazeHoleOffsetZ]) rotate([-z,0,0])lifter3(-raiserWallWidth*2-(raiserWallWidth+raiserSeparation)*3+chassisStartX+supportWallWidth);
    }
  }
}

// Top level elements that have boolean toggles

if(drawData) {
  for(d=[-5:10]) {
    translate([row1x,gridSpacing*2*d+gridWallWidth+gridHoleSize/2,ballBearingHeight-ballRadius]) sphere(r=ballRadius,$fn=20);
  }
}

if(drawStateFlip) 
{
  translate([dirBoxOffsetX-1, dirBoxOffsetY +gridSpacing*2+dirBoxWallWidth,mazeTop+dirBoxWallWidth+dirBoxHeight+stateBoxHeight]) rotate([0,0,270])stateflip();
}

if(drawDirAmp)
{
  translate([dirBoxOffsetX+70, dirBoxOffsetY+55,chassisTop+mazeHeight+10-1.5]) diramp();
}

// Below here should be a list of top-level elements, one per line. 
// These can be easily commented out while working on specific elements.

camsYoffset = 235;
returner();
punt(120);
//cams(camsYoffset);
//translate([0,0,chassisTop])engine(320);
//reducerPulley(305);
translate([dirBoxOffsetX,dirBoxOffsetY,mazeTop]) dirbox();
//translate([dirBoxOffsetX,dirBoxOffsetY,chassisTop+mazeHeight+dirBoxHeight]) statebox();
//translate([chassisStartX,0,axleHeight+axleRadius]) chassis();
//translate([chassisStartX,0,axleHeight+axleRadius]) acrylicChassis();
//grid();
//pulleyBlock();
