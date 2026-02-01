shader_type canvas_item;

const float DISTORTION_SPEED = 0.05;

uniform sampler2D noise_texture : repeat_enable;
uniform vec3 smoke_color : source_color = vec3(0.8);
uniform float density : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    float time_offset_1 = TIME * DISTORTION_SPEED * 0.1;
    float time_offset_2 = TIME * DISTORTION_SPEED * 0.2;
    
    vec4 noise = texture(noise_texture, UV + time_offset_1);
    
    vec2 distorted_uv = UV + noise.rg * 0.1 - 0.05 + time_offset_2;
    float final_noise = texture(noise_texture, distorted_uv).r;
    
    float smoke_alpha = final_noise * density * 2.0;
    
    // Output color
    COLOR = vec4(smoke_color, smoke_alpha);
}