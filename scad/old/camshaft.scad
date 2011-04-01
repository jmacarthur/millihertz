include <params.scad>
include <mover.scad>
include <movercam.scad>

echo("The cam radius is ",camRadius," at this point");

module supportPlate()
{
	difference() {
	union() {
		translate([20,0,25]) cube([10,5,10]);
	        translate([-15,0,95])
	      	       cube([30,5,10]);
	       translate([-20,0,-50])
	       hollowBar(155);
	       translate([15,0,-50])
	       hollowBar(155);

	       }
	       translate([-10,-1,100])
	       rotate([270,0,0])
	       cylinder(r=2.5,h=10);
	       translate([10,-1,100])
	       rotate([270,0,0])
	       cylinder(r=2.5,h=10);
	       translate([25,-1,30])
	       rotate([270,0,0])
	       cylinder(r=2.5,h=10);
	       }
}

module camshaft() 
       {
       union() {
       	       // Main axle

	       translate([camX,-25,camZ])
	       color([0.5,0.5,0.5])
              rotate([270,0,0])
	      cylinder(h=125,r=2.5);

	      // Cam 1 - direction reset
	      translate([camX,-25,camZ])
	      rotate([270,0,0])
	      union() {
	      	      cylinder(h=5,r=10);
		      cube([10,10,5]);
		      }

	      // Cam 2 - massive thing that runs mover
	      translate([camX,pushRodY-5,camZ])
	      rotate([270,0,0])
	      rotate([0,0,30])
	      moverCam();

	      // Cam 3... runs raiser
	      translate([camX,40,camZ])
	      rotate([270,0,0])
	      rotate([0,0,90])
	      translate([0,10,0])
	      cylinder(h=5,r=30);

       }


       translate([-25+camX,0,camZ-30]) supportPlate();
       translate([-25+camX,railSeparation-5,camZ-30]) supportPlate();       


       // Swing bar axle
       color([0.7,0.7,0.5])
       translate([camX-35,-40,camZ+70])
       rotate([270,0,0])
       cylinder(h=150,r=2.5);


       // Follower arms
       translate([camX-40,-35,camZ+30])
       cube([10,5,50]);
       translate([camX-40,40,camZ-30])
       cube([10,5,110]);
       translate([camX-40,95,camZ+30])
       cube([10,5,50]);


       // Second swing bar axle
       color([0.6,0.6,0.5])
       translate([camX-15,-40,camZ+70])
       rotate([270,0,0])
       cylinder(h=150,r=2.5);

       // Dir-reset bar
       translate([camX-20,-25,camZ-55])
       cube([10,5,135]);

       // input wheel!
       color([0,1,0])
       {
       translate([camX,-10,camZ])
       rotate([270,0,0])
       cylinder(r=20,h=5);
       }
       
}