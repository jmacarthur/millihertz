include <ram.scad>
use <../selector/selector.scad>

activated_column = 2;
activated_row = 1;

column_x_spacing = 25;
inject = false;
eject = true;

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
    translate([-20,3+1.5,3])
    rotate([90,0,0])
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


for(side=[0,1])
translate([-22+221*side,0,-5])
rotate([0,0,90])
rotate([90,0,0])
linear_extrude(height=3) {
  yAxisComb();
}

// Objects from the selector (3D)
// Enumeration rods
follower_spacing = 20;
n_inputs = 3;
input_data = [ 1, 1, 0 ];


for(side = [0,1]) {
  translate([20+260*side,-10,-10])
    rotate([0,0,90])
    for(s=[0:2]) {
      translate([-15+input_data[s]*10,53+10*s,0])
	rotate([90,0,0]) linear_extrude(height=3) {
	enumerator_rod(s, n_inputs, follower_spacing);
      }
    }
 }
