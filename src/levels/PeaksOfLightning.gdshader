shader_type canvas_item;

uniform float speed = 0.01f;

void fragment () {
	COLOR = texture(TEXTURE, vec2(UV.x + TIME * speed, UV.y));
	//COLOR = texture(TEXTURE, UV + vec2(0.0, sin(TIME * 0.5 + (UV.x + UV.y))));
}