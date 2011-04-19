// The maze starts 30mm away from the front of the chassis bars. 
// It is 97mm long, 114mm wide and 115mm wide at the rear point.
// There are locator bars underneath which locate it centrally within the chassis bars (95mm apart).

// The block is 30mm high. It also has holes in it to support the raiser.

// Turing machine 1 has extra cheeks attached; these are 6mm thick and are on the short sides; that is the ones 97mm long.

// Holes: 76.5mm from front; 13mm from base on both sides.

module maze()
{
	difference()
	{
		cube (size=[mazeWidth,97,30]);
		translate([-1,76.5,13]) rotate([0,90,0]) cylinder(r=2.5,h=21);
		translate([mazeWidth-20+1,76.5,13]) rotate([0,90,0])cylinder(r=2.5,h=21);
		}
}