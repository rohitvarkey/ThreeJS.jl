varying vec2 v_uv;
uniform float w;

uniform sampler2D data;

vec4 texture2DAs3D(sampler2D tex, vec3 texcoord) {
    vec3 shape = vec3(512.0, 512.0, 2.0);
    float r = 1.0;
    float c = 2.0;

    // Don't let adjacent frames be interpolated into this one
    texcoord.x = min(texcoord.x * shape.x, shape.x - 0.5);
    texcoord.x = max(0.5, texcoord.x) / shape.x;

    texcoord.y = min(texcoord.y * shape.y, shape.y - 0.5);
    texcoord.y = max(0.5, texcoord.y) / shape.y;

    float index = floor(texcoord.z * shape.z);

    // Do a lookup in the 2D texture
    float u = (mod(index, r) + texcoord.x) / r;
    float v = (floor(index / r) + texcoord.y) / c;

    return texture2D(tex, vec2(u, v));
}

void main() { gl_FragColor = texture2DAs3D(data, vec3(v_uv, w)); }
