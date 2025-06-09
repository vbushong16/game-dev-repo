
uniform float time;

vec3 palette(float t)
{
    vec3 a = vec3(0.5,0.5,0.5);
    vec3 b = vec3(0.5,0.5,0.5);
    vec3 c = vec3(1,1,1);
    vec3 d = vec3(0.263,0.416,0.557);
    return a + b*cos( 6.283185*(c*t+d) );
}

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection*vertex_position;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = 2*(screen_coords/love_ScreenSize.xy)-1;

    uv = fract(uv);

    float d = length(uv);
    vec3 col = palette(d+time);
    
    d = sin(8*d + time)/8;
    d = abs(d);

    d = 0.02/d;

    col *= d;

    return vec4(col, 1) ;
    
}