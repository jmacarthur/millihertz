include <params.scad>

engineAxleY = 107;
boilerRadius=45/2;

boilerCentreX = 60;

module engine(ypos) 
{

	// Boiler
	color([0.8,0.6,0])	
	translate([boilerCentreX,ypos,66])
	rotate([270,0,0]) cylinder(r=boilerRadius,h=114);

	color([1,1,1]) 
	translate([boilerCentreX-boilerRadius-5,ypos+5,0])
	{
	cube(size=[5,100,66]);
	}

	color([1,1,1]) 
	translate([boilerCentreX+boilerRadius,ypos+5,0])
	{
	cube(size=[5,100,66]);
	}

	// Driveshaft
	color([0.5,0.5,0.5])
	translate([boilerCentreX-30,ypos+36,engineAxleY]) 
	{				   
		rotate([0,90,0]) cylinder(r=2.5,h=65);
	}
			 
	 // Flywheel
	 color([1,0,0])
	 union()
 	 {
	 	 translate([boilerCentreX+20,ypos+36,engineAxleY]) 
	 	 {
		 	 rotate([0,90,0]) 
	 		  cylinder(r=6,h=19);
	         }				
		 translate([boilerCentreX+20,ypos+36,engineAxleY])
		 {
		 rotate([0,90,0])
		 cylinder(r=31,h=12);
		 }
         }		
		    
		    // Baseplate
	color([1,0,0])
	translate([0,ypos,0]) {
	cube(size=[100,100,2]);
	}
}
