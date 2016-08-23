import ThreeJS

#data = rand(UInt8, 512, 512);
#b = base64encode(data)
#                 ThreeJS.datatexture(Dict(:data=>b)),
#                ThreeJS.nesteddict(Dict(:nested=>Dict(:k=>5))),
#                ThreeJS.nesteddict(Dict(:nested=>Dict(:k=>5))),

#sig3 = Signal(0.4)

function f(x, y)
    println(x)
#    println("t = ", y)
#    alpha = x.properties[:uniforms][:alpha][:value]
#    alpha += 0.1;
#
#    if (alpha > 1.0)
#        alpha = alpha - 1.0
#    end
#    println(alpha)

#    x.properties[:uniforms][:alpha][:value] = alpha
#    println(x.properties[:uniforms])
#    x.properties[:defines] = Dict()
#    println("changing myval")
#    x.properties[:myval] = 0.75


    x = x + 0.1
    if (x > 1.0)
        x = x - 1.0
    end

    println(typeof(x))

    x
end

t = every(1.0)

#                [
#                    ThreeJS.defines(Dict(:x=>0.1, :y=>0.4))
#                ]

#sig2 = foldp(f, 0.5, t)
#Dict(),

using Reactive

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")

    iterations = Signal(1)
    connected_sl = subscribe(iterations, slider(1:10))

    map(iterations) do n
    vbox(
    ThreeJS.outerdiv() <<
    (ThreeJS.initscene() <<
        [
            ThreeJS.mesh(0.0, 0.0, 0.0) <<
            [
                ThreeJS.plane(8.0, 8.0),
                ThreeJS.shadermaterial(Dict(:uniforms=>Dict(:alpha=>Dict(:type=>"f", :value=>n), :beta=>Dict(:type=>"f", :value=>0.1)),
                    :vertexshader=>open(readall, "assets/shader.vert", "r"),
                    :fragmentshader=>open(readall, "assets/shader.frag", "r")))
            ],
            ThreeJS.pointlight(10.0, 10.0, 10.0),
            ThreeJS.camera(0.0, 0.0, 20.0)
        ]
    ),
    connected_sl
    )
    end
end
