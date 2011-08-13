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
	union() {
		cube (size=[mazeWidth,mazeLength,mazeHeight-5]);
		translate([(mazeWidth-chassisInternalSpacing)/2,0,-5])
		    cube (size=[chassisInternalSpacing,mazeLength,mazeHeight]);
		}

		for(x=[0:5]) {
		for(y=[-1:5]) {
		translate([30.9+7.58*2*y,3+7.58*(1+2*x),-10]) cylinder(r=5.5,h=50);		
		}
}
	}
}