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
connector_body_height = 3.5;
connector_total_height = 8; // That varies with compression of the cable
connector_length = 10.5;
peg_spacing = 5.6;
peg_top_diameter = 3.4;
peg_thread_diameter = 2.4;

thin = 0.1;

// Note that 'pushrod connectors' are the usual means of connection
// and usually available from radio control suppliers.

module cable_connector_2d()
{
  union() {
    difference() {
      square([20,20]);
      
      translate([5,5]) {
	square([connector_length, connector_body_height]);
	
	for(side = [-1,1]) {
	  translate([connector_length/2 + side*peg_spacing/2 - peg_thread_diameter/2,0]) square([peg_thread_diameter,connector_total_height]);
	  translate([connector_length/2 + side*peg_spacing/2 - peg_top_diameter/2,connector_total_height-2]) square([peg_top_diameter,2]);
	}

	// exit path for cable
	translate([0,0.5]) square([50,cable_inner_diameter]);
      }
    }
    difference() {
      translate([-20,0]) {
	square([21, 20]);
      }
      translate([-15,5]) {
	circle(d=3);
      }
      translate([-20-thin,10]) {
	square([10+thin,10+thin]);
      }
    }
  }
}


module stator_2d()
{
  union() {
    translate([-20,20]) {
      difference() {
	square([51,30]);
	translate([5,5]) circle(d=3); 
	translate([5,25]) circle(d=3);
	translate([15,25]) circle(d=3);
	translate([15,5]) circle(d=3);
      }
    }
    difference() {
      translate([20+travel,0]) square([40,40]);
      // exit path for cable
      translate([0+travel,5.5]) square([50,cable_inner_diameter]);
      // Outer cable holder
      translate([25+travel,5.5+cable_inner_diameter/2-cable_outer_diameter/2]) square([50,cable_outer_diameter]);
      translate([40,25]) circle(d=3);
    }
    difference() {
      translate([0,-10]) square([40,10]);
      translate([10,-5]) circle(d=3);
      translate([30,-5]) circle(d=3);
    }
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

linear_extrude(height=3) cable_connector_2d();
color([0,1.0,0]) linear_extrude(height=3) stator_2d();
translate([0,0,3]) color([0,0,1.0,0.5]) linear_extrude(height=3) top_plate_2d();
