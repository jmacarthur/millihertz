include <params.scad>

raiserWallWidth = 6;
raiserMainHeight = 20;
raiserLength = 90; // From axle to interior of top bar
raiserMinY = -14;
raiserInternalY = 9*2*gridSeparation;

module raiserbody() {
    union() {

      // Two side arms
      // I've had to move the first arm -y a bit to accomodate the 
      // dirflip
     
      translate([0,raiserMinY,-raiserMainHeight/2])
      {
        cube(size=[raiserLength,raiserWallWidth,raiserMainHeight],center=false);
      }

      translate([0,raiserMinY+raiserWallWidth,0]) { rotate([90,0,0]) {cylinder(h=raiserWallWidth,r=raiserMainHeight/2); }}
      translate([0,raiserInternalY+raiserMinY,-raiserMainHeight/2]) 
      {
        cube(size=[raiserLength,raiserWallWidth,raiserMainHeight],center=false);
      }

      translate([0,raiserMinY+raiserInternalY,0]) { rotate([-90,0,0]) {cylinder(h=raiserWallWidth,r=raiserMainHeight/2); }}


      // Top bars
      translate([raiserLength,raiserMinY,-raiserMainHeight/2]) 
      {
        cube(size=[6,railWidth+1+5-raiserMinY,20],center=false);
      }
      translate([raiserLength,railWidth+railSeparation-5-1,-raiserMainHeight/2]) 
      {
        cube(size=[6,raiserInternalY-railWidth-railSeparation+6,20],center=false);
      }

      translate([raiserLength,railWidth+1,-40]) 
      {
        cube(size=[6,5,31],center=false);  
    }
      translate([raiserLength,railWidth+railSeparation-5-1,-40]) 
      {
        cube(size=[6,5,31],center=false);  
    }
      translate([raiserLength,railWidth+1+5,-40]) 
      {
        cube(size=[6,railSeparation-2-10,5],center=false);  
    }

 } // end union
}


module flipbar()
{
      translate([raiserLength,24,-40]) 
      {
	// flip bar 
	color([0.5,0.5,0.5]) {
	  translate([-5,-1,-0.6]) 
          {	       
            cube(size=[16,4.5*15,0.6],center=false);
          }	
	}
	// flip bar hinge
	color([0.5,0.5,0.5]) {
	   
	  translate([-1,-1,1]) 
	  {
	    rotate([270,0,0]){
              cylinder(h=4.5*15,r=1);
	    }
	  }	
	}
}
}

module magnets()
{
      translate([raiserLength,24,-40]) 
      {

        for(x=[0:4])
	{
	        translate([3,-4+gridSeparation+gridSeparation*2*x,-1]) 
		{
			color([0.5,0.5,0.5])
			{
				   // the five magnets
		   	         cylinder(h=3,r=2.5);
			}
         	}
	 }
      }
}

module raiser()
{
  union() {
  difference() {
      raiserbody();
      // Cutout for axle
      translate([0,-20,0]) {
        rotate([-90,0,0]) {
          // Punch holes for axle
          cylinder(h=150,r=2.5);
        }
      }
      if(lightening)
      {
      for(x=[0:3])
      for(y=[0,1])
      {
	translate([15+raiserMainHeight*x,raiserMinY-1 + raiserInternalY*y,0])
	rotate([-90,0,0]) {
	#	cylinder(h=raiserWallWidth+2,r=raiserMainHeight/2-2);
	}
	translate([25+raiserMainHeight*x,raiserMinY-1 + raiserInternalY*y,5])
	rotate([-90,0,0]) {
	#	cylinder(h=raiserWallWidth+2,r=raiserMainHeight/5-2);
	}
	translate([25+raiserMainHeight*x,raiserMinY-1 + raiserInternalY*y,-5])
	rotate([-90,0,0]) {
	#	cylinder(h=raiserWallWidth+2,r=raiserMainHeight/5-2);
	}
	}
      }


    } // end diff
    magnets();
    flipbar();
  } // end union
}
