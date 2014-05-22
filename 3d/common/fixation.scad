include <../models/screw.scad>

module rectangularFixation(dx, dy, side = "screw", totalDepth, depth){
    translate([ dx, dy,0]){
        screwDeepHole(totalDepth, depth, side);
    }
    translate([ dx,-dy,0]){
        screwDeepHole(totalDepth, depth, side);
    }
    translate([-dx, dy,0]){
        screwDeepHole(totalDepth, depth, side);
    }
    translate([-dx,-dy,0]){
        screwDeepHole(totalDepth, depth, side);
    }
}