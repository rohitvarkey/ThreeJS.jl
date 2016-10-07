import ThreeJS
import FileIO: load
import Reactive: every

ascent = load("assets/ascent.png")
a = reinterpret(UInt8, ascent.data)

# 1024
#depth, width = 512, 512
#r = 1024 // width
#c = depth // r
#if math.fmod(depth, r):
#    c += 1

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"nested-props")

    b = Array{UInt8}(512, 512, 2)
    b[:, :, 1] = a[:, :] * 0.0
    b[:, :, 2] = a[:, :] * 1.0
    println(typeof(b))
    println(size(b))

    ThreeJS.outerdiv() <<
    (ThreeJS.initscene() <<
        [
            ThreeJS.mesh(0.0, 0.0, 0.0) <<
            [
                ThreeJS.plane(512.0, 512.0),
                ThreeJS.shadermaterial(open(readall, "assets/compressedtexture.vert", "r"), open(readall, "assets/emulatedtexture3D.frag", "r");
                        :uniforms => Dict(:w => Dict(:type => "f", :value => 0.2))) <<
                    ThreeJS.datatexture("data", b)
            ],
            ThreeJS.camera(0.0, 0.0, 768.0)
        ]
    )
end
