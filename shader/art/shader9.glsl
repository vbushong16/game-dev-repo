

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
    return transform_projection * vertex_position;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{

    vec2 uv = 2*(screen_coords/love_ScreenSize.xy)-1 * love_ScreenSize.x/love_ScreenSize.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0);

    for (float i = 0; i< 2; i++){

        uv = fract(uv*2)-0.5;
        float d = length(uv)-0.5;
        vec3 col = palette(length(uv0) + time);
        d = sin(d*8 + time)/8;
        d = abs(d);
        d = 0.02/d;
        finalColor += col * d;

    }


    return vec4(finalColor,1);



}



