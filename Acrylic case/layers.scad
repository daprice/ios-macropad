layer_thicknesses = [1.5, 3, 3, 3, 3, 3]; // vector of layer thickness values from bottom layer to top

max_layer_size = [60, 100]; // maximum x and y size of layers, just used for visualization and spacing of layers in the vector export

// renders a layer in 3d
module layer_3d(layer = 0) {
	linear_extrude(height = layer_thicknesses[layer]) {
		layer_2d(layer);
	}
}

// this module is where the actual layer shapes are defined
module layer_2d(layer = 0) {
	square(size = [20*layer + 10,30]);
}