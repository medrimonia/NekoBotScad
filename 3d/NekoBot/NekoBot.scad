include <parts.scad>
use <../models/motor_arm.scad>

module nekoBot(){
	rotate([0,90,0])
		motorArm();
	foreLeg(100);
	translate([0,0,100]){
		rotate([90,0,90])
			motorArm();
		rotate([45,0,0]){
			foreLeg(100);
		}
	}
}

nekoBot();