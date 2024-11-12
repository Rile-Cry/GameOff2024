shader_type canvas_item;

varying vec2 v_tex_coords;

uniform vec2 u_pivot;
uniform vec3 u_color_pivot;
uniform vec3 u_color_edge;
uniform float u_max_dist;

void vertex() {
}

void fragment() {
	float dist = distance(UV, u_pivot);
	float a = min(dist / u_max_dist, 1.);
	
	vec3 grad_color = mix(u_color_pivot, u_color_edge, a);
	
	COLOR = vec4(grad_color, 1.);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
