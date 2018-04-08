// 3D printable version of the case
// Note that this essentially comes out as a partially-preassembled version of the laser cut design and isn't optimized for 3D printing in any way.

use <assembly.scad>;
include <layers.scad>;

// bottom part
stack_layers(layer = 0, maxLayer = 3);

// top part
translate([max_layer_size[0] + 10, 0, 0]) {
	stack_layers(4);
}