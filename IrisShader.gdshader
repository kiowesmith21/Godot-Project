shader_type canvas_item;

uniform vec2 pos;
uniform vec2 viewport_size;
uniform float r;

void fragment() {
	vec2 delta = (UV*viewport_size-pos);
	float dist2 = delta.x * delta.x + delta.y * delta.y;
	COLOR = vec4(0.0, 0.0, 0.0, dist2 < r*r ? 0.0 : 1.0);
}