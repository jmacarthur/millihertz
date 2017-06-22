include <globs.scad>;
use <../selector/selector.scad>;
include <ram.scad>;

for(i=[0:7]) {
 translate([25*i,0]) rowSelect();
 translate([25*i+14,0]) backing();
 }

for(i=[0:7]) {
 translate([0,180+12*i]) rowBar();
}

for(x=[0:7]) {
 translate([206+12*x,0]) ejector();
}

for(y=[1:7]) {
  for(x=[0:7]) {
    translate([200+15*x,y*12]) injector();
  }
 }

translate([360,0]) basePlate();

n_inputs = 3;
travel = 5;
for(s=[0:2]) {
  union() {
    translate([0,280+20*s])
    col_enumerator_rod(s, n_inputs, column_x_spacing, 0, travel, 5);
  }
 }


n_inputs = 3;
travel = 5;
for(s=[0:2]) {
  union() {
    translate([250,280+20*s])
      row_enumerator_rod(s, n_inputs, column_x_spacing, 0, travel, 5);
  }
 }

