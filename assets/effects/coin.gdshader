shader_type canvas_item;

uniform float amplitude = 100.0;
uniform float speed = 5.0;
uniform bool play = false;
void vertex() {
	if (play){
		VERTEX.y += amplitude * sin(speed * TIME);
	}
}

