varying vec2 v_uv;
uniform sampler2D data;

void main() { gl_FragColor = texture2D(data, v_uv); }
