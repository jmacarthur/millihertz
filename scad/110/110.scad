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

// A clip-close sleeve for axles
module clipSleeve()
{
	difference() {
		cylinder(r=5,h=5);
		translate([0,0,-1])cylinder(r=2.5+2*clearance,h=12);
		translate([0,-6,-1]) cube([10,12,12]);
		translate([-3,2.5+1.25,-1])cylinder(r=1+clearance,h=20); // Note - only clearance on one side, as I want an interference fit here
		translate([-3,-5+1.25,-1])cylinder(r=1+clearance,h=20);
		
		}
}

module clipSleeveA()
{
	union() {
	difference() {
		cylinder(r=5,h=7);
		translate([0,0,-1])cylinder(r=2.5+2*clearance,h=12,$fn=50);
		translate([-10,-6,-1]) cube([10,12,12]);
		}
		translate([-4,2.5+clearance*2,5]) cube([4.1,2.4,2]);
		translate([-4,-5,5]) cube([4.1,2.5-clearance*2,2]);
		translate([-3,2.5+1.25,0])cylinder(r=1,h=7);
		translate([-3,-5+1.25,0])cylinder(r=1,h=7);
		}
}



include <c:\Users\Jim\Documents\cam1.scad>;
// A simple cam

//linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
//polygon(points=[[0,0],[100,0],[100,100],[50,150],[0,100]], paths=[[0,1,2,3,4]]);


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

pattern = 7;
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
translate([gridSpacing*2,gridSpacing*-12,ballHeight]) sphere(r=ballRadius, $fn=30);


}

// Now add three 'reader rods'

ballTopZ = ballHeight+(ballRadius);

// Rule 110: 
// Current pattern 111: write 0
// Current pattern X00: write 0
// Otherwise write 1
feelerSize = 4.76;
module feeler()
{
	difference() {
	union()
	 {translate([-feelerSize/2,-feelerSize/2,0])
	  cube(size=[feelerSize,feelerSize,50]);
	}
		translate([-10,-feelerSize/2-1,35]) cube([50,4,2]);
		translate([-feelerSize/2+1,-feelerSize/2+1,-1]) cube([3,3,30]);
		}
	  
}

// Notch feeler1
module feeler1()
{
union() {
difference()
	{
		feeler();
		translate([-10,-feelerSize/2-1,40]) cube([50,4,2]);
		translate([-10,-feelerSize/2-1,40-ballTopZ]) cube([50,4,2]);
		translate([-feelerSize/2+1,-feelerSize/2+1,40+3]) cube([3,3,30]);
		}
		  translate([0,-feelerSize/2+1,10]) rotate([90,0,0]) cylinder(r=2,h=9,$fn=10);

		}	  
}

module feeler2()
{
union()
{difference()
	{
		feeler();
		translate([-10,-feelerSize/2-1,40-ballTopZ]) cube([50,4,2]);
		translate([-feelerSize/2+1,-feelerSize/2+1,43]) cube([3,3,30]);
		}
		  translate([0,-feelerSize/2+1,10]) rotate([90,0,0]) cylinder(r=2,h=9,$fn=10);

}
}

// lever 1
engage1=(pattern==7)?1:0;
module lever()
{
	difference() {
	union() {
	translate([-100,-5,0])
	cube(size=[105,10,2]);
	translate([0,0,-20])cylinder(r=2.5,h=20);
	translate([0,0,-5])cylinder(r=3.5,h=10);
	}
		// Hole for axle
		translate([0,0,-30])cylinder(r=1.5+2*clearance,h=50);
		// Hole for spring attachment
		translate([-83,2,-1]) cylinder(r=1.5,h=4);
		for(x=[1:7]) translate([-10*x,0,-1]) cylinder(r=4,h=4);
		for(x=[0:1]) translate([-78-10*x,-1,-1]) cylinder(r=3,h=4);
		translate([-95,-0,-1]) cylinder(r=3,h=4);
		// Chamfer edges
		translate([-101,5,1.5]) rotate([45,0,0]) cube([100,2,2]);
		translate([-101,7,-4.5]) rotate([45,0,0]) cube([100,5,5]);
	}
	
}

module lever2()
{
	difference() {
	union() {
	translate([-100,-5,0])
	cube(size=[105,10,2]);
	translate([0,0,-15])cylinder(r=1.5,h=15);
	}
		// Hole for spring attachment
		translate([-83,2,-1]) cylinder(r=1.5,h=4);
		for(x=[1:7]) translate([-10*x,0,-1]) cylinder(r=4,h=4);
		for(x=[0:1]) translate([-78-10*x,-1,-1]) cylinder(r=3,h=4);
		translate([-95,-0,-1]) cylinder(r=3,h=4);
		translate([-101,5,1.5]) rotate([45,0,0]) cube([100,5,5]);
		translate([-101,5,-6.5]) rotate([45,0,0]) cube([100,5,5]);
		}
}

