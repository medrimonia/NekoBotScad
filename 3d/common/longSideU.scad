include <../models/motor.scad>
use <fixation.scad>

minLongSideULength = 35;

depth = 2.2;

module longSideUStruct(length){
    margin = 2 * OlloSpacing;
    translate([-MotorDepth / 2, -(MotorWidth/2 + depth), 0]){
        difference(){
            cube([MotorDepth, MotorWidth + 2 * depth, length + margin]);
            translate([0,depth,depth]){
                cube([MotorDepth, MotorWidth, length + margin - 2 * depth]);
            }
        }
    }
}

module longSideUServoFixHoles(length){
    translate([0,MotorWidth/2 + depth,length]){
        rotate([90,0,0]){
            threeOllo(MotorWidth + 2 * depth);
            translate([0,-18,0]){
                threeOllo(MotorWidth + 2 * depth);
            }
        }
    }
}

module longSideUFixHoles(){
    fixMargin = OlloSpacing;
    dx = MotorWidth / 2 - fixMargin;
    dy = MotorDepth / 2 - fixMargin;
    rectangularFixation(dx, dy, "bolt", 2 * depth, depth);
}

module longSideU(length = minLongSideULength){
    difference(){
        longSideUStruct(length);
        longSideUServoFixHoles(length);
        longSideUFixHoles();
    }
}