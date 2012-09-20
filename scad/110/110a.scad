// First, some global constants.

gridSpacing = 7.58; // The 'period' of the square grid.
gridHoleSize = 6; // Size of the holes in it.
ballDiameter=9.52;
ballRadius = ballDiameter/2;

clearance = 0.2;

// Calculated constants
gridLineWidth = gridSpacing - gridHoleSize;
$fn=20;
$t=(1-$t);

// The grid
module grid()
{
  for (i=[-17:5]) {
    translate([-50,gridSpacing*i+gridHoleSize/2,-1]) cube([100,gridLineWidth,1]);
  }
    
  for (i=[-5:5]) {
    translate([-gridSpacing*i+gridHoleSize/2,-120,-1]) cube([gridLineWidth,150,1]);
  }
}


include <cam1.scad>;
// A simple cam

// Small model bearing from Technobots, stock code 4255-020
module smallBearing()
{
  difference() {
    cylinder(r=3,h=3);
    translate([0,0,-1]) cylinder(r=1.5,h=5);
  }
}

// Place a ball on the grid

// Calculate the recess into the grid...

ballHeight = sqrt(ballRadius*ballRadius - (gridHoleSize/2)*(gridHoleSize/2));

pattern = 3;
bit2 = (pattern>=4)?1:0;
pattern2 = pattern -(bit2*4);
bit1 = (pattern2>=2)?1:0;
pattern3 = pattern2 - (bit1*2);
bit0 = (pattern3>=1)?1:0;

module data()
{
  translate([0,gridSpacing*bit2,ballHeight]) sphere(r=ballRadius, $fn=30);
  translate([gridSpacing*2,gridSpacing*bit1,ballHeight]) sphere(r=ballRadius, $fn=30);
  translate([gridSpacing*4,gridSpacing*bit0,ballHeight]) sphere(r=ballRadius, $fn=30);
   
  // Put a ball out on the sweeper to check alignment
  translate([gridSpacing*2,gridSpacing*-8,ballHeight]) sphere(r=ballRadius, $fn=30);
}

// Now add three 'reader rods'

ballTopZ = ballHeight+(ballRadius);

// Rule 110: 
// Current pattern 111: write 0
// Current pattern X00: write 0
// Otherwise write 1

// Wheel
module wheel()
{
  rotate([90,0,0])
    difference() {
    union() {
      cylinder(r1=wheelRadius-1, r2=wheelRadius, h=1,$fn=100);
      translate([0,0,1])cylinder(r=wheelRadius, h=4,$fn=100);
      translate([0,0,5])	cylinder(r1=wheelRadius,r2=wheelRadius-1,h=1,$fn=100);
    }
    // axle bore
    translate([0,0,-1]) cylinder(r=1.5,h=8);
    // Weight reduction
    for(a=[0,60,120,180,240,300])
      translate([wheelRadius*0.6*cos(a),wheelRadius*0.6*sin(a),-1]) cylinder(r=wheelRadius*0.25,h=8);
    translate([0,0,2])cylinder(r=wheelRadius-3, h=2,$fn=10);		
  }
}

// Calculations to do with wheels

wheelIngressAngle = asin((gridHoleSize/2)/wheelRadius);

echo("Calculated wheel ingress angle = ",wheelIngressAngle);

axleHeight = wheelRadius*cos(wheelIngressAngle);

echo("Calculated axleHeight=",axleHeight);
axle1X = -gridSpacing*3;
axle2X = gridSpacing*7;
// bed-frame on top of axles (union with body)

module squareBarX(size)
{
  difference() {
    cube(size=[size,5,5]);
    translate([-1,1,1])cube(size=[size+2,3,3]);
    if(size>10) {
      translate([size/2-1,1,-1]) cube(size=[3,3,7]); 
    }
  }
}

module squareBarY(size)
{
  translate([5,0,0]) rotate([0,0,90]) squareBarX(size);
}

module squareBarZ(size)
{
  translate([0,0,size]) rotate([0,90,0]) squareBarX(size);
}




