varying vec2 v_uv;
uniform sampler2D data;
uniform vec2 size;

void main() { gl_FragColor = texture2D(data, v_uv / size); }
