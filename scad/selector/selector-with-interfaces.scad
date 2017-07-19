include <selector.scad>;
use <../interconnect/interconnect.scad>;


module aligned_input_interconnect()
{
  rotate([0,0,180]) rotate([270,0,0]) interconnect(35);

}

module aligned_output_interconnect()
{
  rotate([0,0,180]) rotate([270,0,0]) basic_interconnect(35);
}



// Inputs
translate([-30,86,15]) aligned_input_interconnect();
translate([-30,76,15]) aligned_input_interconnect();
translate([-30,66,15]) aligned_input_interconnect();
translate([-30,56,15]) aligned_input_interconnect();

// Outputs
for(i=[0:4]) {
  translate([-30.5,-39+9*i,5]) aligned_output_interconnect();
 }
