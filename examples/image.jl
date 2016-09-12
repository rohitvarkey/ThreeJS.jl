import ThreeJS

using Reactive

vert = """
        varying vec2 rg;

        void main() {
          rg = uv;
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
        """

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
count = 2

images = (b, b[1:256, 1:357])

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
                ThreeJS.shadermaterial(vertexshader=vert, fragmentshader=frag,
                    uniforms=PropHook("escher-property-hook",
                        Dict(:size=>Dict(:type=>"2f", :value=>[1.0, 1.0])))) << ThreeJS.datatexture("data", getnext(t))
            ],
            ThreeJS.camera(0.0, 0.0, 2.0)
        ]
    )
    end
end
