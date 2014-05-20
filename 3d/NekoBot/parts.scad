include <bones.scad>
include <config.scad>

module foreLeg(){
	  rotate([90,0,90]){
		    motorArm();
    }
	  bone(humerusScaled);
	  translate([0,0,humerusScaled]){
		    rotate([90,0,90])
			  motorArm();
		    rotate([135,0,0]){
			      foreLeg(80);
		    }
    }
}