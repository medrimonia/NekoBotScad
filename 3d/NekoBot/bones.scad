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

boneArmFixHeight = motorHeight;
boneSideFixHeight = motorHeight;

//from the center of the rotation axis
module boneArmFixStructure1Side(){
    translate([motorArmToArm / 2, 0, 0]){
        rotate([0,90,0]){
            cylinder(depth,boneArmFixWidth / 2, boneArmFixWidth / 2);
        }
        translate([0, -boneArmFixWidth / 2, 0]){
            cube([depth, boneArmFixWidth, boneArmFixHeight]);
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
        cube([depth, boneSideFixWidth, boneSideFixHeight]);
        mirror([0,0,1])cube([depth, boneSideFixWidth, boneSideFixMargin]);
    }
}

module boneSideFixStructure(){
    boneSideFixStructure1Side();
    mirror(){
        boneSideFixStructure1Side();
    }
}

module boneArmFix2SideX(dz){
    polyhedron(
        [
            [ boneExtWidth/2            ,  boneArmFixWidth/2, 0],
            [ boneIntWidth/2            ,  boneArmFixWidth/2, 0],
            [ boneIntWidth/2            , -boneArmFixWidth/2, 0],
            [ boneExtWidth/2            , -boneArmFixWidth/2, 0],
            [ boneSideFixWidth/2        ,  boneExtDepth/ 2  ,dz],
            [ boneSideFixWidth/2 - depth,  boneExtDepth/ 2  ,dz],
            [ boneSideFixWidth/2 - depth, -boneExtDepth/ 2  ,dz],
            [ boneSideFixWidth/2        , -boneExtDepth/ 2  ,dz],
        ],
        [
            [0,1,2],
            [0,2,3],
            [1,0,4],
            [1,4,5],
            [0,3,4],
            [4,3,7],
            [3,2,6],
            [6,7,3],
            [2,1,5],
            [2,5,6],
            [4,6,5],
            [4,7,6]
        ]);
}

module boneArmFix2Side(boneLength){
    dz = boneLength - boneSideFixHeight - boneArmFixHeight;
    // translating to the middle of the intersection
    translate([0, 0, boneArmFixHeight]){
        boneArmFix2SideX(dz);
        mirror() boneArmFix2SideX(dz);
    }
}

module boneMainStructure(boneLength){
    boneArmFixStructure();
    translate([0,0,boneLength]) rotate([180,0,90]){
        boneSideFixStructure();
    }
    boneArmFix2Side(boneLength);
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