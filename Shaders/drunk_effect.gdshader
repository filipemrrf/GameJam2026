shader_type canvas_item;

// Use the screen texture to manipulate what the camera sees
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float drunk_intensity : hint_range(0.0, 2.0) = 0.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    
    // 1. WAVE DISTORTION
    // We use a combination of Sine and Cosine for a non-uniform sway
    float time_factor = TIME * 2.0;
    float sway_x = sin(time_factor + uv.y * 8.0) * (drunk_intensity * 0.015);
    float sway_y = cos(time_factor * 0.8 + uv.x * 8.0) * (drunk_intensity * 0.01);
    
    vec2 distorted_uv = uv + vec2(sway_x, sway_y);
    
    // 2. CHROMATIC ABERRATION (Double Vision)
    // We split the color channels based on the current sway amount
    float r = texture(screen_texture, distorted_uv + vec2(sway_x, 0.0)).r;
    float g = texture(screen_texture, distorted_uv).g;
    float b = texture(screen_texture, distorted_uv - vec2(sway_x, 0.0)).b;
    
    // 3. VIGNETTE (Optional blur/darkness at edges)
    // This helps simulate tunnel vision/dizziness
    float dist = distance(uv, vec2(0.5, 0.5));
    float vignette = 0.8;//smoothstep(0.7, 0.3, dist * drunk_intensity);
    
    vec4 final_color = vec4(r, g, b, 1.0);
    COLOR = final_color * mix(1.0, vignette, drunk_intensity * 0.5);
}