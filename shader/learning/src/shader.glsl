

varying vec4 pos;
uniform float millis;
//uniform love_ScreenSize;
//uniform sampler2D background;
const int num_circles = 100;
extern vec3 circles[num_circles];

#ifdef VERTEX

vec4 position(mat4 transform_projection, vec4 vertex_position) {

    float screen_width = love_ScreenSize.x;
    float screen_height = love_ScreenSize.y;

    pos = vertex_position;


    vec2 normalized_pos = vec2(pos.x/screen_width, pos.y/screen_height);
    normalized_pos = (normalized_pos *2.)-1.;
    //normalized_pos.y += sin(normalized_pos.x+ 8.)/8.;
    //normalized_pos.y += 0.5;
    //normalized_pos.y += sin(millis + normalized_pos.x * 8.)/8;
    normalized_pos = (normalized_pos +1.)/2;
    pos.y = normalized_pos.y * screen_height;
    vec4 transformed_position = pos;

    return transform_projection * transformed_position;
}

#endif




#ifdef PIXEL
vec4 effect(vec4 color, Image texture,vec2 texture_coords,vec2 screen_coords)
{
    //float screen_width = love_ScreenSize.x;
    //float screen_height = love_ScreenSize.y;

    //vec2 normalized_pos = vec2(pos.x/screen_width, pos.y/screen_height);

    //vec4 tl = vec4(0.5,0.1,0.9,1.); 
    //vec4 tr = vec4(0.3,1.,0.8,1.); 
    //vec4 top = mix(tl,tr,pos.x);
    //vec4 bl = vec4(0.8,0.6,0.1,1.); 
    //vec4 br = vec4(0.7,0.1,0.2,1.); 
    //vec4 bottom = mix(bl,br,pos.x);
    //vec4 c = mix(bottom,top,pos.y); 
    
    //vec2 newPos = fract(pos.xy);
    //float t = (sin(normalized_pos.x * 16.) + 1.)/2.; 
    //vec4 c = vec4(t , 0., 1.0, 1.0);

    //vec2 newPos = texture_coords;
    //newPos = newPos + (sin(millis + newPos.x * 8)/8);
    //vec4 col = texture2D(texture,newPos);
    //float avg = (col.r + col.g + col.b)/3.;

    //vec3 circle = vec3(250,250,150);
    float colour = 1.;
    for(int i = 0; i<num_circles; i++){
        float d = length(pos.xy - circles[i].xy) - (circles[i].z + 10* sin(millis*10));
        d = step(0.,d);
        colour *= d;
    }


    return vec4(colour,colour,colour,1.);
}
#endif