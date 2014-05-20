include <parts.scad>
use <../models/motor_arm.scad>

module foreLegs(){
	rotate([180,0,0]){
		translate([-backWidthScaled / 2, 0, 0]){
			foreLeg(-50,120,-70);
		}
		mirror(){
			translate([-backWidthScaled / 2, 0, 0]){
				foreLeg(-50,120,-70);
			}
		}
	}
}

module rearLegs(){
	rotate([180,0,0]){
		translate([-backWidthScaled / 2, 0, 0]){
			rearLeg(-60,120,-100,40);
		}
		mirror(){
			translate([-backWidthScaled / 2, 0, 0]){
				rearLeg(-60,120,-100,40);
			}
		}
	}
}

module nekoBot(){
	translate([0,backLengthScaled/2,0]){
		foreLegs();
	}
	translate([0,-backLengthScaled/2,0]){
		rearLegs();
	}
}

nekoBot();