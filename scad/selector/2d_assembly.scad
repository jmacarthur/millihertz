use <selector.scad>;

// A4 Page as a guide
translate([0,0,-5]) color([0.1,0.1,0.1,0.1]) square(size=[297,210]);
translate([297+50,0,-5]) color([0.1,0.1,0.1,0.1]) square(size=[297,210]);
translate([0,210+50,-5]) color([0.1,0.1,0.1,0.1]) square(size=[297,210]);

margin = 5;

// Page 1 - enumerators and end plates
translate([margin, margin]) output_lifter_bar_2d();
translate([margin,40]) xBar_2d(5,20,50,false);
translate([margin,95]) xBar_2d(5,20,50,false);
translate([margin,150]) xBar_2d(15,20,30,true);
translate([margin-5,175]) outputComb_2d();
for(i=[0:3]) translate([210+i*25,margin]) rotate(90)enumerator_rod(i);


// Page 2 - all the cranks
translate([297+80,30]) {
  for(i=[0:29]) translate([margin+40+(i%6)*40,margin+39*floor(i/6)]) {
      translate([-95*(i%2),-15*(i%2)])
	rotate(180*(i%2))
	crank_2d(i);
    }
  
  // Two extra ones on the end
  for(i=[30:31]) translate([margin+230,margin+40]) {
      translate([20*(i%2),-55*(i%2)])
	rotate(90)
	rotate(180*(i%2))
	crank_2d(i);
    }
}

// Page 3 - other things

translate([margin+240,330+margin]) rotate(90) yComb_2d();
translate([margin+240,260+margin]) rotate(90) yComb_2d();

translate([margin+105,260+margin]) rotate(90) inner_end_plate_2d();
translate([margin+50,260+margin]) rotate(90) inner_end_plate_2d();
translate([margin+160,260+margin]) rotate(90) outer_end_plate_2d();
translate([margin+215,260+margin]) rotate(90) outer_end_plate_2d();

translate([margin+280,260+margin]) rotate(90) lifter_bar_2d();

translate([margin+125,425]) front_lifter_lever_2d();
translate([margin+125,440]) front_lifter_lever_2d();

translate([margin+5,435+margin]) rotate(-30) back_lifter_lever_2d();
translate([margin+110,440+margin]) rotate(150) back_lifter_lever_2d();

translate([margin+265,margin+260]) rotate(90) output_lifter_bar_2d();


