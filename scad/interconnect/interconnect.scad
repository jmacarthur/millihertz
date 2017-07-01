// Digital Bowden cable interconnect

// This is designed to be parametric, so could be used with any Bowden
// cable. The first application is a very lightweight plastic cable,
// usually called "snake" in radio-control applications, available at
// http://www.rcworld.co.uk/cgi-bin/sh000067.pl?WD=snake&PN=Slec-Snake-Light-Weight-Tube--Inner-Outer-1M-F_SL026A%2ehtml#SID=146
// This has an outer diameter of 3.5mm and internal cable diameter
// 2.0mm.



cable_inner_diameter = 2;
cable_outer_diameter = 3.5;

// Standard interconnect has a travel of 5mm between '0' and '1'.
travel = 5;

// Connector block
// Electrical connector blocks come in 2.5mm internal diameter, which we'll use as our anchors. 


connector_inner_diameter = 2.5;
connector_width = 3.9;
connector_body_height = 4.5;
connector_total_height = 8; // That varies with compression of the cable
connector_length = 10.5;
peg_spacing = 5.6;
peg_top_diameter = 3.4;
peg_thread_diameter = 2.4;
amplification_ratio = 4;
thin = 0.1;
input_travel = 20;

// Note that 'pushrod connectors' are the usual means of connection
// and usually available from radio control suppliers.
$fn = 20;
module cable_connector_2d()
{
  union() {
    difference() {
      square([25,20]);
      translate([11,5]) {
	square([connector_length, connector_body_height]);
	for(side = [-1,1]) {
	  translate([connector_length/2 + side*peg_spacing/2 - peg_thread_diameter/2,0]) square([peg_thread_diameter,connector_total_height]);
	  translate([connector_length/2 + side*peg_spacing/2 - peg_top_diameter/2,connector_total_height-2]) square([peg_top_diameter,2]);
	}

	// exit path for cable
	translate([0,0.5]) square([50,cable_inner_diameter]);
      }

      // Drive hole
      translate([5,10]) circle(d=3);

    }
  }
}

module optimal_stator_2d()
{
  difference() {
    union() {
      translate([-35,-55]) polygon(points=[[5,25],[15,0], [100,0], [100,20], [40,80], [15,80],[5,70]]);
      translate([-27.5,-10]) circle(d=10);
      translate([-27.5,-30]) circle(d=10);
    }

    // A gap for the travel of the cable connector
    translate([-15,-50]) square([25+input_travel,20]);

    // A gap for the output rod
    translate([-35-input_travel/8,5]) square([40+input_travel/4,10]);

    // Gap for the cable output
    translate([0,-50+5.5]) square([50,cable_inner_diameter]);

    // Gap for the cable output
    translate([35,-50+5.5- (cable_outer_diameter-cable_inner_diameter)/2]) square([50,cable_outer_diameter]);

    // Hardpoint holes
    translate([-27.5,-10]) circle(d=3);
    translate([-27.5,-30]) circle(d=3);

    // Axis hole
    translate([0,0]) circle(d=3);

    // Holes to allow binding over the input cable
    translate([50,-35]) circle(d=3);
    translate([50,-50]) circle(d=3);

    // Holes to allow binding over the output cable
    translate([-15,0]) circle(d=3);
    translate([-15,20]) circle(d=3);
  }
}

module dual_stator_2d()
{
  difference() {
    translate([-25,-50]) square([100,100]);
    offset = 30;
    for(input=[-1,1]) {
      scale([1,input]) {
	// A gap for the travel of the cable connector
	translate([-15,-offset]) square([25+input_travel,20]);

	// Gap for the cable output
	translate([0,-offset+5.5]) square([50,cable_inner_diameter]);

	// Gap for the cable output
	translate([35,-offset+5.5-(cable_outer_diameter-cable_inner_diameter)/2]) square([50,cable_outer_diameter]);

	// Holes to allow binding over the input cable
	translate([50,-offset+15]) circle(d=3);
	translate([50,-offset]) circle(d=3);
      }
    }
  }
}



module lever_2d() {
  translate([-5,-45]) { 
    difference() {
      union() {
	square([10,60]);
	translate([5,0]) circle(d=10);
	translate([5,60]) circle(d=10);
      }
      translate([5,5]) circle(d=3);
      translate([5-1.5,0]) square([3,5]);
      translate([5,0]) circle(d=3);

      // Axis hole
      translate([5,45]) circle(d=3);
      
      translate([5,55]) circle(d=3);

      translate([5-1.5,55]) square([3,5]);
      translate([5,60]) circle(d=3);    
    }
  }
}

module drive_rod_2d() {
  difference() {
    square([40,10]);
    translate([5,5]) circle(d=3);
    translate([35,5]) circle(d=3);
  }
}

module top_plate_2d()
{
  translate([-10,-10])
  difference() {
    square([55,40]);
    translate([20,5]) circle(d=3);
    translate([40,5]) circle(d=3);
    translate([5,35]) circle(d=3);
    translate([50,35]) circle(d=3);
    translate([-thin, -thin]) square([10+thin,30+thin]);
  }
}


travel = -10;

rot = atan2(travel, 40);
translate([-5+travel,-50]) linear_extrude(height=3) cable_connector_2d();
color([0,0,1.0]) linear_extrude(height=3) optimal_stator_2d();
//translate([0,0,3]) color([0,0,1.0,0.5]) linear_extrude(height=3) top_plate_2d();
color([1.0,0,0]) translate([0,0,3]) linear_extrude(height=3) rotate(rot) lever_2d();
color([1.0,0,0]) translate([0,0,-3]) linear_extrude(height=3) rotate(rot) lever_2d();
translate([-35-travel/4,5,0]) linear_extrude(height=3) drive_rod_2d();
translate([200,0,0]) color([0,0,1.0]) linear_extrude(height=3) dual_stator_2d();
