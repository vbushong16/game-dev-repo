
uniform float time;

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection * vertex_position;
}

vec4 effect(vec4 color,Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = 2*(screen_coords/love_ScreenSize.xy)-1;

    float d = length(uv);
    d = sin(d*8 + time)/8;
    d = abs(d);
    d = step(0.1,d);

    return vec4(d,d,d,1);

}