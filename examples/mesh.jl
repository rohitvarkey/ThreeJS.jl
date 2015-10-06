#Run this in Escher to see a rotating cube in the browser.

import ThreeJS
using FileIO

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    x = Input(1.0)
    y = Input(1.0)
    z = Input(1.0)
    mesh_geom = load("cat.obj")
    vbox(
        "ThreeJS Example",
        vskip(2em),
        vbox(
            "Scale",
            hbox("x",slider(1.0:5.0) >>> x),
            hbox("y",slider(1.0:5.0) >>> y),
            hbox("z",slider(1.0:5.0) >>> z),
        ),
        vskip(2em),
        lift(x,y,z) do x,y,z
        ThreeJS.outerdiv() << 
            (ThreeJS.initscene() <<
                [
                    ThreeJS.mesh(0.0, 0.0, 0.0) << 
                    [
                        ThreeJS.geometry(mesh_geom, scale=(x,y,z)), ThreeJS.material(Dict(:kind=>"lambert",:color=>"red"))
                    ],
                    ThreeJS.pointlight(10.0, 10.0, 10.0),
                    ThreeJS.camera(2.0, 2.0, 2.0)
                ]
            )
        end
    ) |> pad(2em)
end
