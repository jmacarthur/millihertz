use <selector.scad>;

output_lifter_bar_2d();

translate([0,50]) xBar_2d(5,20,50,false);
translate([0,150]) xBar_2d(5,20,50,false);
translate([0,220]) xBar_2d(15,20,30,true);
translate([0,250]) outputComb_2d();
translate([0,300]) yComb_2d();
translate([80,300]) yComb_2d();

for(i=[0:31]) translate([i*60,350]) crank_2d(i);

translate([0,400]) inner_end_plate_2d();
translate([200,400]) inner_end_plate_2d();
// TODO: Missing outer_end_plate_2d();
translate([0,500]) lifter_bar_2d();

translate([0,600]) front_lifter_lever_2d();
translate([0,700]) back_lifter_lever_2d();
translate([0,800]) output_lifter_bar_2d();
for(i=[0:4]) translate([0,900+i*30]) enumerator_rod(i);

