vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection * vertex_position;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = abs(2*(screen_coords/love_ScreenSize.xy)-1);

    return vec4 (uv, 0,1);

}