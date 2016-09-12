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

# periodic_leading = sampleon(every10secs, leading)

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"nested-props")

    map(map(t -> getnext(), every(1))) do a
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
