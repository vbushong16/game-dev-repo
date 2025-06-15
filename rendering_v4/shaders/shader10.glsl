

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
        

    vec2 uv = (2*(screen_coords/love_ScreenSize.xy)-1); 
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0);
    vec4 texturecolor = Texel(texture, texture_coords);
    // texturecolor = abs(1 - texturecolor);
    vec4 uv2 = vec4(finalColor,1);

    for (float i = 0; i< 4; i++){
        uv = fract(1.5*uv)-0.5;
        float d = length(uv) * exp(-length(uv0));
        vec3 col = palette(length(uv0) + i*0.6 + time*0.6);
        d = sin(d*8 + time)/8;
        d = abs(d);
        d = pow(0.01/d,1.2);
        finalColor += col * d;
        uv2 = vec4(finalColor,1);
    }
    


    return uv2*texturecolor;
}