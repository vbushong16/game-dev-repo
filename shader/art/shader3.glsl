varying vec4 pos;
varying vec2 normal_pos;

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position) 
{

    pos = vertex_position;
    normal_pos = pos.xy/love_ScreenSize.xy;
    vec4 transformed_position = vertex_position;

    return transform_projection * transformed_position;

}
#endif

#ifdef PIXEL
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) 
{
    // float screen_width = love_ScreenSize.x;
    // float screen_height = love_ScreenSize.y;
    // vec2 uv = vec2(pos.x/screen_width,pos.y/screen_height);
    vec2 uv = abs(2*(screen_coords/love_ScreenSize.xy)-1);
    uv.x *= love_ScreenSize.x/love_ScreenSize.y;

    float d = length(uv);
    d -= 0.5;
    d = abs(d);

    vec4 finalColor = vec4(d,d,d,1);
    return finalColor;

}
#endif
