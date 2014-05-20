include <ollo.scad>;

module arm() {
    color([0.6,0.6,0.6]) {
        difference() {
            cylinder(r=10, h=OlloWidth);
            servoArm(OlloWidth);
        }
    }
}

arm();
