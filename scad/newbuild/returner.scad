include <params.scad>

returnerStart = gridWallWidth+gridHoleSize/2+gridSpacing*5;

returnerLen = 85;
angle = 5;
drop = returnerLen * sin(angle);
clearance = 1;
chassisInternalX = wheelWidth+chassisThickness+gridWallWidth;
reducerHeight = chassisTop - 5- ballBearingHeight - clearance;

module returnerBase()
{
  translate([0,0,ballBearingHeight+clearance]) 
    rotate([angle,0,0]) {
      difference() 
      {
        cube(size=[chassisInternalSpacing,returnerLen,3]);
        for(x=[-2:2]) {
          translate([row1x+gridSpacing*2*x,-1,-1])
          cube(size=[5,returnerLen-1-10,3+2]);
        }
      }
   }
}

module returnerSide()
{

	trim = 3*cos(angle)-cutWidth/2;
	translate([0,0,ballBearingHeight+clearance])
  rotate([90,0,90])
  linear_extrude(height=3) {
  polygon(points=[[0,reducerHeight],[returnerLen,reducerHeight],[returnerLen,drop+trim],[0,0+trim]],paths=[[0,1,2,3]]);
  }

}




module returner()
{
	translate([chassisInternalX,0,0]) {
		returnerBase();
		returnerSide();
		translate([chassisInternalSpacing-3,0,0])
		returnerSide();
	}
}