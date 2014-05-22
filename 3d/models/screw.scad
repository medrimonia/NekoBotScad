use <../util/polygons.scad>

//TODO check size
screwDiameter = 2.5;
screwTrace = 3.5;
boltTrace = 5.2;//Distance from one side to the other

module screwHole(depth){
    cylinder(h=depth * 1.001, d=screwDiameter, $fn=50); 
}

module screwDeepHole(totalDepth, depth, side){
    screwHole(depth);
    translate([0,0,depth]){
        if (side == "screw"){
            cylinder(h=totalDepth-depth, d=screwTrace, $fn=50);
        }
        if (side == "bolt"){
            // Avoiding issues due to precision
            hexagon(boltTrace, (totalDepth-depth) * 1.001);
        }
    }
}