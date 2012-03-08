// This file should only contain constants (no objects)
// All measurements are in mm

// Grid parameters. This is for 6mm square hole galvanised grid
// RS stock number 210-3729
gridThickness = 1.4; // That's two grid plates on top of each other
gridSpacing = 7.58; // That's the period of the grid, not the hole size
	            // Measured from actual grid
gridHoleSize = 6;
gridWallWidth = gridSpacing - gridHoleSize;


mazeWidth = 115+12;
mazeHeight = 35;
mazeLength = 97;
mazeStartY = 0;

// These define the location of the holes for the raiser axles.
mazeHoleOffsetY = 76.5;
mazeHoleOffsetZ = 13;

dirBoxHeight=10;
dirBoxWallWidth=5;

stateBoxHeight=22;
stateBoxWallWidth=5;

ballRadius = 4.76;

// ballBearingHeight is the top of any ball bearing sitting in the grid.
ballBearingHeight = sqrt(ballRadius*ballRadius - (gridHoleSize/2)*(gridHoleSize/2)) + gridThickness + ballRadius;

// row1x is the X coordinate of the centre of the first row of ball bearings
row1x = gridSpacing*5+gridWallWidth + gridHoleSize/2;
echo("row1x is ",row1x);
// Measured from the original machine
chassisInternalSpacing = 95;
chassisWallThickness = 1.5;
chassisThickness = 20;

wheelDiameter = 37.5;
wheelRadius = wheelDiameter/2;
wheelWidth = 6; // Should be <= gridHoleSize
axleDiameter = 3;
axleRadius = axleDiameter/2;
wheelIngress = sqrt((wheelRadius*wheelRadius)-(gridHoleSize/2)*(gridHoleSize/2));
axleHeight = wheelIngress + gridThickness;

chassisStartX = gridWallWidth+wheelWidth;

chassisTop = axleHeight+axleRadius+chassisThickness;
rideHeight = chassisTop - chassisThickness;

// Standard roller bearing
bearingWidth = 5;
bearingRadius = 8;

raiserWallWidth = 3;
raiserSeparation = 1;
mazeStartX =  gridWallWidth+wheelWidth+chassisThickness-(mazeWidth-chassisInternalSpacing)/2;

axle1Y = gridSpacing*12;
axle2Y = gridSpacing*39;
axleBlockThickness = 3;
axleBearingDiameter = 6; // These are technobots mini bearings, code 4255-020

// Laser beam diameter
// This is set to zero because I expect to account for the laser cut width
// outside OpenSCAD (in InkScape, probably)
cutWidth=0;

// This is used to make things slightly bigger for CSG, to avoid touching walls.
thin = 0.1;

mazeTop = chassisTop+mazeHeight-5;

dirBoxOffsetY = gridSpacing*4-dirBoxWallWidth/2; 
dirBoxOffsetX = row1x-dirBoxWallWidth-gridSpacing; // Offset from the edge of the grid to the dir box

