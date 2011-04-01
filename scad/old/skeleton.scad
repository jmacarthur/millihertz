include <params.scad>
include <camshaft.scad>
include <mover.scad>

union() {
translate([-25+camX,0,camZ-30]) supportPlate();
translate([-25+camX,railSeparation-5,camZ-30]) supportPlate();
translate([0,0,0]) scaffold();
}