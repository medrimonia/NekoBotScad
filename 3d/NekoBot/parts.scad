include <bones.scad>
include <config.scad>
include <../common/longSideU.scad>

footMargin = 20;
footLength = 30;
footThickness = 6;

footFixWidth = boneArmFixWidth;

module footFixationStructure(){
    translate([motorArmToArm / 2, 0, 0]){
        rotate([0,90,0]){
            cylinder(h=depth, r=footFixWidth / 2);
        }
        translate([0, -boneArmFixWidth / 2, 0]){
            cube([depth, boneArmFixWidth, footMargin]);
        }
    }
}

module footFixHoles(){
    translate([motorArmToArm / 2 + depth, 0, 0]){
        rotate([0,-90,0]){
            servoArm(motorArmToArm + 2 * depth);
        }
    }
}

module footFixation(){
    difference(){
        union(){
            footFixationStructure();
            mirror() footFixationStructure();
        }
        footFixHoles();
    }
}

module footBase(){
    translate([0,0,footMargin + footThickness / 2]){
        cube([motorArmToArm + 2 * depth, footFixWidth,footThickness], true);
    }
}

module foot(){
    footFixation();
    footBase();
}

//Bad! No success when trying recursive modules
module leg(angles, length, currentIndex = 0){
	  rotate([90,0,90]){
		    motorArm();
    }
    rotate([angles[0], 0, 0]){
        if (len(angles) == 1){
            foot();
        }
        else{
			      bone(length[0]);
            translate([0,0,length[0]]){
	              rotate([90,0,90]){
		                motorArm();
                }
                rotate([angles[1],0,0]){
                    if (len(angles) == 2){
                        foot();
                    }
                    else{
			                  bone(length[1]);
                        translate([0,0,length[1]]){
	                          rotate([90,0,90]){
		                            motorArm();
                            }
                            rotate([angles[2],0,0]){
                                if (len(angles) == 3){
                                    foot();
                                }
                                else{
                                    bone(length[2]);
                                    translate([0,0,length[2]]){
	                                      rotate([90,0,90]){
		                                        motorArm();
                                        }
                                        rotate([angles[3],0,0]){
                                            foot();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module foreLeg(a1, a2, a3){
    longSideU();
    translate([0,0,minLongSideULength]){
        leg([a1, a2, a3], [humerusScaled, radiusScaled], 0);
    }
}

module rearLeg(a1, a2, a3, a4){
    longSideU();
    translate([0,0,minLongSideULength]){
        leg([a1, a2, a3, a4],
            [femurScaled, tibiaScaled, metatarseScaled], 0);
    }
}


module back(){
    difference(){
        translate([0,0,backThickness/2]){
            cube([backWidthScaled + MotorWidth,
                    backLengthScaled + MotorDepth + 2 * depth, backThickness], true);
        }
    }
}