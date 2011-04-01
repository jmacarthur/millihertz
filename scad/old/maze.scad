/* Marble maze SCAD file by Jim MacArthur */

/* Describes a solid cuboid block with sloped channels
   cut into it, allowing ball bearings of <10mm diameter to
   roll down. */

/* (C) Jim MacArthur 2010. */


module channely(x1,y1,z1,x2,y2,z2)
{
	// Makes a channel from x to y, extending upwards to infinity.
	// This is a solid shape, meant to be subtracted.
	// First, ball cuts at the exact corners
	translate([x1,y1,z1]) {
	sphere(r=5);
	}

	translate([x2,y2,z2]) {
	sphere(r=5);
	}

	// cylinder cuts up ( second end only)
	translate([x2,y2,z2]) {
	  cylinder(r=5,h=100,center=false);
	}
	
	// cylinder itself... this gets difficult - we have to rotate to fit
	len = sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1));
	dir = atan((z2-z1)/(y2-y1));
	echo("Calculated angle at ",dir);
	translate([x1,y1,z1]){
	rotate([-90+dir,0,0])
	{
		cylinder(h=len,r=5,center=false);
	}
	}

	// Annoying polyhedron cutout thing
	polyhedron(points = [ [x1-5,y1,z1],
			    [x1+5,y1,z1],
			    [x1-5,y2,z2],
			    [x1+5,y2,z2],
			    [x1-5,y1,z1+100],
			    [x1+5,y1,z1+100],
			    [x1-5,y2,z2+100],
			    [x1+5,y2,z2+100] ],
			    triangles = [ [0,1,2],
			     [1,3,2],
			     [0,4,1],
			     [4,5,1],
			     [6,4,0],
			     [2,6,0],
			     [4,6,5],
			     [5,6,7],
			     [7,6,2],
			     [7,2,3],
			     [1,5,7],
			     [3,1,7] ] );			    
}


module channel(x1,y1,z1,len,z2,dir)
{
    translate([15*x1+7.5,15*y1+7.5,0])
    {
    rotate([0,0,dir]){
        channely(0,0,z1,0,len*15,z2);
	}
    }    

}

module maze() {
difference() {
  difference(){
    cube(size=[15*6,15*7,30],center=false);
    translate([-5,-5,-1]) {
        cube(size=[15*7,15+5,5+1],center=false);
    }
    translate([-5,90,-1]) {
        cube(size=[15*7,15+5,5+1],center=false);
    }

  }
  // Now cut out the 'drop holes'
  for(y=[2:3]) {
  for(x=[1:5]) {
    translate([15*y+7.5,15*x+7.5,25])
    {
      cylinder(h=100, r=5, center=false, $fs=0.1);
      sphere(r=5, center=true);
    }
  }
  }

  // And the output holes

  for(x=[2:4]) {
    translate([15*4+7.5,15*x+7.5,-5])
    {
      cylinder(h=100, r=5, center=false, $fs=0.1);
    }
  }
    translate([15+7.5,15*1+7.5,-5])
    {
      cylinder(h=100, r=5, center=false, $fs=0.1);
    }
    translate([15+7.5,15*5+7.5,-5])
    {
      cylinder(h=100, r=5, center=false, $fs=0.1);
    }
    translate([7.5,15*4+7.5,-5])
    {
      cylinder(h=100, r=5, center=false, $fs=0.1);
    }

    translate([15*2+7.5,15*5+7.5,0])
    {
        channely(0,0,25,0,15,23);
    }

    translate([15*2+7.5,15*6+7.5,0])
    {
    rotate([0,0,-90]){
        channely(0,0,23,0,45,17);
	}
    }
    translate([15*5+7.5,15*6+7.5,0])
    {
    rotate([0,0,180]){
        channely(0,0,17,0,45,11);
	}
    }

    translate([15*5+7.5,15*3+7.5,0])
    {
    rotate([0,0,90]){
        channely(0,0,11,0,15,9);
	}
    }

    channel(3,5,25,1,15,-90);
    channel(4,5,15,1,5,180);

    channel(3,4,25,1,20,90);
    channel(2,4,20,1,15,90);
    channel(1,4,15,1,10,0);
    channel(2,3,25,1,20,90);
    channel(1,3,20,1,15,0);

    channel(3,3,25,1,20,180);
    channel(3,2,20,2,10,90);
    channel(1,2,10,1,5,180);
    channel(3,1,25,1,15,-90);
    channel(4,1,15,1,5,0);

    channel(2,1,25,1,20,180);
    channel(2,0,20,2,15,90);
    channel(0,0,15,4,5,0);

}}

