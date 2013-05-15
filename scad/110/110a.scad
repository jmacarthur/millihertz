// First, some global constants.

gridSpacing = 7.58; // The 'period' of the square grid.
gridHoleSize = 6; // Size of the holes in it.
ballDiameter=9.52;
ballRadius = ballDiameter/2;
wheelRadius = 15;
laserCut = true;
clearance = 0.2;
thin = 0.01;
// Calculated constants
gridLineWidth = gridSpacing - gridHoleSize;
gridThickness = 1;
$fn=20;
$t=(1-$t);
// Place a ball on the grid

// Calculate the recess into the grid...

ballHeight = sqrt(ballRadius*ballRadius - (gridHoleSize/2)*(gridHoleSize/2));

// Rule 110: 
// Current pattern 111: write 0
// Current pattern X00: write 0
// Otherwise write 1


// Specify the pattern currently on the grid
pattern = 6;
bit2 = (pattern>=4)?1:0;
pattern2 = pattern -(bit2*4);
bit1 = (pattern2>=2)?1:0;
pattern3 = pattern2 - (bit1*2);
bit0 = (pattern3>=1)?1:0;

ballTopZ = ballHeight+(ballRadius);
// Calculations to do with wheels

wheelIngressAngle = asin((gridHoleSize/2)/wheelRadius);

echo("Calculated wheel ingress angle = ",wheelIngressAngle);

axleHeight = wheelRadius*cos(wheelIngressAngle);

echo("Calculated axleHeight=",axleHeight);
axle1X = -gridSpacing*5;
axle2X = gridSpacing*7;

camShaftY = -8*gridSpacing;
camShaftRotate = $t*360;
camShaftZ = 45;
axleRadius = 1.5;

crankPushX = 17.5*sin(crankRotate);

reader1Down = 0;
reader2Down = 0;
reader1Up = 12.5;
reader2Up = 10.3;
pushed = -9.9;
pusherAng = ($t>0.25 && $t<0.75)?25:(pattern==7 ||pattern==6|| pattern==0)?pushed:0;
reader1Ang = (pusherAng>0)?pusherAng+reader1Up:(pattern==7 || pattern==6)?0:reader1Up;
reader2Ang = (pusherAng>0)?pusherAng+reader2Up:(pattern==0)?0:reader2Up;

moverCamPhase = -15;

// All the draw options
drawBellCrank = true;
drawLiftingBar = true;
drawFollowerAxle = true;
drawReaderPusher = true;
drawPusher = true;
drawCamShaft = true;
drawReaders = true;
drawChassis = true;
drawBalanceAxle = false;
drawMotor = false;
drawData = false;
drawWheels = false;
drawResetPlate = true;
reverse = false;
drawGrid = true;
topPlate = true;
beam1 = drawChassis;//drawChassis;
beam2 = drawChassis;//drawChassis;
crossBeam1 = drawChassis;//drawChassis;
crossBeam2 = drawChassis;


wallWidth = (laserCut)?3:2;
chassisWidth = gridSpacing*6+wallWidth;
rodZ = 23.3;
crankSize=20;
crankRotate=($t>0.5 && $t<0.6)?30:0;

// The grid
module grid()
{
  for (i=[-17:5]) {
    translate([-50,gridSpacing*i+gridHoleSize/2,-gridThickness]) cube([100,gridLineWidth,gridThickness]);
  }
    
