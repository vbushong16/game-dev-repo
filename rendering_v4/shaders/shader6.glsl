
uniform float time;

//https://www.youtube.com/watch?v=f4s1h2YETNY

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection*vertex_position;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coord, vec2 screen_coord)
{
    vec2 uv = (2*screen_coord/love_ScreenSize.xy - 1) * love_ScreenSize.x/love_ScreenSize.y;
    float d = length(uv);

    vec3 col = vec3(1,2,3);

    d = sin(d*8 + time)/8;
    d = abs(d);
    d = 0.02/d;

    col *=d;

    return vec4 (col,1);

}
