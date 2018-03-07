include <MCAD/units.scad>;

// CONFIGURATION

layer_thicknesses = [1.5, 5.6, 3, 3, 3, 3]; // vector of layer thickness values from bottom layer to top

max_layer_size = [60, 100]; // maximum x and y size of layers, just used for visualization and spacing of layers in the vector export

// PART SIZES

pcb_size = [2.25*inch, 3.28125*inch, 1.6];

screw_head_dia = 5.5;
screw_size = M3;
screw_tol = 0.1;
nut_flat_size = 5.5;
nut_long_size = 6.2;

// MAGIC DESIGN NUMBERS

case_r = nut_long_size/2; // the rounded corner radius of the case
case_bezel = [1, case_r + 0.5]; // x and y bezel sizes

// DERIVED VALUES

case_size = [pcb_size[0] + case_bezel[0]*2, pcb_size[1] + case_bezel[1]*2];

// INFO

echo("Case dimensions: ", case_size);

// this module is where the actual layer shapes are defined
module layer_2d(layer = 0) {
	
	difference() {
		//basic layer shape
		roundrect([case_size[0], case_size[1]], r = case_r, $fn = 50);
		
		// bolt holes that should be in all layers
		translate([case_r, case_r]) circle(d = screw_size + screw_tol, center = true, $fn = 20);
		translate([case_size[0] - case_r, case_r]) circle(d = screw_size + screw_tol, center = true, $fn = 20);
		translate([case_r, case_size[1] - case_r]) circle(d = screw_size + screw_tol, center = true, $fn = 20);
		translate([case_size[0] - case_r, case_size[1] - case_r]) circle(d = screw_size + screw_tol, center = true, $fn = 20);
		
		if(layer == 0) {
			// TODO: on/off button hole
			
			
			// TODO: led holes
		}
		
		else if (layer == 1) {
			// TODO: space for button, feather, battery, qi module
		}
		
		else if (layer == 2) {
			// TODO: cover as much of the bottom of the PCB as possible
		}
		
		else if (layer == 3) {
			// TODO: space for PCB
		}
		
		else if (layer == 4) {
			// TODO: switch plate
		}
		
		else if (layer == 5) {
			// TODO: high profile bezels
		}
		
		else {
			square([1,1]); // placeholder
		}
	}
	
}

// renders a layer in 3d
module layer_3d(layer = 0) {
	linear_extrude(height = layer_thicknesses[layer]) {
		layer_2d(layer);
	}
}

module roundrect(size = [0, 1], r = 0) {
	// TODO: find a way, with OpenSCAD, to make fancy squircles instead of this hard-edged shit (probably have to generate a custom polygon, ugh)
	translate([r, r]) minkowski() {
		square([size[0] - r*2, size[1] - r*2]);
		circle(r = r);
	}
}