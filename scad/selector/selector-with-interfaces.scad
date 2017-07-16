include <selector.scad>;
use <../interconnect/interconnect.scad>;


module aligned_interconnect()
{
  rotate([0,0,180]) rotate([270,0,0]) interconnect(35);

}

translate([-30,86,20]) aligned_interconnect();
translate([-30,76,15]) aligned_interconnect();
translate([-30,66,20]) aligned_interconnect();
translate([-30,56,15]) aligned_interconnect();
