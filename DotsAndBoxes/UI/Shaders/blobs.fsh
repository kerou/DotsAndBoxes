// Blobs by @paulofalcao

float time=u_time;

float makePoint(float x,float y,float fx,float fy,float sx,float sy,float t){
    float xx=x+sin(t*fx)*sx;
    float yy=y+cos(t*fy)*sy;
    return 1.0/sqrt(xx*xx+yy*yy);
}

void main( void ) {
    vec4 val = texture2D(u_texture, v_tex_coord);
    vec2 p=(gl_FragCoord.xy/u_sprite_size.x)*2.0-vec2(1.0,u_sprite_size.y/u_sprite_size.x);
    
    p=p*2.0;
    
    float x=p.x;
    float y=p.y;
    
    float a=
    makePoint(x,y,3.3,2.9,0.3,0.3,time);
    a=a+makePoint(x,y,1.9,2.0,0.4,0.4,time);
    a=a+makePoint(x,y,0.8,0.7,0.4,0.5,time);
    a=a+makePoint(x,y,2.3,0.1,0.6,0.3,time);
    a=a+makePoint(x,y,0.8,1.7,0.5,0.4,time);
    a=a+makePoint(x,y,0.3,1.0,0.4,0.4,time);
    a=a+makePoint(x,y,1.4,1.7,0.4,0.5,time);
    a=a+makePoint(x,y,1.3,2.1,0.6,0.3,time);
    a=a+makePoint(x,y,1.8,1.7,0.5,0.4,time);
    
    float b=
    makePoint(x,y,1.2,1.9,0.3,0.3,time);
    b=b+makePoint(x,y,0.7,2.7,0.4,0.4,time);
    b=b+makePoint(x,y,1.4,0.6,0.4,0.5,time);
    b=b+makePoint(x,y,2.6,0.4,0.6,0.3,time);
    b=b+makePoint(x,y,0.7,1.4,0.5,0.4,time);
    b=b+makePoint(x,y,0.7,1.7,0.4,0.4,time);
    b=b+makePoint(x,y,0.8,0.5,0.4,0.5,time);
    b=b+makePoint(x,y,1.4,0.9,0.6,0.3,time);
    b=b+makePoint(x,y,0.7,1.3,0.5,0.4,time);
    
    float c=
    makePoint(x,y,3.7,0.3,0.3,0.3,time);
    c=c+makePoint(x,y,1.9,1.3,0.4,0.4,time);
    c=c+makePoint(x,y,0.8,0.9,0.4,0.5,time);
    c=c+makePoint(x,y,1.2,1.7,0.6,0.3,time);
    c=c+makePoint(x,y,0.3,0.6,0.5,0.4,time);
    c=c+makePoint(x,y,0.3,0.3,0.4,0.4,time);
    c=c+makePoint(x,y,1.4,0.8,0.4,0.5,time);
    c=c+makePoint(x,y,0.2,0.6,0.6,0.3,time);
    c=c+makePoint(x,y,1.3,0.5,0.5,0.4,time);
    
    vec3 d=vec3(a,b,c)/32.0;
    
    
    if (val.a < 0.1) {
        gl_FragColor = vec4(d.x,d.y,d.z,1.0);
        
//        if(d.x < 0.1 && d.y < 0.1 && d.z < 0.1) {
//            gl_FragColor = vec4(1.0,1.0,1.0,1.0);
//        } else {
//        gl_FragColor = vec4(1.0-d.x,1.0-d.y,1.0-d.z,1.0);
//        }
    } else {
        gl_FragColor = vec4(.85,.84,.83,1.0);
    }
}