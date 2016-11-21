varying vec2 v_uv;
uniform float w;

uniform sampler2D data;

void main() { gl_FragColor = texture2DAs3D(data, vec3(v_uv, w)); }
