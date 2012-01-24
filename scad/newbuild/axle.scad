// Axles

drawAxleBlocks = false; // No longer necessary; chassis includes them

module axle()
{
	translate([-20,0,axleHeight]) rotate([0,90,0]) cylinder(r=1.5,h=180);
	
	if(drawAxleBlocks) {
	translate([0,-20-axleRadius,axleHeight+axleRadius-axleBlockThickness]) cube([20,20,axleBlockThickness]);
	translate([0,axleRadius,axleHeight+axleRadius-axleBlockThickness]) cube([20,20,axleBlockThickness]);
	translate([chassisInternalSpacing+chassisThickness,-20-axleRadius,axleHeight+axleRadius-axleBlockThickness]) cube([20,20,axleBlockThickness]);
	translate([chassisInternalSpacing+chassisThickness,axleRadius,axleHeight+axleRadius-axleBlockThickness]) cube([20,20,axleBlockThickness]);
	}
}