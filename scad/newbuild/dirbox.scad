include <params.scad>

// This is the direction box; the part which switches the direction of the machine.


dirBoxOverallWidth=gridSpacing*10+dirBoxWallWidth*2;
// Gap is the space between the dir box flipper paddles and the wall of the box.
flipperRotate=90;

flipperWidth=10;
gap = (gridSpacing*2-flipperWidth)/2;
module dirFlipper()
{
	union() {
	    translate([-8,0,0]) rotate([0,90,0]) cylinder(r=1.5,h=113,$fn=10);
	    translate([120-1.5-15,0,0]) rotate([270,0,0]) cylinder(r=1.5,h=20,$fn=10);
	    translate([-5,0,0])	    rotate([0,90,0]) cylinder(r=2.5,h=5,$fn=10);
	    translate([dirBoxOverallWidth,0,0])	    rotate([0,90,0]) cylinder(r=2.5,h=5,$fn=10);
	    for(i=[0:4]) {
	        translate([gridSpacing*i*2+dirBoxWallWidth+gap,-10,-0.5])	cube(size=[10,20,1]);
	    }  
	    difference() {
	    	    translate([-8,0,0]) rotate([0,90,0]) cylinder(r=10,h=3);
		    rotate([0,0,0]) translate([-9,3,-1.5]) cube(size=[5,20,3]);
		    rotate([90,0,0]) translate([-9,8,-1.5]) cube(size=[5,20,3]);
		    rotate([180,0,0]) translate([-9,3,-1.5]) cube(size=[5,20,3]);
		    rotate([270,0,0]) translate([-9,8,-1.5]) cube(size=[5,20,3]);
		    }
	}
}

module dirBoxLongWall()
{
  difference() {
    cube(size=[gridSpacing*10+dirBoxWallWidth*2,dirBoxWallWidth,dirBoxHeight]);
    translate([gridSpacing*4,-thin,5]) cube(size=[gridSpacing*2,dirBoxWallWidth+thin*2,5+thin]); // Space for notch support
  }
}
module dirBoxShortWall()
{
  difference() {
    cube(size=[dirBoxWallWidth,gridSpacing*4,dirBoxHeight]);
    translate([-thin,gridSpacing*2,dirBoxHeight]) {
      rotate([0,90,0])
        cylinder(r=1.5,h=dirBoxWallWidth+thin*2);
    }
    translate([-thin,-thin,dirBoxHeight-5]) {
      cube(size=[dirBoxWallWidth+thin*2,gridSpacing+thin,5+thin]);
    }
    translate([-thin,gridSpacing*3,dirBoxHeight-5]) {
      cube(size=[dirBoxWallWidth+thin*2,gridSpacing+thin,5+thin]);
    }
  }
}

module dirBoxWalls()
{
  color([0.5,0.5,0.5])
    union() {
    difference() {
      dirBoxLongWall();
      // Sensor support thing
      translate([-thin,-thin,dirBoxHeight-1.5]) cube(size=[20+thin,dirBoxWallWidth+thin*2,3]);
    }
    difference() {
    translate([0,gridSpacing*4+dirBoxWallWidth,0])
      dirBoxLongWall();
      translate([dirBoxWallWidth+gridSpacing*8,dirBoxWallWidth+1,dirBoxHeight-4.5]) cube(size=[gridSpacing*2,100,3]);
    }

    translate([0,dirBoxWallWidth,0])
      dirBoxShortWall();
    translate([gridSpacing*10+dirBoxWallWidth,dirBoxWallWidth,0])
      dirBoxShortWall();
  }
  
}

module dirboxA()
{
	// Casing
  dirBoxWalls();

  translate([0,dirBoxWallWidth+gridSpacing*2,dirBoxHeight]) rotate([flipperRotate,0,0]) dirFlipper();

  // Amplifier support / support for reset bar
  difference() {
    union() {
      translate([dirBoxWallWidth+gridSpacing*8,dirBoxWallWidth+gridSpacing*4,dirBoxHeight-4.5]) cube(size=[gridSpacing*2,30,3]);
      
      translate([dirBoxWallWidth+gridSpacing*8,dirBoxWallWidth+gridSpacing*4+20,dirBoxHeight-4.5]) cube(size=[gridSpacing*2+30,10,3]);
    }
    translate([70,dirBoxWallWidth+gridSpacing*4+20,dirBoxHeight-4.5]) cylinder(r=2.5,h=50);
  }
  // Spring support
  difference() {
    translate([-20,-5,dirBoxHeight-1.5]) cube(size=[40,dirBoxWallWidth+5,3]);
    translate([-15,0,dirBoxHeight-2.5]) cylinder(r=1.5,h=100);
  }  
}

module dirbox()
{
  translate([0,0,dirBoxWallWidth]) {
    dirboxA();
  }
  difference() {
    translate([-gridSpacing*2,0,0])
      cube(size=[gridSpacing*16,dirBoxWallWidth*2+gridSpacing*4,dirBoxWallWidth]);
    translate([dirBoxWallWidth,dirBoxWallWidth,-thin])
      cube(size=[gridSpacing*10,gridSpacing*4,dirBoxWallWidth+2*thin]);
  }
}
