// Vertex shader
vec4 position(mat4 transform_proj, vec4 vertex_position) {
    return transform_proj * vertex_position;
}

// Fragment shader
extern float time;
extern Image noise_tex;
extern vec2 texture_size;
extern vec2 noise_tex_size;  // Added parameter for noise texture dimensions

// Water parameters
const float distortion_strength = 0.02;
const float wave_speed = 2.0;
const vec3 water_color = vec3(0.2, 0.4, 0.6);
const float color_blend = 0.3;
const float opacity = 0.8;

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 screen_coords) {
    // Calculate noise texture coordinate scaling
    vec2 noise_scale = texture_size / noise_tex_size;
    
    // Create moving UV coordinates
    vec2 moving_uv = uv * noise_scale + time * wave_speed * 0.1;
    
    // Sample noise texture with proper scaling
    vec4 noise1 = Texel(noise_tex, moving_uv + vec2(time * 0.2, 0.0));
    vec4 noise2 = Texel(noise_tex, moving_uv * 0.5 - vec2(0.0, time * 0.1));
    
    // Combine noise values
    float combined_noise = (noise1.r + noise2.g) * 0.5;
    
    // Create distortion
    vec2 distortion = vec2(
        cos(combined_noise * 10.0 + time * wave_speed),
        sin(combined_noise * 8.0 + time * wave_speed)
    ) * distortion_strength;
    
    // Apply distortion
    vec4 tex_color = Texel(texture, uv + distortion);
    
    // Water tint
    vec3 water_tint = water_color * (0.8 + sin(time * 2.0) * 0.2);
    
    // Final color
    vec3 final_color = mix(tex_color.rgb, water_tint, color_blend);
    final_color += vec3(0.2) * pow(combined_noise, 2.0);
    
    return vec4(final_color, opacity) * color;
}