leverAxisX = -20+95;
leverAxisY = -10-feelerSize/2+9;


// lever 2
engage2=(pattern==4 || pattern==0)?1:0;

// Tower for mounting springs to
module springTower()
{
difference()
{
union()
{
translate([-10,30,25]) squareBarZ(15);
translate([-10,0,25]) squareBarY(30);
translate([-10,25,35]) cube([5,10,2]);
translate([-10,25,40]) cube([5,10,2]);
}
translate([-7.5,27.5,0]) cylinder(r=1.5,h=100);
}
}

wheelRadius = 15;

// guide plate (baseplate)
module basePlate() 
{
difference() {
	union() {
	translate([-5,-5,25])cube(size=[40,10,5]);
	translate([leverAxisX,leverAxisY,20]) cylinder(r=5,h=10);
	translate([-3.5,-2.5-1,45])cube(size=[gridSpacing*4+7,5+3.5,1]);
	translate([35,-5,25]) squareBarX(40);
	translate([29,-30,25]) squareBarX(45);
	translate([-20,0,25]) squareBarX(20);
	translate([leverAxisX-2.5,-30,25]) squareBarY(30);
	difference() {
		translate([-3.5,4,25])cube(size=[gridSpacing*4+7,1,20]);
		translate([gridSpacing*1,3,37]) rotate([270,0,0]) cylinder(r=7,h=4);
		translate([gridSpacing*3,3,37]) rotate([270,0,0]) cylinder(r=7,h=4);
		}
	translate([-3.5,2.5,35])cube(size=[gridSpacing*4+7,2,1]);
	translate([-3.5,2.5,40])cube(size=[gridSpacing*4+7,2,1]);
	}

	// Cut out holes for feelers
	translate([-feelerSize/2-clearance,-feelerSize/2-clearance,-1]) cube([feelerSize+2*clearance,feelerSize+2*clearance,100]);
	translate([gridSpacing*2-feelerSize/2-clearance,-feelerSize/2-clearance,-1]) cube([feelerSize+2*clearance,feelerSize+2*clearance,100]);
	translate([gridSpacing*4-feelerSize/2-clearance,-feelerSize/2-clearance,-1]) cube([feelerSize+2*clearance,feelerSize+2*clearance,100]);
	// Hole for lever axle
	translate([leverAxisX,leverAxisY,-1]) cylinder(r=2.5+clearance*2,h=100);
	
	// Square holes between feelers
	translate([gridSpacing*1-2.5,0-2.5,24]) cube([5,5,12]);
	translate([gridSpacing*3-2.5,0-2.5,24]) cube([5,5,12]);
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

// Calculations to do with wheels

wheelIngressAngle = asin((gridHoleSize/2)/wheelRadius);

echo("Calculated wheel ingress angle = ",wheelIngressAngle);

axleHeight = wheelRadius*cos(wheelIngressAngle);

echo("Calculated axleHeight=",axleHeight);
axle1X = -gridSpacing*3;
axle2X = gridSpacing*7;
// Legs
module leg()
{
color([0.5,0.5,0.5]) {
difference() {
	translate([axle1X-2.5,0,axleHeight-3]) cube(size=[5,5,25-axleHeight]);
	translate([axle1X,6,axleHeight]) rotate([90,0,0]) cylinder(r=1.5+clearance,h=20,$fn=20);
	translate([axle1X-1.5,1,axleHeight-4]) cube(size=[3,3,28]);
	}
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

module bedFrame()
{
union() {
translate([axle1X-2.5,-gridSpacing*10+3.5,21]) squareBarX(gridSpacing*4+5);
translate([axle1X-2.5+gridSpacing*6,-gridSpacing*10+3.5,21]) squareBarX(gridSpacing*4+1);

translate([axle1X-2.5+gridSpacing*6,-gridSpacing*12+3.5,21]) squareBarY(gridSpacing*2+5);
translate([axle1X-2.5+gridSpacing*4,-gridSpacing*12+8,21]) squareBarY(gridSpacing*1+4);
translate([axle1X-2.5+gridSpacing*4,-gridSpacing*12+3.5,21]) squareBarX(gridSpacing*2+2);

translate([axle1X-2.5,-gridSpacing*2-2.5-3-2.5,21]) squareBarX(gridSpacing*10+1);
//translate([axle1X-2.5,-gridSpacing*10+2.5+1,21]) cube([5,gridSpacing*8,5]); // fouls crank!
translate([axle2X-2.5,-gridSpacing*10+2.5+1,21]) squareBarY(gridSpacing*8-3-3.5);
translate([0,-gridSpacing*2-2.5-3-2.5,0]) leg();
translate([0,-gridSpacing*10+2.5+1,0]) leg();
translate([gridSpacing*10,-gridSpacing*2-2.5-3-2.5,0]) leg();
translate([gridSpacing*10,-gridSpacing*10+2.5+1,0]) leg();

// This is a little plate to stop output balls travelling too far
translate([gridSpacing*2-5,-gridSpacing*11-2,1.9]) rotate([0,0,0])cube([10,1,24]);
}

}

module wheels()
{
translate([axle1X,-gridSpacing*2+gridHoleSize/2+0.5,axleHeight]) wheel();
translate([axle1X,-gridSpacing*10+gridHoleSize/2,axleHeight]) wheel();
translate([axle2X,-gridSpacing*2+gridHoleSize/2+1,axleHeight]) wheel();
translate([axle2X,-gridSpacing*10+gridHoleSize/2,axleHeight]) wheel();
}

module leverGuide(){
difference() {
translate([0,-30,25]) cube([5,35,20]);
translate([-1,-27,35]) cube([10,30,2+2*clearance]);
translate([-1,-27,40]) cube([10,30,2+2*clearance]);
translate([-1,-27,30]) cube([10,30,3]);
for(x=[0:6]){
translate([2.5,-27.5+5*x,24]) cylinder(r=1.5,h=30);
}
	// Extra drain holes 
	translate([-1,1,26]) cube([30,3,3]);
	translate([-1,-29,26]) cube([30,3,3]);

}
}


// More support bars
module sweeperGuides()
{
difference()
{
	translate([-10,-90,25]) cube([10,80,5]);
	translate([-9,-91,26]) cube([8,85,3]);
	translate([-11,-55,24]) cube([5,10,5]);
	}
// sweeper slide guide
translate([-15-2*clearance,-30,30]) squareBarY(15);
translate([-15,-30,29]) cube([6,15,1]);
translate([-15-2*clearance,-30,29]) cube([5,15,2]);

translate([-5,-30,30]) squareBarY(15);
union()
{
translate([-15-2*clearance,-90,30]) squareBarY(15);
translate([-15,-90,29]) cube([6,15,1]);
translate([-15-2*clearance,-90,29]) cube([5,15,2]);
}

// Crank support
difference()
{
union() {
translate([-11,-55,18]) cube([10,1,12]);
translate([-11,-46,18]) cube([10,1,12]);
}
translate([-7.5,-43,21]) rotate([90,0,0]) cylinder(r=1.5+clearance,h=20);
translate([-7.5,-43,23]) rotate([90,0,0]) cylinder(r=1.5+clearance,h=20);
translate([-9-clearance,-63,21]) cube([3+clearance*2,20,2]);
translate([-12,-63,22.5-clearance]) cube([4.5,20,2+clearance*2]);
}
}


// Support bars for raiser
module raiserSupport()
{
translate([0,-35,15]) difference()
{
	union() {
		translate([-4,4.5,-1])rotate([45,0,0]) squareBarY(15);
		translate([30-0.5,4.5,-1])rotate([45,0,0]) squareBarY(15);
		
	}
	translate([-5,5,3]) rotate([0,90,0]) cylinder(r=1.5+clearance,h=45);
	translate([-5,5-1.5-clearance,3])cube([45,3+clearance*2,10]);
	 
}
}


module body() {
	color([0.5,0.5,0.5])
	difference() {
	union() {
		basePlate();
		translate([-25,0,0]) leverGuide();
		sweeperGuides();
		difference() {
		bedFrame();
			// Big hole for the cam (Annoying)
			translate([10,camShaftY,camShaftZ]) rotate([0,90,0]) cylinder(r=35,h=7);

		}
		camShaftSupport();
		springTower();
		raiserSupport();
		}
			translate([axle1X,-1*gridSpacing-3.5,axleHeight]) rotate([90,0,0]) cylinder(r=wheelRadius+2,h=7);
			translate([axle2X,-1*gridSpacing-3.5,axleHeight]) rotate([90,0,0]) cylinder(r=wheelRadius+2,h=7);

}
}

// Raiser bar for the feelers
module raiser()
{
	angle = max(150,(150+30*sin(($t-0.18)*300)));
	rotate([angle,0,0])
	difference()
	{
	union() {
	translate([5,0,0]) rotate([0,90,0]) cylinder(r=1.5,h=40,$fn=50);
	rotate([0,0,0])translate([5,-25,-3]) cube([1,27,6]);
	rotate([0,0,0])translate([45,-25,-3]) cube([1,63,6]);
	translate([5,-30+6,0]) rotate([0,90,0]) cylinder(r=1.5,h=41,$fn=10);
	}
	for(x=[0:3]) translate([0,15+6*x,0]) rotate([0,90,0]) cylinder(r=1.5,h=50,$fn=10);
	}
	}
	

ext = -91+gridSpacing*-1;
// Sweeper
module sweeper() {
union()
{
    translate([-10,ext,35]) squareBarY(105);
	translate([-12.5,7.5,40]) cylinder(r=2.5,h=10);
	translate([-15,5,35]) squareBarX(10);
	translate([-6,ext,35]) squareBarX(31);
	translate([9,ext,6]) difference() {
		cube([12,5,29]);
		translate([1,1,-1]) cube([10,3,31]);
		}
	translate([9,ext,6]) cube([1,10,10]);
	translate([20,ext,6]) cube([1,10,10]);
	translate([-10,-62,35]) squareBarZ(20);
	translate([-10,-59.5,49.5]) rotate([0,90,0]) cylinder(r=2.5,h=11,$fn=20);
	translate([-10,-60.5,49.5]) rotate([0,90,0]) cylinder(r=1.5,h=16,$fn=20);
}
}


// A camshaft
module camshaft()
{
color([0,0,1]) {
union() {
// Central shaft
difference()
{
translate([0,0,0]) rotate([0,90,0]) cylinder(r=2.5,h=100,$fn=100);
translate([90,-6,1.5]) cube([11,12,3]);
translate([90,-6,-4.5]) cube([11,12,3]);
}
// Raiser cam
difference() {
union() {
translate([43,0,0]) rotate([0,90,0]) cylinder(r=10,h=5,$fn=100);
translate([43,0,14]) rotate([0,90,0]) cylinder(r=10,h=5,$fn=100);
}
translate([42,0,14]) rotate([0,90,0]) cylinder(r=8,h=7,$fn=20);
for(x=[1:5])
{
	translate([42,6*sin(360*x/6),6*cos(360*x/6)]) rotate([0,90,0]) cylinder(r=2,h=7,$fn=20);
}

}
// Sweeper cam
difference()
{
translate([11,0,0]) rotate([0,90,0]) cylinder(r=25,h=5,$fn=100);
translate([10,-17.5,0]) rotate([0,90,0]) cylinder(r=7.5,h=7,$fn=20);
translate([10,-13,-6]) rotate([155,0,0]) cube([7,15,15]);
translate([10,-12,5]) rotate([135,0,0]) cube([7,15,15]);
for(x=[0:3])
{
	translate([10,15*sin(360*x/6),15*cos(360*x/6)]) rotate([0,90,0]) cylinder(r=6,h=7,$fn=20);
}
for(x=[0:6])
{
	translate([10,6*sin(360*x/6),6*cos(360*x/6)]) rotate([0,90,0]) cylinder(r=2,h=7,$fn=10);
	translate([10,20*sin(30+360*x/6),20*cos(30+360*x/6)]) rotate([0,90,0]) cylinder(r=2,h=7,$fn=10);
}
	translate([10,15*sin(310),15*cos(310)]) rotate([0,90,0]) cylinder(r=2,h=7,$fn=10);
	translate([10,21*sin(310),21*cos(310)]) rotate([0,90,0]) cylinder(r=2,h=7,$fn=10);
}

// Movement cam
translate([23.5,0,0]) rotate([0,90,0]) 
union()
{difference() {
	movercam();
	translate([0,0,-6])cylinder(r=18,h=20);}
}
// Make spokes
translate([21,0,0]) {
for (x=[0:5])
{
rotate([x*60,0,0]) translate([0,0,0])cube([5,20,3]);
}
}

// Tiny lips to centre the shaft
translate([48,0,0]) { rotate([0,90,0]) cylinder(r=5,h=2,$fn=20);} 
translate([10,0,0]) { rotate([0,90,0]) cylinder(r=5,h=2,$fn=20);} 



// input pulley
difference()
{union()
{
translate([66,0,0]) {
rotate([0,90,0]) cylinder(r=20,h=1);
}
translate([66,0,0]) {
rotate([0,90,0]) cylinder(r=17,h=5,$fn=100);
}
translate([70,0,0]) {
rotate([0,90,0]) cylinder(r=20,h=1);
}
}
translate([65,0,0]) {
rotate([0,90,0]) cylinder(r=15,h=7);
}
}

// more spokes for input pulley
translate([66,0,0]) {
for (x=[0:5])
{
rotate([x*60,0,0]) translate([0,0,0])cube([5,15,3]);
}
}


} // union
} // color



} // camshaft module

camShaftY = -50;
camShaftRotate = $t*360;
camShaftZ = 45;
// Camshaft support blocks
module camShaftSupport()
{
	 difference()
	 {
	union()
	{translate([0,camShaftY,45]) rotate([0,270,0]) clipSleeve();
	 translate([45,camShaftY,45]) rotate([0,270,0]) clipSleeve();
	 	translate([-5,-30-3,22.5+3]) rotate([45,0,0]) squareBarZ(22);
	 	translate([40,-30,22.5]) rotate([45,0,0]) squareBarZ(26);
	 	translate([-5,camShaftY-1,45-2.5-1]) rotate([135,0,0]) squareBarZ(26);
	 	translate([40,camShaftY-1,45-2.5-1]) rotate([135,0,0]) squareBarZ(26);
	 }
	 translate([-6,camShaftY,45]) rotate([0,90,0]) cylinder(r=2.5,h=100);

	 // Have to re-punch holes for axle blocks! boo!
	 translate([-6,camShaftY-2.5-1.25,45-3]) rotate([0,90,0]) cylinder(r=1,h=100);
	 translate([-6,camShaftY+2.5+1.25,45-3]) rotate([0,90,0]) cylinder(r=1,h=100);
	 }
}

// A bellcrank to push the machine forwards


module bellCrankBody(crankSize)
{
	union() {
	difference() {
		cylinder(r=crankSize,h=5);
		translate([0,0,-1]) cylinder(r=crankSize-5,h=7);
		translate([-crankSize-1,0,-1]) cube([crankSize*2+2,crankSize*2+2,7]);
	}
	translate([-crankSize+2.5,-2.5,0]) squareBarX(crankSize);
	rotate([0,0,-45]) translate([-2.5,-2.5,0]) squareBarX(crankSize);
	translate([crankSize-5,-2.5,0]) cube([5,2.5,5]);
	translate([15,0,2.5]) rotate([0,90,0]) cylinder(r=1.5,h=10);
	//	translate([20,0,2.5])rotate([0,90,0]) smallBearing();
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



// Align with camshaft in Y direction
crankRotate = lookup($t, [ [0.39,0], [0.4, 30], [0.5,0],[0.51,30],[0.61,0],[1,0] ]);

//sweeperPos = (engage1==1 || engage2==1)?1:0;
sweeperPos = lookup($t, [ [0.0,1], [0.1, 0], [0.9,0], [1,1] ]);
//sweeperPos = 0;
// Attach a punt to the camshaft

module clevis()
{
	difference() {
		translate([-25,-5,-2.5]) cube([30,10,5]);
		translate([-15,-3,-3.5]) cube([25,6,7]);
		translate([0,10,0]) rotate([90,0,0]) cylinder(r=1.5,h=20,$fn=20);
		translate([-26,0,0]) rotate([0,90,0]) cylinder(r=1.5,h=9,$fn=20);
		}
}

crankPushX = 17.5*sin(crankRotate);
//$t = 0.40;
echo("Movement= ",crankPushX);
echo("$t=",$t);
wheels();
data();
translate([ -10,-30,18]) raiser(); 
grid();

translate([-10+2.5,camShaftY+2.5,21]) rotate([0,crankRotate,0]) bellCrank();
translate([-10+2.5-crankPushX,camShaftY ,7.5]) clevis();
body();
translate([0,sweeperPos*gridSpacing*2-18,-5]) sweeper();
translate([leverAxisX,leverAxisY,35]) rotate([0,0,10*(1-engage1)]) lever();
translate([leverAxisX,leverAxisY+10,40]) rotate([0,0,10*(1-engage2)]) lever2();
translate([0,0,ballTopZ*(1-bit2)]) feeler1();
translate([gridSpacing*2,0,ballTopZ*(1-bit1)]) feeler2(); 
translate([gridSpacing*4,0,ballTopZ*(1-bit0)]) feeler2();
camShaftRotate = 360*$t;
translate([-10,camShaftY,45]) rotate([camShaftRotate,0,0])camshaft();


//clipSleeve();

//translate([20,0,0]) clipSleeveA();
