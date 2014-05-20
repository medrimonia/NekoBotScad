include <../models/motor.scad>

minLongSideULength = 30;

depth = 2.2;

module longSideUStruct(length){
    margin = 2 * OlloSpacing;
    translate([-MotorDepth / 2, -(MotorWidth/2 + depth), 0]){
        difference(){
            cube([MotorDepth, MotorWidth + 2 * depth, length + margin]);
            translate([0,depth,depth]){
                cube([MotorDepth, MotorWidth, length + margin - depth]);
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

module longSideU(length = minLongSideULength){
    difference(){
        longSideUStruct(length);
        longSideUServoFixHoles(length);
    }
}