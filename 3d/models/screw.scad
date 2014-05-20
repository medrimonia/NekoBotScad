//TODO check
screwDiameter = 2.5;
screwTrace = 3.5;

module screwHole(depth){
    cylinder(h=depth, d=screwDiameter); 
}

module screwDeepHole(totalDepth, depth){
    screwHole(depth);
    translate([0,0,depth]){
        cylinder(h=totalDepth -depth,d=screwTrace);
    }
}