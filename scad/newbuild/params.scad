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
mazeHeight = 30;
dirBoxOffsetX = gridSpacing*2-5+6; // Offset from the edge of the grid to the dir box
dirBoxOffsetY = gridSpacing*4-5; 

dirBoxHeight=10;
dirBoxWallWidth=5;

stateBoxHeight=35;
stateBoxWallWidth=5;