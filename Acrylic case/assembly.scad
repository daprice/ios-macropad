/*
	Exploded and solid views of assembled case
	this file displays visualizations that are intended to help while you edit layers.scad, but can also be rendered and exported to STL for rapid prototyping with a 3d printer
*/

include <layers.scad>;

display_spacing = 15;

layer_count = len(layer_thicknesses);

// exploded stack
%translate([0, 0, 0]) {
	stack_layers(layer=0, extraSpace = display_spacing);
}

// solid stack
%translate([-max_layer_size[0], -max_layer_size[1], 0]) {
	stack_layers(layer=0, alpha = 0.8);
}

// layout of 3d layers
translate([display_spacing, -max_layer_size[1] - display_spacing, 0]) {
	layout_layers(extraSpace = display_spacing, 3d = true);
}

module layout_layers(layer = 0, extraSpace = display_spacing, 3d = false) {
	if(!3d) layer_2d(layer);
	else layer_3d(layer);
	
	if(layer + 1 < layer_count) {
		translate([max_layer_size[0] + extraSpace, 0, 0]) {
			layout_layers(layer = layer + 1, extraSpace = extraSpace, 3d = 3d);
		}
	}
}

module stack_layers(layer = 0, maxLayer = -1, extraSpace = 0, alpha = 1) {
	value = (layer)/len(layer_thicknesses)/3 + 0.4;
	
	layer_3d(layer, color = [value, value, value, alpha]);
	
	if(layer + 1 < layer_count && (maxLayer == -1 || layer < maxLayer)) {
		translate([0, 0, layer_thicknesses[layer] + extraSpace]) {
			stack_layers(layer = layer + 1, maxLayer = maxLayer, extraSpace = extraSpace, alpha = alpha);
		}
	}
}