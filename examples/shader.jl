import ThreeJS

#data = rand(UInt8, 512, 512);
#b = base64encode(data)
#                 ThreeJS.datatexture(Dict(:data=>b)),
#                ThreeJS.nesteddict(Dict(:nested=>Dict(:k=>5))),
#                ThreeJS.nesteddict(Dict(:nested=>Dict(:k=>5))),

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    ThreeJS.outerdiv() <<
    (ThreeJS.initscene() <<
        [
            ThreeJS.mesh(0.0, 0.0, 0.0) <<
            [
                ThreeJS.plane(8.0, 8.0),
                ThreeJS.shadermaterial(Dict(:uniforms=>Dict(:alpha=>Dict(:type=>"f", :value=>0.5)),
                    :vertexshader=>open(readall, "assets/shader.vert", "r"),
                    :fragmentshader=>open(readall, "assets/shader.frag", "r")))
            ],
            ThreeJS.pointlight(10.0, 10.0, 10.0),
            ThreeJS.camera(0.0, 0.0, 20.0)
        ]
    )
end
