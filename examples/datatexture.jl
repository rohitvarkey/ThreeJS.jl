import ThreeJS

using Reactive

frag = """
        varying vec2 rg;
        uniform sampler2D data;
        uniform vec2 size;

        void main() {
            vec4 c = texture2D(data, rg / size);
            gl_FragColor = c; }
        """

using Images

#myfilename = "assets/doge.png"

#using FileIO
#obj = load(myfilename)

ascent = load("assets/ascent.png")

a = separate(ascent)
a = a.data
b = reinterpret(UInt8, a)
#println(b)
#a = img.data
#b = reinterpret(Array{UInt8, 2}, a)

println(typeof(a))

next = 1

images = (b, b[257:512, 257:512], b[355:463, 292:375])
count = length(images)

function getnext(t)
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

    ti = map(_->time(), fps(30))
    ti = every(1.0)

    map(ti) do t
    ThreeJS.outerdiv() <<
    (ThreeJS.initscene() <<
        [
            ThreeJS.mesh(0.0, 0.0, 0.0) <<
            [
                ThreeJS.plane(1.0, 1.0),
                ThreeJS.shadermaterial(vert, frag; :uniforms => Dict(:size => Dict(:type => "2f", :value => [1.0, 1.0]))) <<
                    ThreeJS.datatexture("data", getnext(t); :minfilter => "LinearFilter")
            ],
            ThreeJS.camera(0.0, 0.0, 2.0)
        ]
    )
    end
end
