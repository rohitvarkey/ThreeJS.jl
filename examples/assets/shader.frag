varying vec2 v_uv;
uniform float alpha;

void main() { gl_FragColor = vec4(v_uv, 0.0, alpha); }
