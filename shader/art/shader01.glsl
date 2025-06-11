
uniform float time;

float sdRoundBox( in vec2 p, in vec2 b, in vec4 r ) 
{
    r.xy = (p.x>0.0)?r.xy : r.zw;
    r.x  = (p.y>0.0)?r.x  : r.y;
    vec2 q = abs(p)-b+r.x;
    return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - r.x;
}

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection * vertex_position;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 p = (2.0*(screen_coords/love_ScreenSize.xy)-1);
    // vec2 m = (2.0*iMouse.xy-iResolution.xy)/iResolution.y;

	vec2 si = vec2(0.9,0.6) + 0.3*cos(time+vec2(0,2));
    vec4 ra = 0.3 + 0.3*cos( 2.0*time + vec4(0,1,2,3) );
    ra = min(ra,min(si.x,si.y));

	float d = sdRoundBox( p, si, ra );

    vec3 col = (d>0.0) ? vec3(0.9,0.6,0.3) : vec3(0.65,0.85,1.0);
	col *= 1.0 - exp2(-20.0*abs(d));
	col *= 0.8 + 0.2*cos(120.0*d);
	col = mix( col, vec3(1.0), 1.0-smoothstep(0.0,0.01,abs(d)) );

    // if( iMouse.z>0.001 )
    // {
    // d = sdRoundBox(m, si, ra );
    // col = mix(col, vec3(1.0,1.0,0.0), 1.0-smoothstep(0.0, 0.005, abs(length(p-m)-abs(d))-0.0025));
    // col = mix(col, vec3(1.0,1.0,0.0), 1.0-smoothstep(0.0, 0.005, length(p-m)-0.015));
    // }

	return vec4(col,1.0);
}