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
boneArmFixMargin = OlloSpacing;

//boneTotalLength - axis2axis = boneTotalMargin
boneTotalMargin = boneSideFixMargin + boneArmFixMargin;

boneArmFixWidth  = 2 * (OlloSpacing + boneArmFixMargin);
boneSideFixWidth = 2 * (OlloSpacing + boneSideFixMargin);

//from the center of the rotation axis
module boneArmFixStructure1Side(){
    translate([motorArmToArm / 2, 0, 0]){
        rotate([0,90,0]){
            cylinder(depth,boneArmFixWidth / 2, boneArmFixWidth / 2);
        }
        translate([0, -boneArmFixWidth / 2, 0]){
            cube([depth, boneArmFixWidth, motorHeight]);
        }
    }
}

module boneArmFixStructure(){
    boneArmFixStructure1Side();
    mirror(){
        boneArmFixStructure1Side();
    }
}

module boneSideFixStructure1Side(){
    translate([motorWidth/2,-boneSideFixWidth / 2,0]){
        cube([depth, boneSideFixWidth, motorHeight]);
        mirror([0,0,1])cube([depth, boneSideFixWidth, boneSideFixMargin]);
    }
}

module boneSideFixStructure(){
    boneSideFixStructure1Side();
    mirror(){
        boneSideFixStructure1Side();
    }
}

module boneMainStructure(boneLength){
    boneArmFixStructure();
    translate([0,0,boneLength]) rotate([180,0,90]){
        boneSideFixStructure();
    }
}


module boneArmFixHole(){
    translate([boneExtWidth / 2, 0, 0]){
        rotate([0,-90,0]){
            servoArm(boneExtWidth);
        }
    }
}

module boneSideFixHole(boneLength){
    translate([boneExtDepth / 2,0,0]){
        rotate([90, 0, -90]) threeOllo(boneExtDepth);
        translate([0,0,-motorSide2SideFixation]){
            rotate([90,0,-90]) threeOllo(boneExtDepth);
        }
    }
}

// The origin is the center of the fixation on the servoArm side
module bone(boneLength){
    difference(){
        boneMainStructure(boneLength);
        boneArmFixHole(boneLength);
        translate([0,0,boneLength]) rotate([0,0,90]){
            boneSideFixHole(boneLength);
        }
    }
}