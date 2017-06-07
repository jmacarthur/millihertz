use <interface.scad>;

for(i=[0:8]) {
  stagger = (i%2==0?-20:-10);
  translate([i*50,0]) lever_2d();
  translate([i*50,50]) output_2d(stagger);
  translate([i*50,100])  hardpoint_2d(stagger);
}

translate([0,150]) frontpanel_2d();
translate([0,210]) back_comb_2d();
translate([0,240]) topplate_2d();
