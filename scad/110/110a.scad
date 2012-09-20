// First, some global constants.

gridSpacing = 7.58; // The 'period' of the square grid.
gridHoleSize = 6; // Size of the holes in it.
ballDiameter=9.52;
ballRadius = ballDiameter/2;
wheelRadius = 15;

clearance = 0.2;
thin = 0.01;
// Calculated constants
gridLineWidth = gridSpacing - gridHoleSize;
gridThickness = 1;
$fn=20;
$t=(1-$t);

// The grid
module grid()
{
  for (i=[-17:5]) {
    translate([-50,gridSpacing*i+gridHoleSize/2,-gridThickness]) cube([100,gridLineWidth,gridThickness]);
  }
    
  for (i=[-5:5]) {
    translate([-gridSpacing*i+gridHoleSize/2,-120,-gridThickness]) cube([gridLineWidth,150,gridThickness]);
  }
}


include <cam1.scad>;
include <liftercam.scad>;
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

pattern = 4;
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
axle1X = -gridSpacing*5;
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
			translate([0,0,5]) cylinder(r=2.5,h=1,$fn=30);
			translate([0,0,-1]) cylinder(r=2.5,h=1,$fn=30);
		}
                translate([0,0,-3]) cylinder(r=1.5,h=11,$fn=30);
                translate([0,-crankSize+2.5,-1]) cylinder(r=1.5,h=7,$fn=20);
	}
	
	// Add a punt
}


// Reader 1
module reader1()
{
  reach = gridSpacing*5.8;
  color([1.0,0.8,0.8]) {
  translate([0,-gridSpacing,-25]) {
    translate([gridSpacing*2,-1.5+reach,0])
      cube(size=[gridSpacing*2,3,30]);
    translate([gridSpacing*2,1.5,20])    
      cube(size=[3,reach,10]);
    translate([gridSpacing*4-3,1.5,20])    
      cube(size=[3,reach,10]);
  }
  }
}


// Reader 1
module reader2()
{
  reach = gridSpacing*6.9;
  color([0.8,1.0,0.8]) {
    translate([0,-gridSpacing*1,-25]) {
      translate([0,-1.5+reach,0])
        cube(size=[gridSpacing*4+3,3,30]);
      translate([0,1.5,21])    
        cube(size=[3,reach+10,9]);
      translate([gridSpacing*4,1.5,21])    
        cube(size=[3,reach+10,9]);
      translate([0,-1.5+reach+10,21])   // This bit is to glue ball bearings to
        cube(size=[gridSpacing*4+3,3,9]); 
    }
  }
}

module pusher()
{
  rodZ = 23.3;
  translate([4,-gridSpacing*1,-25]) {
    for(x=[0,gridSpacing*3-4]) {
      difference() {
        translate([x,1.5-gridSpacing*6,20])    
          cube(size=[3,gridSpacing*10.5,10]);
        translate([-1+gridSpacing*5,50,25])  
          rotate([0,90,0])
          cylinder(r=1.5,h=5);
        translate([-1,30,rodZ])  
          rotate([0,90,0])
          cylinder(r=1.5,h=5);
        translate([-1,1.5-gridSpacing*8,19])  
          cube(size=[50,40,6]);
      }
    }
        // Drop bar
    translate([0,3,1.5])    
      cube(size=[3,3,20]);
    translate([0,3,1.5])    
      cube(size=[30,3,10]);
    translate([gridSpacing*3-4,3,1.5])    
      cube(size=[3,3,20]);
    // Guides
    translate([3,-5,4])    
      cube(size=[3,8,5]);
    translate([16,-5,4])    
      cube(size=[3,8,5]);
    
  
    // Lifting bar
    translate([-5,30,rodZ])  
    rotate([0,90,0])
      color([1.0,0.5,0])
    cylinder(r=1.5,h=35);

    // Cam follower axle
    translate([0,-15,25])  
    rotate([0,90,0])
      color([1.0,0.5,0])
      cylinder(r=1.5,h=22);
    translate([10-5,-15,25])rotate([0,90,0]) smallBearing();

  }
}
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


module wheels()
{
  translate([0, -gridSpacing*2+gridHoleSize/2, axleHeight]) {
    translate([axle1X,0,0]) wheel();
    translate([axle1X,-gridSpacing*8,0]) wheel();
    translate([axle2X,0,0]) wheel();
    translate([axle2X,-gridSpacing*8,0]) wheel();
  }
  // Axles:
  for(x=[axle1X,axle2X]) {
    translate([x, gridHoleSize/2, axleHeight]) {
      rotate([90,0,0])
        color([1.0,0.5,0])
        cylinder(r=1.5,h=100);
    }
  }
}

camShaftY = -8*gridSpacing;
camShaftRotate = -90;
camShaftZ = 45;


crankPushX = 17.5*sin(crankRotate);
//$t = 0.40;
echo("Movement= ",crankPushX);
echo("$t=",$t);
wheels();
data();
translate([ -10,-30,18]) raiser(); 
grid();

