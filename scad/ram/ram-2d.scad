include <globs.scad>;
use <../selector/selector.scad>;
include <ram.scad>;
$fn = 20;

for(i=[0:7]) {
 translate([25*i,0]) rowSelect();
 translate([25*i+14,5]) backing();
 }

for(i=[0:7]) {
 translate([0,185+12*i]) rowBar();
}

for(x=[0:7]) {
 translate([206+12*x,0]) ejector();
}

for(y=[1:7]) {
  for(x=[0:7]) {
    translate([200+15*x,y*12]) injector();
  }
 }

translate([205,100]) rowSelectorComb();
translate([205,125]) rowSelectorComb();
translate([255,100]) colSelectorComb();
translate([255,125]) colSelectorComb();
translate([210,155]) combFeet(8);
translate([250,155]) combFeet(8);

for(y=[0:7]) {
  translate([340,5+20*y]) columnFollower();
}

// Row lifter rods

translate([350,180]) {
  translate([50,-170]) rotate(90) conRod(150);
  translate([0,15]) conRod(30);
  translate([0,30]) crankRod(30,50);
  translate([15,50]) rotate(90) conRod(30);
  translate([30,100]) rotate(180) crankRod(30,50);
}
