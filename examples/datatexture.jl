import ThreeJS
import FileIO: load
import Reactive: every

import Images

ascent = load("assets/ascent.png")

a = Images.separate(ascent)
a = a.data
b = reinterpret(UInt8, a)

println(typeof(b))
#println(b)
#a = img.data
#b = reinterpret(Array{UInt8, 2}, a)

images = cycle((b, b[257:512, 257:512], b[355:463, 292:375]))

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"nested-props")

    i = start(images)
    map(map(t -> next(images, i), every(1))) do pair
        a, i = pair
        ThreeJS.outerdiv() <<
        (ThreeJS.initscene() <<
            [
                ThreeJS.mesh(0.0, 0.0, 0.0) <<
                [
                    ThreeJS.plane(convert(Float64, size(a, 1)), convert(Float64, size(a, 2))),
                    ThreeJS.shadermaterial(open(readall, "assets/datatexture.vert", "r"), open(readall, "assets/datatexture.frag", "r")) <<
                        ThreeJS.datatexture("data", a; :minfilter => "LinearFilter")
                ],
                ThreeJS.camera(0.0, 0.0, 768.0)
            ]
        )
    end
end
