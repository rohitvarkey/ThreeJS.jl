import ThreeJS

t = every(1.0)

using Reactive

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    push!(window.assets,"nested-props")

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
                ThreeJS.shadermaterial(uniforms=Dict(:alpha=>Dict(:type=>"f", :value=>n), :beta=>Dict(:type=>"f", :value=>0.1)),
                    defines=PropHook("NestedUpdate", Dict(:a=>2)),
                    vertexshader=open(readall, "assets/shader.vert", "r"),
                    fragmentshader=open(readall, "assets/shader.frag", "r"))
            ],
            ThreeJS.pointlight(10.0, 10.0, 10.0),
            ThreeJS.camera(0.0, 0.0, 20.0)
        ]
    ),
    connected_sl
    )
    end
end
