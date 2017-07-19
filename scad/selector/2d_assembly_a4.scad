use <selector.scad>;
use <../interconnect/interconnect.scad>;
n_inputs = 4;
follower_spacing = 10;

// A4 Page as a guide


/*translate([0,0,-5]) color([0.1,0.1,0.1,0.1]) square(size=[297,210]);
translate([297+50,0,-5]) color([0.1,0.1,0.1,0.1]) square(size=[297,210]);
translate([0,210+50,-5]) color([0.1,0.1,0.1,0.1]) square(size=[297,210]);
translate([297+50,210+50,-5]) color([0.1,0.1,0.1,0.1]) square(size=[297,210]);
*/
margin = 5;

// Page 1 - enumerators and end plates
translate([margin, margin]) output_lifter_bar_2d();
translate([margin,40]) xBar_2d(15,25,50,false);
translate([margin,95]) xBar_2d(5,20,50,false);

translate([margin,150]) xBar_2d(5,20,50,true);

translate([margin-5,200]) outputComb_2d();
for(i=[0:n_inputs-1]) translate([210+i*25,margin]) rotate(90)enumerator_rod(i, n_inputs, follower_spacing, 0, 5, 10);

// Page 2 - all the cranks
translate([297+80,30]) {
  for(i=[0:29]) translate([margin+40+(i%6)*47,margin+39*floor(i/6)]) {
      translate([-115*(i%2),-15*(i%2)])
	rotate(180*(i%2))
	crank_2d(i);
    }

  // Two extra ones on the end
  for(i=[30:31]) translate([margin+250,margin+40]) {
      translate([25*(i%2),-70*(i%2)])
	rotate(90)
	rotate(180*(i%2))
	crank_2d(i);
    }
}

// Page 3 - other things

translate([margin+240,330+margin]) rotate(90) yComb_2d();
translate([margin+240,260+margin]) rotate(90) yComb_2d();

translate([margin+50,260+margin]) rotate(90) inner_end_plate_2d();
translate([margin+190,260+margin]) rotate(90) outer_end_plate_2d();
translate([margin+110,260+margin]) rotate(90) front_panel_2d();

translate([margin+280,260+margin]) rotate(90) lifter_bar_2d();

translate([margin+125,425]) front_lifter_lever_2d();
translate([margin+125,440]) front_lifter_lever_2d();

translate([margin+5,435+margin]) rotate(-30) back_lifter_lever_2d();
translate([margin+110,440+margin]) rotate(150) back_lifter_lever_2d();

translate([margin+265,margin+260]) rotate(90) output_lifter_bar_2d();

// Page 4 - all follower rods
for(x=[0:18]) {
  for(y=[0:1]) {
    translate([margin+355+15*x, 350+margin+y*95]) rotate(90) lever_2d();
  }
 }

// Output bars

for(i=[0:4]) {
  translate([margin, 500+30*i]) output_sum_bar(0);
}

// Output things

translate([margin+700,0]) output_rail_2d();
translate([margin+700,50]) pivot_2d();

// Drive plate

translate([margin+700,100]) drive_plate_2d();
translate([margin+700,180]) drive_lever_2d();

// stator

translate([margin+700,250]) dual_stator_2d();


// "Hardpoints" for output
for(i=[0:4]) {
  stagger = 0;
  extend = (i==3 ? 10: i==4?-5:0);
  translate([700,300+i*50])  output_mounting_bracket(0, extend);
}

// "Hardpoints" for input
for(i=[0:4]) {
  stagger = 0;
  translate([780,300+i*50]) output_mounting_bracket(0,0);
}