  for (i=[-8:8]) {
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


module data()
{
  translate([0,gridSpacing*bit2,ballHeight]) sphere(r=ballRadius, $fn=30);
  translate([gridSpacing*2,gridSpacing*bit1,ballHeight]) sphere(r=ballRadius, $fn=30);
  translate([gridSpacing*4,gridSpacing*bit0,ballHeight]) sphere(r=ballRadius, $fn=30);
   
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

module bellCrankPrinted()
{
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
}

module laserBellCrank()
{
  union () {
  difference() {
    rotate([270,0,0]) cylinder(h=wallWidth,r=crankSize);
    translate([-crankSize-thin,-thin,-crankSize-thin]) 
      cube(size=[crankSize-3,wallWidth+thin*2,crankSize-3]);
    translate([-crankSize-thin,-thin,3]) 
      cube(size=[crankSize*2,wallWidth+thin*2,crankSize-3]);
    rotate([270,0,0]) translate([0,0,-3]) cylinder(r=1.5,h=11,$fn=30);
    translate([0,0,-crankSize+3])
    rotate([270,0,0]) translate([0,0,-3]) cylinder(r=1.5,h=11,$fn=30);
  }
  translate([5,0,-wallWidth/2]) {
    cube(size=[crankSize,wallWidth,wallWidth]);
  }
  translate([-crankSize+10,0,-wallWidth/2]) {
    cube(size=[10,wallWidth,wallWidth*2]);
  }
  }
}

module bellCrankJoiner()
{
  difference() {
    translate([-crankSize,-4,wallWidth/2]) {
      cube(size=[30,gridSpacing*4+wallWidth+8,wallWidth]);
    }
    translate([-crankSize+10,-thin,-wallWidth/2-thin]) {
      cube(size=[10,wallWidth+thin,wallWidth*2+thin*2]);
    }
    translate([-crankSize+10,gridSpacing*4,-wallWidth/2-thin]) {
      cube(size=[10,wallWidth+thin,wallWidth*2+thin*2]);
    }
    // Hole to glue in a ball bearing for weight
    translate([-crankSize+5,gridSpacing*2+wallWidth/2,-wallWidth/2+thin]) {
      cylinder(r=3,h=wallWidth*2);
    }
  } 
}


littleReaderWidth = gridSpacing*2;
// Reader 1
module reader1()
{
  reach = gridSpacing*5.8;
  
  translate([0,-gridSpacing,-25]) {
    color([1.0,0.8,0.8]) {
      difference() {
        translate([gridSpacing*2,-1.5+reach,0])
          cube(size=[gridSpacing*2,wallWidth,30+wallWidth]);
        translate([gridSpacing*2-thin,-1.5+reach-thin,20])
          cube(size=[wallWidth+thin,50,10+thin]);
        translate([gridSpacing*4-wallWidth,-1.5+reach-thin,20])
          cube(size=[wallWidth+thin,50,10+thin]);        
        if(!laserCut) {
          translate([gridSpacing*2+wallWidth,-1.5+reach-thin,wallWidth])
            cube(size=[gridSpacing*2-wallWidth*2,wallWidth+thin*2,30-wallWidth*2]);
        }

      }
    }
    difference() {
      translate([gridSpacing*2,1.5,20])    
        cube(size=[wallWidth,reach,10]);
      translate([-1,gridSpacing,25])     rotate([0,90,0]) cylinder(r=1.5,h=100);
    }
    difference() {
    translate([gridSpacing*4-wallWidth,1.5,20])    
      cube(size=[wallWidth,reach,10]);
      translate([-1,gridSpacing,25])     rotate([0,90,0]) cylinder(r=1.5,h=100);
    }
  }

  // Top section to square everything
/*  difference() {
    translate([0,-1.5+reach-wallWidth,21+9])
      cube(size=[littleReaderWidth,10+wallWidth*2,wallWidth]); 
    translate([wallWidth,-1.5+reach+10,21])
      cube(size=[littleReaderWidth-wallWidth*2,wallWidth+thin,9+wallWidth+thin]); 
    
  }
*/

}


bigReaderWidth = gridSpacing*4+6;
// Reader 1
module reader2()
{
  reach = gridSpacing*6.9;
  
  color([0.8,1.0,0.8]) {
    translate([0,-gridSpacing*1,-25]) {
      difference() {
        translate([0,-1.5+reach,0])
          cube(size=[bigReaderWidth,wallWidth,30]);
        translate([-thin,-1.5+reach-thin,21])
          cube(size=[wallWidth+thin,50,10+thin]);
        translate([bigReaderWidth-wallWidth,-1.5+reach-thin,21])
          cube(size=[wallWidth+thin,50,10+thin]);
        if(!laserCut) {
          translate([wallWidth,-1.5+reach-thin,wallWidth])
            cube(size=[bigReaderWidth-wallWidth*2,wallWidth+thin*2,30-wallWidth*2]);
        }
      }
      difference() {
        translate([0,1.5,21])    
          cube(size=[wallWidth,reach+10,9]);
        translate([-1,gridSpacing,25])     
          rotate([0,90,0]) cylinder(r=1.5,h=100);
      }
      difference() {
      translate([bigReaderWidth-wallWidth,1.5,21])    
        cube(size=[wallWidth,reach+10,9]);
        translate([-1,gridSpacing,25])     rotate([0,90,0]) cylinder(r=1.5,h=100);
      }
      translate([wallWidth,-1.5+reach+10,21])
        cube(size=[bigReaderWidth-wallWidth,wallWidth,9+wallWidth]);

      // Top section to square everything
      difference() {
        translate([0,-1.5+reach-wallWidth,21+9])
          cube(size=[bigReaderWidth,10+wallWidth*2,wallWidth]); 
        translate([wallWidth,-1.5+reach+10,21])
          cube(size=[bigReaderWidth-wallWidth*2,wallWidth+thin,9+wallWidth+thin]); 
      
          }
    }
  }
}

module lifterArms() 
{
  for(x=[0,gridSpacing*3-4]) {
    union() {
      difference() {
        translate([x,1.5-gridSpacing*6,20])    
          cube(size=[wallWidth,gridSpacing*10.5,10]);
        translate([-1,30,rodZ])  
          rotate([0,90,0])
          cylinder(r=1.5,h=25);
        translate([-1,1.5-gridSpacing*8,19])  
          cube(size=[50,40,6]);
        translate([-thin,-15,25])  
          rotate([0,90,0])
          cylinder(r=1.5,h=22);

        // Balance axle holes
        translate([-15,gridSpacing,25]) {
          rotate([0,90,0]) cylinder(r=1.5,h=70);
        }


      }
      // Drop bars
      translate([x,3,1.5])    
        cube(size=[wallWidth,4,20]);
    }
  }
}

module pusherParts()
{
  // The web which actually pushes the ball bearing
  difference() {
    translate([wallWidth,3,1.5])    
      cube(size=[gridSpacing*3-4-wallWidth,3,10]);
    translate([3,-5,4])    
      cube(size=[wallWidth,12,5]);
    translate([16,-5,4])    
      cube(size=[wallWidth,12,5]);
  }

  // Guides
  translate([3,-5,4])    
   cube(size=[wallWidth,11,5]);
  translate([16,-5,4])    
   cube(size=[wallWidth,11,5]);
}

module pusher()
{
  translate([4,-gridSpacing*1,-25]) {

    if(laserCut) {
      lifterArms();
      pusherParts();
    }
    else
    {
      union() {
        lifterArms();
        pusherParts();
      }
    }

    // Lifting bar
    if(drawLiftingBar) {
      translate([-5,30,rodZ])  
        rotate([0,90,0])
        color([1.0,0.5,0])
        cylinder(r=1.5,h=35);
    }

    // Cam follower axle
    if(drawFollowerAxle) {
      translate([0,-15,25])  
        rotate([0,90,0])
        color([1.0,0.5,0])
        cylinder(r=1.5,h=22);
      translate([10-5,-15,25])rotate([0,90,0]) smallBearing();
    }

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


module axles() {
  // Axles:
  for(x=[axle1X,axle2X]) {
    translate([x, gridHoleSize/2, axleHeight]) {
      rotate([90,0,0])
        color([1.0,0.5,0])
        cylinder(r=axleRadius,h=100);
    }
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
  //axles();
}

//$t = 0.40;
echo("Movement= ",crankPushX);
echo("$t=",$t);
if(drawWheels) wheels();
if(drawData) data();

if(drawGrid) { grid(); }

if(drawBellCrank) {
  translate([-30+2.5,0,21]) {
    if(laserCut) {
      translate([0,camShaftY,0]) rotate([0,crankRotate,0]) laserBellCrank();
      translate([0,-gridSpacing*4,0]) rotate([0,crankRotate,0]) laserBellCrank();
      translate([0,camShaftY,wallWidth/2]) rotate([0,crankRotate,0]) bellCrankJoiner();
    }
    else
    {
      translate([0,camShaftY+2.5,0]) rotate([0,crankRotate,0]) bellCrankPrinted();
      translate([0,-gridSpacing*4+2.5,0]) rotate([0,crankRotate,0]) bellCrankPrinted();
    }
// Bellcrank fixed axle
    translate([0,-gridSpacing*3+2.5,0 ]) rotate([90,0,0]) color([1.0,0.5,0]) cylinder(r=1.5,h=50);
  }

}

//translate([-10+2.5-crankPushX,camShaftY ,7.5]) clevis();

if(drawReaderPusher) {
  translate([0,-gridSpacing*5,25]) {
    if(drawReaders) {
      rotate([reader1Ang,0,0])
        if(reverse) {
          translate([-gridSpacing*2,0,0])
            reader1();
        }
        else
        {
          reader1();
        }
      rotate([reader2Ang,0,0])
          translate([-wallWidth,0,0]) 
            reader2();
    }
    if(drawPusher) {
      rotate([pusherAng,0,0])
        pusher();
    }
  }

  // Balance axle
  if(drawBalanceAxle) {
    translate([-15,-gridSpacing*5,25]) {
      rotate([0,90,0]) cylinder(r=1.5,h=70);
    }
  }
}
//clipSleeve();

//translate([20,0,0]) clipSleeveA();
if(drawData) {
  //translate([gridSpacing*4,-gridSpacing*6-5.3,ballRadius]) sphere(r=ballRadius, $fn=30);

  translate([gridSpacing*4,-gridSpacing*6-1.8,ballHeight]) sphere(r=ballRadius, $fn=30);
  translate([gridSpacing*7,-gridSpacing*7-1.8,ballHeight]) sphere(r=ballRadius, $fn=30);
}

if(drawCamShaft) {
// Another cam
  translate([-5,camShaftY,40])rotate([camShaftRotate+moverCamPhase,0,0]) rotate([0,90,0])
    if(laserCut) {
      difference() {
        movercam(wallWidth);
        translate([0,0,-wallWidth]) cylinder(r=1.5,h=10);
      }
    }
    else
    {
      union() {
        difference() {
          movercam(wallWidth);
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
    }
  
  
// Another cam
  translate([10,camShaftY,40])rotate([camShaftRotate,0,0]) rotate([0,90,0])
    union() {
    if(laserCut) {
      difference() {
        liftercam(wallWidth);
        translate([0,0,-wallWidth+thin]) cylinder(r=1.5,h=10);
      }
    }
    else
    {
      difference() {
        liftercam(wallWidth);
        translate([0,0,-thin])
          scale([1.0,1.0,1.2]) liftercamCutout(wallWidth);
        translate([0,0,-1]) cylinder(r=1.5,h=10);
      }
      scale([1.0,1.0,0.2]) liftercam(wallWidth);
    }
  }

  //Cam axle
  translate([-15,camShaftY,40]) rotate([0,90,0])
    cylinder(r=1.5,h=60);
}
// Cam axle adapter
if(drawShaftAdapter) {
  translate([-12,camShaftY,40]) rotate([0,270,0])
    difference() {
    cylinder(r=4,h=10);
    translate([0,0,5]) motorOutputShaft();
    translate([0,0,-thin])
      cylinder(r=1.5,h=10+2*thin);
  }
}

module motorOutputShaft()
{  
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
if(beam1) {
  color([0.5,0.0,1.0])
    difference() {
    translate([-45,-gridSpacing*9,1])
      cube(size=[105,wallWidth,25]);
    translate([-12+wallWidth,-gridSpacing*9-1,10])
      cube(size=[35+12-wallWidth,wallWidth+2,32]);

    axles();
    for(x=[axle1X,axle2X]) {
      translate([x-axleRadius,-gridSpacing*9-thin,0]) {
        cube([axleRadius*2,wallWidth+thin*2,axleHeight]);
      }
    }

    // Holes for the bell crank axles
    translate([-30+2.5, -gridSpacing*9-thin,21])
      rotate([270,0,0])
      cylinder(r=1.5,h=100);
    // Facet rear edge
    translate([-45,-gridSpacing*9-thin,10])
      rotate([0,15+90,0])
      cube(size=[20,wallWidth+thin*2,50]);

    // Facet front edge
    translate([45,-gridSpacing*9-thin,1])
      rotate([0,90-15,0])
      cube(size=[20,wallWidth+thin*2,50]);

  }  
}

//Clearance for the finger gaps in the left beam, and the cam holes in the top plate.
clearance = 0.1;

if(beam2)
{
  color([0.5,0.5,0.5])
    difference() {
    translate([-45,-gridSpacing*3,1])
      cube(size=[130,wallWidth,31]);
    translate([-30+2.5, -gridSpacing*9-thin,21])
      rotate([270,0,0])
      cylinder(r=1.5,h=100);

    // Reducing height of front member
    translate([35+wallWidth,-gridSpacing*3-1,30])
      cube(size=[35+12-wallWidth,3+2,32]);

    // Cut slots for readers/lifters...
    for(x=[bigReaderWidth-wallWidth*2, -wallWidth, bigReaderWidth-wallWidth*3, bigReaderWidth-littleReaderWidth-wallWidth*2, 4, gridSpacing*3]) {
    translate([x-clearance,-gridSpacing*3-1,10])
      cube(size=[wallWidth+clearance*2,wallWidth+2,32]);
      }    

    axles();
    for(x=[axle1X,axle2X]) {
      translate([x-axleRadius,-gridSpacing*3-thin,0]) {
        cube([axleRadius*2,wallWidth+thin*2,axleHeight]);
      }
    }

    // Facet rear edge
    translate([-45,-gridSpacing*3-thin,10])
      rotate([0,15+90,0])
      cube(size=[20,wallWidth+thin*2,50]);
    // Facet front edge
    translate([45,-gridSpacing*3-thin,1])
      rotate([0,90-15,0])
      cube(size=[20,wallWidth+thin*2,50]);

  }  
}

// Cross members
if(crossBeam1) {
  color([0.5,0.5,1.0]) {
      union() {
        difference() {
          translate([-12,-gridSpacing*9-5,1])
            cube(size=[wallWidth,chassisWidth+5,45]);
          translate([-12-thin,-gridSpacing*9-5,46])
            rotate([-10,0,0])
      difference() {
      cube(size=[wallWidth+thin*2,chassisWidth+5+5,45]);
      translate([-thin, 15,0])
      cube(size=[wallWidth+thin*4,10,wallWidth]);
          }
          translate([-12-thin,-gridSpacing*9+wallWidth-thin,1-thin])
            cube(size=[5,10+thin,28+thin]);
          translate([-12-thin,-gridSpacing*9+wallWidth-thin+32,1-thin])
            cube(size=[5,7+thin,28+thin]);
          translate([-12-thin,-gridSpacing*9+wallWidth-thin,1-thin])
            cube(size=[5,40+thin,20+thin]);
          translate([-15,camShaftY,40]) rotate([0,90,0])
            cylinder(r=1.5,h=60);
          translate([-12-thin,-gridSpacing*9-thin,1-thin]) 
            cube(size=[wallWidth+thin*2,wallWidth+thin,25]);
          translate([-12-thin,-gridSpacing*9+chassisWidth-wallWidth-thin,1-thin]) 
            cube(size=[wallWidth+thin*2,wallWidth+thin*2,31+thin]);   
          translate([-15,-gridSpacing*5,25]) {
            rotate([0,90,0]) cylinder(r=1.5,h=70);
          }

        }
      }
  }
}

if(crossBeam2) {
  color([0.5,0.5,1.0])
    difference() {
    translate([35,-gridSpacing*9,1])
      cube(size=[wallWidth,chassisWidth,50]);
    translate([35-thin,-gridSpacing*9-5,46])
      rotate([-10,0,0])
      difference() {
      cube(size=[wallWidth+thin*2,chassisWidth+5+5,45]);
      translate([-thin, 15,0])
      cube(size=[wallWidth+thin*4,10,wallWidth]);
    }
    translate([35-thin,-gridSpacing*9+10,1-thin])
      cube(size=[5,30,10+thin]);
    translate([-15,-gridSpacing*5,25]) {
      rotate([0,90,0]) cylinder(r=1.5,h=70);
    }
    translate([-15,-gridSpacing*7,25]) {
      rotate([0,90,0]) cylinder(r=8,h=70);
    }
    translate([-15,camShaftY,40]) rotate([0,90,0])
      cylinder(r=1.5,h=60);
    translate([35-thin,-gridSpacing*9+chassisWidth-wallWidth-thin,1-thin]) 
      cube(size=[wallWidth+thin*2,wallWidth+thin*2,31+thin]);
    translate([35-thin,-gridSpacing*9-thin,1-thin]) 
      cube(size=[wallWidth+thin*2,wallWidth+thin,25]);    
  }
}

// Top plate to locate the cams
  f = 27;
if(topPlate) {
  translate([-12,-gridSpacing*9-5-f*cos(10),46+f*sin(10)])
    rotate([-10,0,0])
    difference() {
    cube(size=[35+12+wallWidth,45+f,wallWidth]);
    translate([-thin, 15+f,-thin])
      cube(size=[wallWidth+thin,10,wallWidth+thin*2]);
    translate([35+12, 15+f,-thin])
      cube(size=[wallWidth+thin,10,wallWidth+thin*2]);
// Slots for cams
    translate([-5+12-wallWidth/2-clearance, 15,-thin])
      cube(size=[wallWidth+thin+clearance*2,50,wallWidth+thin*2]);    
    translate([10+12-wallWidth/2-clearance, 15,-thin])
      cube(size=[wallWidth+thin+clearance*2,50,wallWidth+thin*2]);
  }
}



// The motor - technobots order code 1400-034
// datum is the end of the motor shaft
module motor()
{
  union()  {
    rotate([0,90,0]) motorOutputShaft();
    translate([9,-11,-11]) cube(size=[20,68,22]);
    translate([9+8,-16,-3]) cube(size=[2,6,6]);
  }
}


if(drawMotor) translate([-15,camShaftY,40]) rotate([-5,180,0]) motor();

// A plate on the bottom to reset data

module resetPlate()
{
  translate([-45+105-30,-gridSpacing*9+wallWidth,2])
  {
    difference() {
      cube([20,13,wallWidth]);
      translate([0,0,-thin])
        translate([0,13,0])
        rotate([0,0,-23])
        cube([40,13,wallWidth+thin*2]);
      if(laserCut) {
        translate([5,0,-thin])
        cube([wallWidth,7,wallWidth+thin*2]);
      }
    }
  }

  translate([-45+105-30,-gridSpacing*9+chassisWidth-wallWidth,2])
  difference() {
    translate([0,-19,0])
      cube([20,19,wallWidth]);
    if(laserCut) {
      translate([5,-5,-thin])
        cube([wallWidth,7,wallWidth+thin*2]);
    }
  }
}
if(drawResetPlate) {resetPlate();}
