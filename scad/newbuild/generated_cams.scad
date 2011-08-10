module moverCam() { 
difference () { 
union () { 
linear_extrude (height=6) scale([-1,1]) polygon( points=[[47.00000,0.00000],[45.88030,4.01401],[44.42577,7.83346],[42.66172,11.43117],[40.61560,14.78287],[38.31668,17.86736],[35.79572,20.66667],[33.08464,23.16611],[30.21620,25.35440],[27.22361,27.22361],[24.14025,28.76922],[20.99927,29.99007],[17.83333,30.88824],[14.67425,31.46902],[11.55268,31.74073],[8.49789,31.71456],[5.53745,31.40443],[2.69699,30.82669],[0.00000,30.00000],[-2.61467,29.88584],[-5.20945,29.54423],[-7.76457,28.97777],[-10.26060,28.19078],[-12.67855,27.18923],[-15.00000,25.98076],[-17.20729,24.57456],[-19.28363,22.98133],[-21.21320,21.21320],[-22.98133,19.28363],[-24.57456,17.20729],[-25.98076,15.00000],[-27.18923,12.67855],[-28.19078,10.26060],[-28.97777,7.76457],[-29.54423,5.20945],[-29.88584,2.61467],[-30.00000,0.00000],[-32.37633,-2.83256],[-34.46827,-6.07769],[-36.22222,-9.70571],[-37.58770,-13.68081],[-36.46378,-17.00334],[-35.04516,-20.23333],[-33.33949,-23.34456],[-31.35675,-26.31144],[-29.10923,-29.10923],[-26.61141,-31.71424],[-23.87990,-34.10403],[-20.93333,-36.25760],[-17.79223,-38.15556],[-14.47885,-39.78032],[-11.01706,-41.11624],[-7.43214,-42.14977],[-3.75060,-42.86958],[-0.00000,-43.26667],[3.79127,-43.33447],[7.59421,-43.06893],[11.37941,-42.46854],[15.11729,-41.53441],[18.77834,-40.27028],[22.33333,-38.68247],[25.75358,-36.77993],[29.01115,-34.57414],[32.07908,-32.07908],[34.93163,-29.31112],[37.54447,-26.28892],[39.89490,-23.03333],[41.96205,-19.56723],[43.72703,-15.91534],[45.17313,-12.10410],[46.28596,-8.16146],[46.82115,-4.09632],], 
paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71, 0]] );
cylinder(r=5,h=10);
}
}
}
module lifterCam() { 
difference () { 
union () { 
linear_extrude (height=6) scale([-1,1]) polygon( points=[[42.00000,0.00000],[41.84018,3.66054],[41.36193,7.29322],[40.56888,10.87040],[39.46709,14.36485],[38.06493,17.74997],[36.37307,21.00000],[34.40439,24.09021],[32.17387,26.99708],[29.69848,29.69848],[26.99708,32.17387],[24.09021,34.40439],[21.00000,36.37307],[17.74997,38.06493],[14.36485,39.46709],[10.87040,40.56888],[7.29322,41.36193],[3.66054,41.84018],[0.00000,42.00000],[-3.66054,41.84018],[-7.29322,41.36193],[-10.87040,40.56888],[-14.36485,39.46709],[-17.74997,38.06493],[-21.00000,36.37307],[-24.09021,34.40439],[-26.99708,32.17387],[-29.69848,29.69848],[-32.17387,26.99708],[-34.40439,24.09021],[-36.37307,21.00000],[-38.06493,17.74997],[-39.46709,14.36485],[-40.56888,10.87040],[-41.36193,7.29322],[-41.84018,3.66054],[-53.00000,0.00000],[-52.79832,-4.61925],[-52.19481,-9.20335],[-51.19407,-13.71741],[-49.80371,-18.12707],[-48.03431,-22.39877],[-45.89935,-26.50000],[-43.41506,-30.39955],[-40.60036,-34.06774],[-37.47666,-37.47666],[-34.06774,-40.60036],[-30.39955,-43.41506],[-26.50000,-45.89935],[-22.39877,-48.03431],[-18.12707,-49.80371],[-13.71741,-51.19407],[-9.20335,-52.19481],[-4.61925,-52.79832],[-0.00000,-53.00000],[4.61925,-52.79832],[9.20335,-52.19481],[13.71741,-51.19407],[18.12707,-49.80371],[22.39877,-48.03431],[26.50000,-45.89935],[30.39955,-43.41506],[34.06774,-40.60036],[37.47666,-37.47666],[40.60036,-34.06774],[43.41506,-30.39955],[45.89935,-26.50000],[48.03431,-22.39877],[49.80371,-18.12707],[51.19407,-13.71741],[52.19481,-9.20335],[52.79832,-4.61925],], 
paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71, 0]] );
cylinder(r=5,h=10);
}
}
}
module resetCam() { 
difference () { 
union () { 
linear_extrude (height=6) scale([-1,1]) polygon( points=[[42.00000,0.00000],[41.84018,3.66054],[41.36193,7.29322],[40.56888,10.87040],[39.46709,14.36485],[38.06493,17.74997],[36.37307,21.00000],[34.40439,24.09021],[32.17387,26.99708],[29.69848,29.69848],[26.99708,32.17387],[24.09021,34.40439],[21.00000,36.37307],[17.74997,38.06493],[14.36485,39.46709],[10.87040,40.56888],[7.29322,41.36193],[3.66054,41.84018],[0.00000,42.00000],[-3.66054,41.84018],[-7.29322,41.36193],[-10.87040,40.56888],[-14.36485,39.46709],[-17.74997,38.06493],[-21.00000,36.37307],[-24.09021,34.40439],[-26.99708,32.17387],[-29.69848,29.69848],[-32.17387,26.99708],[-34.40439,24.09021],[-36.37307,21.00000],[-38.06493,17.74997],[-39.46709,14.36485],[-40.56888,10.87040],[-41.36193,7.29322],[-41.84018,3.66054],[-42.00000,0.00000],[-41.84018,-3.66054],[-41.36193,-7.29322],[-40.56888,-10.87040],[-39.46709,-14.36485],[-38.06493,-17.74997],[-36.37307,-21.00000],[-34.40439,-24.09021],[-32.17387,-26.99708],[-29.69848,-29.69848],[-26.99708,-32.17387],[-24.09021,-34.40439],[-21.00000,-36.37307],[-17.74997,-38.06493],[-14.36485,-39.46709],[-10.87040,-40.56888],[-7.29322,-41.36193],[-3.66054,-41.84018],[-0.00000,-42.00000],[3.66054,-41.84018],[7.29322,-41.36193],[10.87040,-40.56888],[14.36485,-39.46709],[17.74997,-38.06493],[21.00000,-36.37307],[24.09021,-34.40439],[26.99708,-32.17387],[29.69848,-29.69848],[32.17387,-26.99708],[34.40439,-24.09021],[45.03332,-26.00000],[47.12800,-21.97615],[48.86402,-17.78505],[50.22814,-13.45859],[51.21000,-9.02971],[51.80212,-4.53210],], 
paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71, 0]] );
cylinder(r=5,h=10);
}
}
}