module bellCrankBody(crankSize)
{
  union() {
    difference() {
      cylinder(r=crankSize,h=5,$fn=40);
      translate([0,0,-1]) cylinder(r=crankSize-5,h=7,$fn=40);
      translate([-crankSize-1,0,-1]) cube([crankSize*2+2,crankSize*2+2,7]);
      translate([-crankSize-1,-crankSize-1,-1]) cube([crankSize+1-2.5-1,crankSize*2+2,7]);
    }
    translate([-crankSize+2.5,-2.5,0]) squareBarX(crankSize);
    rotate([0,0,-45]) translate([-2.5,-2.5,0]) squareBarX(crankSize);
    translate([crankSize-5,-2.5,0]) cube([5,2.5,5]);
    translate([15,0,2.5]) rotate([0,90,0]) cylinder(r=1.5,h=10);
    translate([20,0,2.5])rotate([0,90,0]) smallBearing();
  }
}

module bellCrank()
{
	crankSize=20;
	rotate([90,0,0])
	
	difference() {
		union()
		{
		bellCrankBody(crankSize);
			translate([0,0,-3]) cylinder(r=1.5,h=11,$fn=30);
			translate([0,0,5]) cylinder(r=2.5,h=1,$fn=30);
			translate([0,0,-1]) cylinder(r=2.5,h=1,$fn=30);
		}
			translate([0,-crankSize+2.5,-1]) cylinder(r=1.5,h=7,$fn=20);
	}
	
	// Add a punt
}


// Reader 1
module reader1()
{
  translate([0,-gridSpacing,-25]) {
    translate([gridSpacing*2,-1.5+gridSpacing*8,0])
      cube(size=[gridSpacing*2,3,30]);
    translate([gridSpacing*2,1.5,20])    
      cube(size=[3,gridSpacing*8,10]);
    translate([gridSpacing*4-3,1.5,20])    
      cube(size=[3,gridSpacing*8,10]);
  }
}


// Reader 1
module reader2()
{
  translate([0,-gridSpacing*1,-25]) {
    translate([0,-1.5+gridSpacing*9,0])
      cube(size=[gridSpacing*4+3,3,30]);
    translate([0,1.5,20])    
      cube(size=[3,gridSpacing*9,10]);
    translate([gridSpacing*4,1.5,20])    
      cube(size=[3,gridSpacing*9,10]);
  }
}

module pusher()
{
  translate([-3,-gridSpacing*1,-25]) {
    difference() {
      union() {
        translate([0,1.5-gridSpacing*7,20])    
          cube(size=[3,gridSpacing*15,10]);
        translate([0,4.5,1.5])    
          cube(size=[3,3,20]);
      }
      translate([-1,50,25])  
        rotate([0,90,0])
        cylinder(r=1.5,h=5);
    }
    difference() {
      translate([gridSpacing*5,1.5-gridSpacing*7,20])    
        cube(size=[3,gridSpacing*15,10]);
      translate([-1+gridSpacing*5,50,25])  
        rotate([0,90,0])
        cylinder(r=1.5,h=5);
    }
  }
}


camShaftY = -50;
camShaftRotate = $t*360;
camShaftZ = 45;


crankPushX = 17.5*sin(crankRotate);
//$t = 0.40;
echo("Movement= ",crankPushX);
echo("$t=",$t);
wheels();
data();
translate([ -10,-30,18]) raiser(); 
grid();

//translate([-10+2.5,camShaftY+2.5,21]) rotate([0,crankRotate,0]) bellCrank();
//translate([-10+2.5-crankPushX,camShaftY ,7.5]) clevis();
camShaftRotate = 360*$t;


translate([0,-gridSpacing*7,25]) {
  difference() {
    rotate([10,0,0])
    reader1();
    translate([-1,0,0])     rotate([0,90,0]) cylinder(r=1.5,h=100);
  }
  difference() {
    rotate([10,0,0])
    reader2();
    translate([-1,0,0])     rotate([0,90,0]) cylinder(r=1.5,h=100);
  }

  difference() {
    rotate([-10,0,0])
    pusher();
    translate([-25,0,0])     rotate([0,90,0]) cylinder(r=1.5,h=100);
  }
}


//clipSleeve();

//translate([20,0,0]) clipSleeveA();
