include <MCAD/units.scad>;
use <lib/keyboard_parts/layout.scad>;
use <lib/keyboard_parts/parts.scad>;
include <lib/keyboard_parts/switch_colors.scad>;
include <layout.scad>;

// CONFIGURATION

layer_thicknesses = [1/16*inch, 1/4*inch, 1/8*inch, 1/8*inch, 1/8*inch, 1/8*inch]; // vector of layer thickness values from bottom layer to top

max_layer_size = [60, 100]; // maximum x and y size of layers, just used for visualization and spacing of layers in the vector export

$fa = 6;
$fs=0.1;

// PART SIZES

pcb_size = [2.25*inch, 3.28125*inch, 1.6];

screw_head_dia = 5.5;
screw_size = M3;
screw_tol = 0.1;
nut_flat_size = 5.5;
nut_long_size = 6.2;

// MAGIC DESIGN NUMBERS

case_r = nut_long_size/2; // the rounded corner radius of the case
case_bezel = [4, screw_head_dia]; // x and y bezel sizes

// DERIVED VALUES

case_size = [pcb_size[0] + case_bezel[0]*2, pcb_size[1] + case_bezel[1]*2];

// INFO

echo("Case dimensions: ", case_size);

// this module is where the actual layer shapes are defined
module layer_2d(layer = 0) {
	
	difference() {
		//basic layer shape
		roundrect([case_size[0], case_size[1]], r = case_r);
		
		// bolt holes that should be in all layers
		translate([case_r, case_r]) circle(d = screw_size + screw_tol, center = true);
		translate([case_size[0] - case_r, case_r]) circle(d = screw_size + screw_tol, center = true);
		translate([case_r, case_size[1] - case_r]) circle(d = screw_size + screw_tol, center = true);
		translate([case_size[0] - case_r, case_size[1] - case_r]) circle(d = screw_size + screw_tol, center = true);
		
		if(layer == 0) {
			// on/off button hole
			translate([case_size[0]/2 - pcb_size[0]/2 + 6.56, case_size[1]/2 + (pcb_size[1]-2.38125)/2 - 68.73125, 0]) circle(d = 7, center = true);
			
			// TODO: led holes?
		}
		
		else if (layer == 1) {
			// TODO: space for button, feather, battery, qi module
			
			// space under PCB (so Feather and bottom components can fit)
			translate([case_size[0]/2, case_size[1]/2, 0]) pcb_for(u, key_layout, col_offsets, [2.38125 + 0.5, -2, -1, 0], center = true, centerOnLayout = true, outline = true);
		}
		
		else if (layer == 2) {
			// TODO: cover as much of the bottom of the PCB as possible
			
			// space under PCB (so Feather and bottom components can fit)
			translate([case_size[0]/2, case_size[1]/2, 0]) pcb_for(u, key_layout, col_offsets, [2.38125 + 0.5, -2, -1, 0], center = true, centerOnLayout = true, outline = true);
		}
		
		else if (layer == 3) {
			// space for PCB
			translate([case_size[0]/2, case_size[1]/2, 0]) pcb_for(u, key_layout, col_offsets, [2.38125 + 0.5, 0.5, 0.5, 0.5], center = true, centerOnLayout = true, outline = true);
		}
		
		else if (layer == 4) {
			// switch plate
			translate([case_size[0]/2, case_size[1]/2, 0]) layout("PG1350", u, key_layout, col_offsets, center = true, plateCutouts = true);
		}
		
		else if (layer == 5) {
			// high profile bezels
			translate([case_size[0]/2, case_size[1]/2, 0]) layout_outline(0.5, u, key_layout, col_offsets, tol=0.6, center=true);
		}
		
		else {
			square([1,1]); // placeholder
		}
	}
	
}

// renders a layer in 3d
module layer_3d(layer = 0, color) {
	color(color) linear_extrude(height = layer_thicknesses[layer]) {
		layer_2d(layer);
	}
	
	// add anything that can be shown along with the 3d rendering but won't necessarily be part of the case here, like switches, pcb, etc
	
	if(layer == 0) {
		
	}
	
	else if (layer == 1) {
		
	}
	
	else if (layer == 2) {
		
	}
	
	else if (layer == 3) {
		%translate([case_size[0]/2, case_size[1]/2, layer_thicknesses[layer]-1.6/2]) pcb_for(u, key_layout, col_offsets, [2.38125, 0, 0, 0], thickness=1.6, center = true, centerOnLayout = true, outline = false, color="green");
	}
	
	else if (layer == 4) {
		// preview switches
		%translate([case_size[0]/2, case_size[1]/2, layer_thicknesses[layer]])
		layout("PG1350", u, key_layout, col_offsets, center = true) {
			switch("PG1350");
		}
	}
	
	else if (layer == 5) {
		
	}
	
	else {
		square([1,1]); // placeholder
	}
}

module roundrect(size = [0, 1], r = 0) {
	// TODO: find a way, with OpenSCAD, to make fancy squircles instead of this hard-edged shit (probably have to generate a custom polygon, ugh)
	translate([r, r]) minkowski() {
		square([size[0] - r*2, size[1] - r*2]);
		circle(r = r);
	}
}