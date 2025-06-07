
varying vec4 pos;
uniform float time;


vec3 palette(float t){
    vec3 a = vec3(0.5,0.5,0.5);
    vec3 b = vec3(0.5,0.5,0.5);
    vec3 c = vec3(1.,1.,1.);
    vec3 d = vec3(0.263,0.416,0.557);
    return a + b*cos(6.28318*(c*t+d));
}


#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position) {

    // float screen_width = love_ScreenSize.x;
    // float screen_height = love_ScreenSize.y;

    pos = vertex_position;
    // vec2 normalized_pos = vec2(pos.x/screen_width, pos.y/screen_height);
    // normalized_pos = (normalized_pos *2.)-1.;
    // normalized_pos = (normalized_pos +1.)/2;
    // pos.y = normalized_pos.y * screen_height;
    vec4 transformed_position = vertex_position;

    return transform_projection * transformed_position;
}
#endif

#ifdef PIXEL
vec4 effect(vec4 color, Image texture,vec2 texture_coords,vec2 screen_coords)
{
    float screen_width = love_ScreenSize.x;
    float screen_height = love_ScreenSize.y;
    vec2 uv = vec2(pos.x/screen_width, pos.y/screen_height);
    uv = (uv *2.)-1.;
    uv.x *= screen_width/screen_height;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);

    for (float i = 0.0; i <4.0; i++ ){
        uv *= 1.5;
        uv = fract(uv );
        uv -=0.5;
        float d = length(uv) * exp(-length(uv0));
        // vec3 col = vec3(1.0,2.0,3.0);
        vec3 col = palette(length(uv0) +i*.4 + time * .4);
        d = sin(d*8 + time)/8;
        d = abs(d);
        // d = step(0.1,d);
        d = pow(0.01/d,1.2);
        finalColor += col * d;

    }


    return vec4(finalColor,1);
}
#endif