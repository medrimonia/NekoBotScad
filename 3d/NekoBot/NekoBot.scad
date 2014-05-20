include <parts.scad>

module nekoBot(){
	foreLeg(100);
	translate([0,0,100]){
		rotate([45,0,0]){
			foreLeg(100);
		}
	}
}

nekoBot();