// Created by inigo quilez - iq/2014
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Analytic motion blur, for 2D spheres (disks).
//
// (Linearly) Moving Disk - pixel/ray overlap test. The resulting equation is a quadratic
// that can be solved to compute time coverage of the swept disk behind the pixel over the
// aperture of the camera (a full frame at 24 hz in this test).



// draw a disk with motion blur
vec3 diskWithMotionBlur( vec3 col, in vec2 uv, in vec3 sph, in vec2 cd, in vec3 sphcol )
{
    vec2 xc = uv - sph.xy;
    float a = dot(cd,cd);
    float b = dot(cd,xc);
    float c = dot(xc,xc) - sph.z*sph.z;
    float h = b*b - a*c;
    if( h>0.0 )
    {
        h = sqrt( h );
        
        float ta = max( 0.0, (-b - h)/a );
        float tb = min( 1.0, (-b + h)/a );
        
        if( ta < tb ) // we can comment this conditional, in fact
            col = mix( col, sphcol, clamp(2.0*(tb-ta),0.0,1.0) );
    }
    
    return col;
}


vec3 hash3( float n ) { return fract(sin(vec3(n,n+1.0,n+2.0))*43758.5453123); }
vec4 hash4( float n ) { return fract(sin(vec4(n,n+1.0,n+2.0,n+3.0))*43758.5453123); }

const float speed = 8.0;
vec2 getPosition( float time, vec4 id ) { return vec2(       0.9*sin((speed*(0.75+0.5*id.z))*time+20.0*id.x),        0.75*cos(speed*(0.75+0.5*id.w)*time+20.0*id.y) ); }
vec2 getVelocity( float time, vec4 id ) { return vec2( speed*0.9*cos((speed*(0.75+0.5*id.z))*time+20.0*id.x), -speed*0.75*sin(speed*(0.75+0.5*id.w)*time+20.0*id.y) ); }

void main( void )
{
    vec2 p = (2.0*gl_FragCoord.xy-u_sprite_size.xy) / u_sprite_size.y;
    
    vec3 col = vec3(0.2) + 0.05*p.y;
    
    for( int i=0; i<16; i++ )
    {
        vec4 off = hash4( float(i)*13.13 );
        vec3 sph = vec3( getPosition( u_time, off ), 0.02+0.1*off.x );
        vec2 cd = getVelocity( u_time, off ) /24.0 ;
        vec3 sphcol = 0.7 + 0.3*sin( 3.0*off.z + vec3(4.0,0.0,2.0) );
        
        col = diskWithMotionBlur( col, p, sph, cd, sphcol );
    }		
    
    col += (1.0/255.0)*hash3(p.x+13.0*p.y);
    
    gl_FragColor = vec4(col, 1);
}