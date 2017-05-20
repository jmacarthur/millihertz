ballBearingDiameter = 6;

rows = 8;
cols = 8;

module rowSelect()
{
  difference() {
    square(size=[10,20*rows]);
    for(i=[0:rows-1]) {
      translate([0,i*20]) circle(r=6);
      translate([0,i*20+12]) circle(r=6);
      translate([-1,i*20+12]) square(size=[7,8]);
    }
  }
}

module backing()
{
  difference() {
    square(size=[10,20*rows]);
    for(i=[0:rows-1]) {
      translate([10,i*20-1]) circle(r=6);
      translate([4,i*20+5]) polygon(points=[[0,0], [7,1], [7,7], [0,6]]);
    }
  }
}

module ejector()
{
  square(size=[6,6]);
}

module injector()
{
  difference() {
    square(size=[6,6]);
    translate([0,6]) circle(r=6);
  }
}


module rowBar()
{
  square(size=[25*cols+50,6]);
}
