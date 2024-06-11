shader_type canvas_item;

uniform vec2 Direction = vec2(1.0,5.0);

void fragment() {
	COLOR = texture(TEXTURE,UV + (Direction * TIME * 0.1));
}
