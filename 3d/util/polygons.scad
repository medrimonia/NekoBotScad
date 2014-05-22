
//Height is in z, points are in xy
module triangle(points, height){
    polyhedron(
        [
            [points[0][0], points[0][1], 0],
            [points[1][0], points[1][1], 0],
            [points[2][0], points[2][1], 0],
            [points[0][0], points[0][1], height],
            [points[1][0], points[1][1], height],
            [points[2][0], points[2][1], height]
        ],
        [
            [0,1,2],
            [0,2,3],
            [2,5,3],
            [2,1,5],
            [1,4,5],
            [1,0,4],
            [0,3,4],
            [3,4,5]
        ]
    );
}

// sideDist is the distance between two opposite sides
// height is in Z
module hexagon(sideDist, height){
    sideLength = sideDist / sqrt(3);
    translate([0,0,height/2]){
        for (alpha = [-60, 0, 60]){
            rotate([0,0, alpha]){
                cube([sideDist, sideLength, height], true);
            }
        }
    }
}