

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection*vertex_position;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    //Goal: Normalize -1 -> 1
    //0 -> 1
    // -1 -> 1
    //anchor to screen resolution
    vec2 uv = (2*(screen_coords/love_ScreenSize.xy) - 1)* love_ScreenSize.x/love_ScreenSize.y;
    // Make a circle with radius 0.5 and make is 0 at 0.5 from the origin
    float d = abs(length(uv)-0.5);
    //Any value <0.1 will be floored to 0 and other values ceiling to 1.
    // d = step(0.1,d);
    //if you want a gradient between 2 value using the smoothstep
    // if between 0 and 0.1 do a gradient if above 0.1 ceiling to 1.
    d = smoothstep(0.0,0.1,d);
    return vec4(d,d,d,1);

}