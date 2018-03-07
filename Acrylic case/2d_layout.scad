// 2-dimensional layout of case layers
// Render this and export to SVG or DXF from OpenSCAD to get laser cutting files (these may still need minor cleanup afterwards)

use <assembly.scad>;
include <layers.scad>;

spacing = 10;

layer_count = len(layer_thicknesses);

// 2d layout
layout_layers(layer = 0, extraSpace = spacing);