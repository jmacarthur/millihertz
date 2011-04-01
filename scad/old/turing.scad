//Turing Machine file by Jim MacArthur
// fake maze

<maze.scad>

<params.scad>


//Notes on mazes
//  The raiser bar will stlll clear this larger block.


module fakemaze() { // fake!
cube(size=[mazeSizeX,110,30]);
}

module rails() {
 color([0.5,0.5,0.5]) {
		     cube(size=[500,railWidth,railWidth], center = false);
		     translate([0,railSeparation+railWidth,0])
		     {
		     	cube(size=[500,railWidth,railWidth], center = false);
			}
}
}



// Axles hang 0.5mm away from the main chassis, to make room for a sleeve bearing
module axle(x) {
translate([x,0,0]) {
translate([0,0,-2.0]) {
rotate([90,0,0]) { cylinder(h=3,r=wheelRadius); }
}
translate([0,115+3,-2.0]) {rotate([90,0,0]) { cylinder(h=3,r=wheelRadius); }}
translate([0,-5,-2.0]) { rotate([270,0,0]) { cylinder(h=railSeparation+railWidth*2+3+10,r=wheelAxleRadius); }}
}
}

module axles() {
axle(axle1X);
axle(axle2X);
axle(axle3X);
}
// The Ground
/*
translate([-500,-500,-37/2-1.5-1])
{
	color([0,0,0.5]){
	cube([1000,1000,1]);
}
}
*/

