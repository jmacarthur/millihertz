include <params.scad>

// The goal of the reducer pulley system is to reduce speed massively.

// The Mamod SP1 has an output diameter of 7mm. 
// In the Mk1, this ran to a pulley of size around 120mm diameter,
// which then fed a 44:1 worm drive. This gives a 754:1 reduction.

// We will probably be driving a 40 tooth 6mm chain sprocket from a 10 
// tooth. We then have a race of 20:60 pulley reductions. If we drive one 
// 60mm pulley from the engine, we have a reduction of 34.3 already. We need
// another 22x. That is 3*3*2.5,i.e. 2 20-60 pulleys and one 20-50.

module pulley()
{
	difference() {
		union() {
		
                  cylinder(r=40,h=5);
		translate([0,0,-15]) {
		cylinder(r=5,h=20);
		}
		}

		translate([0,0,-20]) 
		cylinder(r=2.5,h=50);
}
}

pulley1Z = 53;

module reducerPulley(ypos) 
{
	translate([90,ypos,pulley1Z]) {
		rotate([0,90,0])
		pulley();
		}

	translate([95,ypos+120,pulley1Z]) {
		rotate([0,90,0])
		pulley();
		}

	translate([0,ypos,pulley1Z]) {
	rotate([0,90,0]) 
	color([0.5,0.5,0.5])
	cylinder(r=2.5,h=150);
	}
}


// Technobots order no 4602-055; takes 4mm shaft
module pulleyT(pr)
{
  rotate([0,90,0])
    union() {
    color([1,0,0])cylinder(r=pr/2,h=5);
  translate([0,0,5])
    color([1,0.5,0]) cylinder(r=5,h=5);
  }
}

module sprocketT(pr)
{
  rotate([0,90,0])
    union() {
    color([0.5,0.5,0.5])cylinder(r=pr/2,h=5);
  }
}


blockAxleHeight = 70;
blockStartY = 95;
blockSeparation = 10;

translate([blockStartY,350,blockAxleHeight]) pulleyT(60);
translate([blockStartY+blockSeparation,350,blockAxleHeight]) pulleyT(20);
translate([blockStartY+blockSeparation,400,blockAxleHeight]) pulleyT(60);
translate([blockStartY+blockSeparation*2,350,blockAxleHeight]) pulleyT(60);
translate([blockStartY+blockSeparation*2,400,blockAxleHeight]) pulleyT(20);
translate([blockStartY+blockSeparation*3,350,blockAxleHeight]) pulleyT(20);
translate([blockStartY+blockSeparation*3,400,blockAxleHeight]) pulleyT(60);
translate([blockStartY+blockSeparation*3+25,400,blockAxleHeight]) sprocketT(20); // default 6mm bore
