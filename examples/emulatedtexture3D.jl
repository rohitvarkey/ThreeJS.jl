import ThreeJS
import FileIO: load
import Reactive: every

#ascent = load("assets/ascent.png")
#a = reinterpret(UInt8, ascent.data)

# 1024
#depth, width = 512, 512
#r = 1024 // width
#c = depth // r
#if math.fmod(depth, r):
#    c += 1

function emulated_size(width, height, depth)
    gl_max_texture_size = 1024

    r = div(gl_max_texture_size, height)
    c = div(width, r)

    if mod(width, r) != 0
        c += 1
    end

    1, 4
end

n = 4

a = Array(UInt8, 64, 64, n)
println(strides(a))
println(emulated_size(size(a)...))

for k in 1:n
    j = round(Int, k / n * size(a, 2))
    a[:, 1:j, k] = 128
    a[:, j:size(a, 2), k] = 0
end


function texture2DAs3D(width::Real, height::Real, depth::Real, name = "texture2DAs3D")
    r = 1.0
    c = 4.0

    """
        vec4 $name(sampler2D tex, vec3 texcoord) {
            vec3 shape = vec3($width, $height, $depth);

            // Don't let adjacent frames be interpolated into this one
            texcoord.x = min(texcoord.x * shape.x, shape.x - 0.5);
            texcoord.x = max(0.5, texcoord.x) / shape.x;

            texcoord.y = min(texcoord.y * shape.y, shape.y - 0.5);
            texcoord.y = max(0.5, texcoord.y) / shape.y;

            float index = floor(texcoord.z * shape.z);

            // Do a lookup in the 2D texture
            float u = (mod(index, $r) + texcoord.x) / $r;
            float v = (floor(index / $r) + texcoord.y) / $c;

            return texture2D(tex, vec2(u, v));
        }
    """
end

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"nested-props")

    frag = string(texture2DAs3D(size(a)...), open(readall, "assets/emulatedtexture3D.frag", "r"))

    i = 0
    map(every(1)) do _
        i += 1
        if (i > size(a, 3))
            i = 1
        end

        ThreeJS.outerdiv() <<
        (ThreeJS.initscene() <<
            [
                ThreeJS.mesh(0.0, 0.0, 0.0) <<
                [
                    ThreeJS.plane(size(a, 1), size(a, 2)),
                    ThreeJS.shadermaterial(open(readall, "assets/compressedtexture.vert", "r"), frag;
                            :uniforms => Dict(:w => Dict(:type => "f", :value => i / size(a, 3)))) <<
                        ThreeJS.datatexture("data", a)
                ],
                ThreeJS.camera(0.0, 0.0, 768.0)
            ]
        )
    end
end
