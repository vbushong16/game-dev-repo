


extern float fov= 90.0;
extern bool cull_back = true;
extern float y_rot= 0.0;
extern float x_rot = 0.0;
extern float inset = 0.0;

varying vec3 v_p;
varying vec2 v_o;


#ifndef PI
#define PI 3.141592653589793
#endif

vec4 position(mat4 transform_projection, vec4 vertex_position) {
    vec2 current_uv = vertex_position.xy;

    float rad_y_rot = y_rot * PI / 180.0;
    float rad_x_rot = x_rot * PI / 180.0;

    float sin_b = sin(rad_y_rot);
    float cos_b = cos(rad_y_rot);
    float sin_c = sin(rad_x_rot);
    float cos_c = cos(rad_x_rot);

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

    float t = tan(fov * PI / 360.0);
    vec2 centered_uv = current_uv - 0.5;
    centered_uv *= (1.0 - inset);
    
    vec3 v_p2 = v_p;
    v_p2 = inv_rot_mat * vec3(centered_uv, 0.5 / t);

    float perspective_adjust_factor = (0.5 / t) + 0.5;
    vec2 v_o2 = v_o;
    v_o2 = perspective_adjust_factor * inv_rot_mat[2].xy;


    return transform_projection * vec4(vertex_position);
}


vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    if (cull_back && v_p.z <= 0.0) {
        return vec4(0.0);
    }

    vec2 uv_for_sampling;

    if (abs(v_p.z) < 0.0001) {
        return vec4(0.0);
    }

    uv_for_sampling = (v_p.xy / v_p.z) - v_o;
    vec2 final_uv = uv_for_sampling + 0.5;

    vec4 tex_color = Texel(texture, final_uv);
    vec4 output_color = tex_color * color;

    output_color.a *= step(max(abs(uv_for_sampling.x), abs(uv_for_sampling.y)), 0.5);

    return output_color;
}