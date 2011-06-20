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

dirBoxOffsetX = gridSpacing*2-5+6; // Offset from the edge of the grid to the dir box
dirBoxOffsetY = gridSpacing*4-5; 

dirBoxHeight=10;
dirBoxWallWidth=5;

stateBoxHeight=25;
stateBoxWallWidth=5;

ballRadius = 4.76;

// ballBearingHeight is the top of any ball bearing sitting in the grid.
ballBearingHeight = sqrt(ballRadius*ballRadius - (gridHoleSize/2)*(gridHoleSize/2)) + gridThickness + ballRadius;

// row1x is the X coordinate of the centre of the first row of ball bearings
row1x = gridSpacing*5+gridWallWidth + gridHoleSize/2;

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

chassisTop = axleHeight+axleRadius+chassisThickness;
rideHeight = chassisTop - chassisThickness;