translate([-30+2.5,camShaftY+2.5,21]) rotate([0,crankRotate,0]) bellCrank();
translate([-30+2.5,-gridSpacing*4+2.5,21]) rotate([0,crankRotate,0]) bellCrank();
// Bellcrank fixed axle
translate([-30+2.5,-gridSpacing*3+2.5,21]) rotate([90,0,0]) color([1.0,0.5,0]) cylinder(r=1.5,h=100);


//translate([-10+2.5-crankPushX,camShaftY ,7.5]) clevis();

reader1Down = 0;
reader2Down = 0;
reader1Up = 12.5;
reader2Up = 10.3;
pushed = -9.9;
reader1Ang = reader1Up;
reader2Ang = 0;
pusherAng = 25;
translate([0,-gridSpacing*5,25]) {
  difference() {
    rotate([reader1Ang,0,0])
    reader1();
    translate([-1,0,0])     rotate([0,90,0]) cylinder(r=1.5,h=100);
  }
  difference() {
    rotate([reader2Ang,0,0])
    reader2();
    translate([-1,0,0])     rotate([0,90,0]) cylinder(r=1.5,h=100);
  }

  difference() {
   rotate([pusherAng,0,0])
    pusher();
    translate([-25,0,0])     rotate([0,90,0]) cylinder(r=1.5,h=100);
  }
}

// Balance axle

translate([-15,-gridSpacing*5,25]) {
  rotate([0,90,0]) cylinder(r=1.5,h=70);
}

//clipSleeve();

//translate([20,0,0]) clipSleeveA();
translate([gridSpacing*4,-gridSpacing*6-5.3,ballRadius]) sphere(r=ballRadius, $fn=30);

translate([gridSpacing*2,-gridSpacing*6-1.8,ballHeight]) sphere(r=ballRadius, $fn=30);

moverCamPhase = -15;
// Another cam
translate([-5,camShaftY,40])rotate([camShaftRotate+moverCamPhase,0,0]) rotate([0,90,0])
union() {
  difference() {
    movercam();
    translate([0,0,-5-thin]) cylinder(r=14,h=10+thin*2);
    translate([0,0,-1]) cylinder(r=1.5,h=10);
  }
  difference() {
    translate([0,0,-1]) cylinder(r=14,h=2);
    for(r=[0:5])
      rotate([0,0,r*60])
        translate([10,0,-1-thin]) cylinder(r=4,h=2+2*thin);

  }
}


// Another cam
translate([10,camShaftY,40])rotate([camShaftRotate,0,0]) rotate([0,90,0])
union() {
  difference() {
    liftercam();
    translate([0,0,-thin])
      scale([1.0,1.0,1.2]) liftercamCutout();
    translate([0,0,-1]) cylinder(r=1.5,h=10);
  }
  scale([1.0,1.0,0.2]) liftercam();
}

//Cam axle
translate([-15,camShaftY,40]) rotate([0,90,0])
cylinder(r=1.5,h=60);

// Cam axle adapter

translate([50,camShaftY,40]) rotate([0,90,0])
difference() {
  cylinder(r=4,h=10);
  motorOutputShaft();
  translate([0,0,-thin])
  cylinder(r=1.5,h=10+2*thin);
}

module motorOutputShaft()
{  
  translate([0,0,5])
    difference() {
    cylinder(r=(5.5/2),h=9);
    for(flat=[0,180]) {
      rotate([0,0,flat])
      translate([1.9,-5,-thin])
        cube(size=[5,10,8+thin]);
    }
  }
}


// The chassis beams
color([0.5,0.5,1.0])
difference() {
  translate([-45,-gridSpacing*9,1])
    cube(size=[100,3,25]);
  translate([-10,-gridSpacing*9-1,10])
    cube(size=[70,3+2,32]);
}  

color([0.5,0.5,1.0])
difference() {
  translate([-45,-gridSpacing*3,1])
    cube(size=[100,3,25]);
  translate([-25,-gridSpacing*3-1,10])
    cube(size=[60,3+2,32]);
}  

wallWidth = 3;
chassisWidth = gridSpacing*6+wallWidth;

// Cross members
color([0.5,0.5,1.0])
union() {
  difference() {
    translate([-12,-gridSpacing*9,1])
      cube(size=[wallWidth,chassisWidth,50]);
    translate([-12-thin,-gridSpacing*9+wallWidth,1-thin])
      cube(size=[5,40,30+thin]);
  }
  translate([-12,-gridSpacing*6,20]) cube(size=[3,10,20]);
}


color([0.5,0.5,1.0])
difference() {
  translate([45,-gridSpacing*9,1])
      cube(size=[wallWidth,chassisWidth,50]);
  translate([45-thin,-gridSpacing*9+10,1-thin])
    cube(size=[5,30,10+thin]);
}



// The motor
