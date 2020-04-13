shader_type spatial;
render_mode unshaded, cull_front;

uniform vec4 Outline_Color : hint_color;
uniform float grow = 0.02;

void vertex() {
	VERTEX+=NORMAL*grow; //making the outline shader bigger than original mesh
}

void fragment() {
	ALBEDO = Outline_Color.rgb;
}
