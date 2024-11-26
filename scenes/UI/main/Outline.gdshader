shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(0, 0, 0, 1);
uniform float outline_width : hint_range(0, 10) = 0;

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1), 
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * outline_width / 2.0;
	vec4 color = texture(TEXTURE, UV);
	
	float inline = 1.0;
	float outline = 0.0;
	for (int i = 0; i < OFFSETS.length(); i++) {
		float sample = texture(TEXTURE, UV + size * OFFSETS[i]).a;
		outline += sample;
		inline *= sample;
	}
	outline = min(1.0, outline) - color.a;
	inline = (1.0 - inline) * color.a;
	
	vec4 outlined_result = mix(color, outline_color, outline + inline);
	COLOR = mix(color, outlined_result, outlined_result.a);
}