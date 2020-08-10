/*==================================================
	Copyright(C) - 2020 Matteo Vinci
==================================================*/

//Godot shader declaration
shader_type spatial;
render_mode ambient_light_disabled;

//Inputs
uniform sampler2D Mask;
uniform float Incidence = 5.0;
uniform float Strenght = 1.0;
uniform vec4 Object_Color : hint_color = vec4(0.9, 0.9, 0.9, 1.0);
uniform vec4 Sketch_Color : hint_color = vec4(0.1, 0.1, 0.1, 1.0);

void /*main*/ fragment(){
	ALBEDO = Object_Color.rgb; //Color Out (fragColor)
}

//Light loops are absent in OSL
void light(){
	vec3 mask_data = texture(Mask, UV).rgb; //converting mask image to readable data for interpolation
	vec3 fac = clamp(mask_data * -(dot(NORMAL, LIGHT)), 0.0, 1.0) * Incidence;
	vec3 mask_fac = smoothstep(Object_Color.rgb, Sketch_Color.rgb, fac); //interpolation between Color and Sketch
	
	DIFFUSE_LIGHT += (ALBEDO * ATTENUATION * mask_fac) * Strenght; //Processed result
}
