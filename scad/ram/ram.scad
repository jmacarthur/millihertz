ballBearingDiameter = 6;

rows = 8;
cols = 8;

module rowSelect()
{
  union() {
    difference() {
      square(size=[10,20*rows+12]);
      for(i=[0:rows]) {
	translate([0,i*20]) circle(r=6);

	if(i != rows) translate([0,i*20+12]) circle(r=6);
	translate([-1,i*20+12]) square(size=[7,8]);
      }
    }
  }
}

module backing()
{
  difference() {
    square(size=[10,20*rows+12]);
    for(i=[0:rows]) {
      translate([10,i*20-1]) circle(r=6);
      if(i!=rows) translate([4,i*20+5]) polygon(points=[[0,0], [7,1], [7,7], [0,6]]);
    }
  }
}

module ejector()
{
  difference() {
    square(size=[6,6]);
    translate([1.5,1.5]) square(size=[3,3]);
  }
}

module injector()
{
  difference() {
    square(size=[12,6]);
    translate([0,6]) circle(r=6);
    translate([6+1.5,1.5]) square(size=[3,3]);
  }
}


module rowBar()
{
  union() {
    square(size=[25*cols+120,6]);
    for(c=[0:cols]) {
      translate([70-1.5+c*25,-3]) square([3,4]);
    }
  }
}

// Y Axis combs

module yAxisComb()
{
  difference() {
    square(size=[200,20]);
    for(r=[0:rows]) {
      translate([r*20+7.5,10]) square(size=[3,11]);
    }
  }
}
