// Doodle based on Sound Visualizer https://www.shadertoy.com/view/Xds3Rr
// and
// http://vimeo.com/51993089 @ the 0min 44s mark
//
void main ( void )
{
    vec2 center = (u_sprite_size) / length(u_sprite_size) / 0.7;
    vec2 uv = 2.0*(v_tex_coord.xy/center.xy) - 1.0;
    // equvalent to the video's spec.y, I think
    vec2 spec = 1.0*texture2D( u_texture,
                              vec2(0.25,5.0/100.0) ).xx;
    
    float col = 0.0;
    uv.x += sin(u_time * 6.0 + uv.y*1.5)*spec.y;
    col += abs(0.066/uv.x) * spec.y;
    gl_FragColor = vec4(col,col,col,1.0);
}



//void main( void )
//{
//    vec2 center = (u_sprite_size) / length(u_sprite_size) / 0.63;
//
//    vec2 uv = v_tex_coord.xy / center.y;
////    vec2 mouse = iMouse.xy / iResolution.xy;
//    
//    float bg = (cos(uv.x*3.14159*2.0) + sin((uv.y)*3.14159)) * 0.15;
//    
//    vec2 p = uv*2.0 - 1.0;
//    p *= 15.0;
//    vec2 sfunc = vec2(p.x, p.y + 5.0*sin(uv.x*10.0-u_time*2.0 + cos(u_time*7.0) )+2.0*cos(uv.x*25.0+u_time*4.0));
//    sfunc.y *= uv.x*2.0+0.05;
//    sfunc.y *= 2.0 - uv.x*2.0+0.05;
////    sfunc.y /= 0.1; // Thickness fix
//    
//    vec3 c = vec3(abs(sfunc.y));
//    c = pow(c, vec3(-0.5));
//    c *= vec3(0.3,0.85,1.0);
//    //c += vec3(bg, bg*0.8, bg*0.4);
//    
//    if(c.x < 0.2 && c.y < 0.2 && c.z < 0.2) {
//        gl_FragColor = vec4(0.0,0.0,0.0,0.0);
//    } else {
//        gl_FragColor = vec4(c,1.0);
//    }
//}