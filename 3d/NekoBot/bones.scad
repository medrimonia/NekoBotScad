include <../models/ollo.scad>

motorWidth = 24;
motorHeight = 36;
motorDepth = 24;
motorArmToArm = motorDepth + OlloWidth * 2;
motorSide2SideFixation = 18;
fixationWidth = 30;
fixationClearance = 30;

depth = 2.2;

boneIntWidth = motorArmToArm;
boneExtWidth = boneIntWidth + 2 * depth;
boneIntDepth = motorDepth;
boneExtDepth = boneIntDepth + 2 * depth;

boneSideFixMargin = OlloSpacing;
boneArmFixMargin = OlloSpacing * 2;

//boneTotalLength - axis2axis = boneTotalMargin
boneTotalMargin = boneSideFixMargin + boneArmFixMargin;

module boneMainStructure(boneLength){
    cube([boneExtWidth, boneExtDepth, boneLength + boneTotalMargin], true);
}

module boneArmFixHole(boneLength){
    translate([0,0, (boneLength + boneTotalMargin) / 2 - boneArmFixMargin]){
        //Clear the above the axis
        translate([0,0, boneArmFixMargin / 2]){
            cube([boneIntWidth, boneExtDepth, boneArmFixMargin], true);
        }
        rotate([0, 90,0]) servoArm(boneExtWidth / 2);
        rotate([0,-90,0]) servoArm(boneExtWidth / 2);
    }
}

module boneSideFixHole(boneLength){
    translate([0,0, -(boneLength + boneTotalMargin) / 2 + boneSideFixMargin]){
        translate([0,0,-boneSideFixMargin / 2]){
            cube([boneExtWidth, boneIntDepth, boneSideFixMargin],true);
        }
        rotate([-90,0,0]) threeOllo(boneExtDepth);
        rotate([ 90,0,0]) threeOllo(boneExtDepth);
        translate([0,0,18]){
            rotate([-90,0,0]) threeOllo(boneExtDepth);
            rotate([ 90,0,0]) threeOllo(boneExtDepth);
        }
    }
}

module bone(boneLength){
    difference(){
        boneMainStructure(boneLength);
        boneArmFixHole(boneLength);
        boneSideFixHole(boneLength);
    }
}