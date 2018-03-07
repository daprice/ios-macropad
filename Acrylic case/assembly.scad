// Exploded and solid views of assembled case
// this file is meant to help visualize when editing, but could be used to generate 3d preview images

include <layers.scad>;

display_spacing = 10;

layer_count = len(layer_thicknesses);

// exploded stack
translate([0, 0, 0]) {
	stack_layers(layer=0, extraSpace = display_spacing);
}

// solid stack
translate([-max_layer_size[0], -max_layer_size[1], 0]) {
	stack_layers(layer=0);
}

module layout_layers(layer = 0, extraSpace = display_spacing) {
	layer_2d(layer);
	
	if(layer + 1 < layer_count) {
		translate([max_layer_size[0] + extraSpace, 0, 0]) {
			layout_layers(layer = layer + 1, extraSpace = extraSpace);
		}
	}
}

module stack_layers(layer = 0, extraSpace = 0) {
	value = (layer)/len(layer_thicknesses)/3 + 0.4;
	
	color(c = [value, value, value]) linear_extrude(height = layer_thicknesses[layer]) {
		layer_2d(layer);
	}
	
	if(layer + 1 < layer_count) {
		translate([0, 0, layer_thicknesses[layer] + extraSpace]) {
			stack_layers(layer = layer + 1, extraSpace = extraSpace);
		}
	}
}