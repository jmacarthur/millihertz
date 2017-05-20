include <ram.scad>

activated_column = 2;
activated_row = 1;

column_x_spacing = 25;
inject = true;
eject = false;

balls = true;

for(i=[0:cols-1]) {
  translate([i*column_x_spacing,(i==activated_column?-7:0),0]) 
    linear_extrude(height=3) {
    rowSelect();
  }

  translate([-11+i*column_x_spacing,0,0]) linear_extrude(height=3) {
    backing();
  }
 }


module rowControl()
{
  for(i=[0:cols-1]) {
    color([0.0,0.5,0])
      translate([-13+i*column_x_spacing,0,0])
      linear_extrude(height=3) {
      ejector();
    }
  }
  
  for(i=[0:cols-1]) {
    color([0.0,0.5,0])
      translate([-11+17+i*column_x_spacing,0,0])
      linear_extrude(height=3) {
      injector();
    }
  }
    
  color([0.5,0.5,0.5,0.5])
    translate([-20,0,3])
    linear_extrude(height=3) {
    rowBar();
  }
}


for(i=[0:rows-1]) {
  active = (activated_row==i?1:0);
  movement = (eject?6:0) + (inject?-6:0);
  translate([active*movement,20*i+6,3]) rowControl();
}

if(balls) {
  for(x=[0:rows-1]) {
    for(y=[0:cols-1]) {
      translate([column_x_spacing*x-4.5, 20*y+8,2.5]) sphere(d=5, $fn=20);
    }
  }
}
