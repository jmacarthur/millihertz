use <selector.scad>;

output_lifter_bar_2d();

translate([0,50]) xBar_2d(5,20,50,false);
translate([0,110]) xBar_2d(5,20,50,false);
translate([0,170]) xBar_2d(15,20,30,true);
translate([0,200]) outputComb_2d();
translate([0,240]) yComb_2d();
translate([80,240]) yComb_2d();

for(i=[0:31]) translate([i*60,350]) crank_2d(i);

translate([0,380]) inner_end_plate_2d();
translate([200,380]) inner_end_plate_2d();
translate([0,440]) outer_end_plate_2d();
translate([200,440]) outer_end_plate_2d();

translate([0,500]) lifter_bar_2d();

translate([0,520]) front_lifter_lever_2d();
translate([50,520]) front_lifter_lever_2d();
translate([0,540]) back_lifter_lever_2d();
translate([50,540]) back_lifter_lever_2d();
translate([0,600]) output_lifter_bar_2d();
for(i=[0:4]) translate([0,630+i*30]) enumerator_rod(i);

