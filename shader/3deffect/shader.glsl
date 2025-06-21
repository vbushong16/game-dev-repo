// Fake 3D Perspective Shader converted from Godot
// Original by Hei under MIT License, converted for LÖVE2D

// External variables - these will be set from Lua code
uniform number fov = 90;  // Camera FOV (1-179)
uniform bool cull_back = false;  // Whether to cull back faces
uniform number y_rot = 0;  // Y rotation (-180 to 180)
uniform number x_rot = 0;  // X rotation (-180 to 180)
uniform number inset = 0;  // Inset to prevent clipping (0-1)

// Additional uniforms for passing data to fragment shader
// extern vec2 texture_size;  // Width and height of texture in pixels

const float PI = 3.14159265358979323846;

// Vertex shader - minimal implementation
vec4 position(mat4 transform_projection, vec4 vertex_position) {
    // Just pass through with no modifications
    return transform_projection * vertex_position;
}

// Fragment shader - all the perspective math happens here
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // Convert texture coordinates to [-0.5, 0.5] range for rotation
    vec2 centered_coords = texture_coords - 0.5;
    
    // Calculate rotation matrices
    float sin_b = sin(y_rot / 180.0 * PI);
    float cos_b = cos(y_rot / 180.0 * PI);
    float sin_c = sin(x_rot / 180.0 * PI);
    float cos_c = cos(x_rot / 180.0 * PI);
    
    mat3 inv_rot_mat;
    inv_rot_mat[0][0] = cos_b;
    inv_rot_mat[0][1] = 0.0;
    inv_rot_mat[0][2] = -sin_b;
    
    inv_rot_mat[1][0] = sin_b * sin_c;
    inv_rot_mat[1][1] = cos_c;
    inv_rot_mat[1][2] = cos_b * sin_c;
    
    inv_rot_mat[2][0] = sin_b * cos_c;
    inv_rot_mat[2][1] = -sin_c;
    inv_rot_mat[2][2] = cos_b * cos_c;
    
    // Calculate the perspective transformation
    float t = tan(fov / 360.0 * PI);
    
    // Calculate 3D point and offsets
    vec3 p = inv_rot_mat * vec3(centered_coords, 0.5 / t);
    float v = (0.5 / t) + 0.5;
    vec2 o = v * vec2(inv_rot_mat[2].x, inv_rot_mat[2].y);
    p.xy *= v * inv_rot_mat[2].z;
    
    // Apply back-face culling
    if (cull_back && p.z <= 0.0) {
        return vec4(0.0);  // Transparent pixel
    }
    
    // Calculate the UV coordinates for perspective projection
    vec2 uv = (p.xy / p.z) - o;
    
    // Apply inset adjustment
    uv = uv * (1.0 - inset);
    
    // Check if we're outside the texture bounds
    if (max(abs(uv.x), abs(uv.y)) > 0.5) {
        return vec4(0.0);  // Transparent pixel
    }
    
    // Sample the texture at the calculated UV
    vec4 result = Texel(texture, uv + 0.5);
    
    // Apply the color tint
    return result * color;
}