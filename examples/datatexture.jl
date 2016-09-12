import ThreeJS
import FileIO: load
import Iterators: cycle
import Reactive: every

import Images
#myfilename = "assets/doge.png"

#using FileIO
#obj = load(myfilename)

ascent = load("assets/ascent.png")

a = Images.separate(ascent)
a = a.data
b = reinterpret(UInt8, a)
#println(b)
#a = img.data
#b = reinterpret(Array{UInt8, 2}, a)

println(typeof(a))

next = 1

images = (b, b[257:512, 257:512], b[355:463, 292:375])
count = length(images)

#c = cycle(images)

function getnext()
    global next
    global images

    println(next)
    retval = images[next]
    println(size(retval))

    next += 1
    if (next > count)
        next = 1
    end

    retval
end

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    push!(window.assets,"nested-props")

    map(every(1)) do t
        a = getnext()

        ThreeJS.outerdiv() <<
        (ThreeJS.initscene() <<
        [
            ThreeJS.mesh(0.0, 0.0, 0.0) <<
            [
                ThreeJS.plane(1.0, 1.0),
                ThreeJS.shadermaterial(open(readall, "assets/datatexture.vert", "r"), open(readall, "assets/datatexture.frag", "r");
                    :uniforms => Dict(:size => Dict(:type => "2f", :value => [1.0, 1.0]))) <<
                        ThreeJS.datatexture("data", a; :minfilter => "LinearFilter")
            ],
            ThreeJS.camera(0.0, 0.0, 2.0)
        ]
    )
    end
end
