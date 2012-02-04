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

module dirBoxWalls()
{
  color([0.5,0.5,0.5])
    union() {
    difference() {
      cube(size=[gridSpacing*10+dirBoxWallWidth*2,dirBoxWallWidth,dirBoxHeight]);
      // Sensor support thing
      translate([dirBoxWallWidth-10,-thin,dirBoxHeight-1.5]) cube(size=[gridSpacing*4,dirBoxWallWidth+thin*2,3]);


    }
    difference() {
    translate([0,gridSpacing*4+dirBoxWallWidth,0])
      cube(size=[gridSpacing*10+dirBoxWallWidth*2,dirBoxWallWidth,dirBoxHeight]);
      translate([dirBoxWallWidth+gridSpacing*8,dirBoxWallWidth+1,dirBoxHeight-4.5]) cube(size=[gridSpacing*2,100,3]);
    }

    difference() {
      union() {
        translate([0,dirBoxWallWidth,0])
          cube(size=[dirBoxWallWidth,gridSpacing*4,dirBoxHeight]);
        translate([gridSpacing*10+dirBoxWallWidth,dirBoxWallWidth,0])
          cube(size=[dirBoxWallWidth,gridSpacing*4,dirBoxHeight]);
      }
      translate([-thin,dirBoxWallWidth+gridSpacing*2,dirBoxHeight]) {
        rotate([0,90,0])
          cylinder(r=1.5,h=100);
      }
    }
  }
  
}

module dirboxA()
{
	// Casing
  dirBoxWalls();

  translate([0,dirBoxWallWidth+gridSpacing*2,dirBoxHeight]) rotate([flipperRotate,0,0]) dirFlipper();

	// Amplifier support
        translate([dirBoxWallWidth+gridSpacing*8,dirBoxWallWidth+gridSpacing*4,dirBoxHeight-4.5]) cube(size=[gridSpacing*2,30,3]);

	// Support for reset bar 
	translate([dirBoxWallWidth+gridSpacing*8,dirBoxWallWidth+gridSpacing*4+20,dirBoxHeight-4.5]) cube(size=[gridSpacing*2+30,10,3]);

	// Spring support
	difference() {
          //translate([dirBoxWallWidth-20,-5,dirBoxHeight-1.5]) cube(size=[gridSpacing*4+20,dirBoxWallWidth+5,3]);
          //translate([dirBoxWallWidth-20+2.5,0,dirBoxHeight-2.5]) cylinder(r=1.5,h=100);

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
