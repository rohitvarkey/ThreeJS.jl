varying vec2 v_uv;
uniform float b;
uniform float a;

void main() { gl_FragColor = vec4(v_uv, b, a); }
