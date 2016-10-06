#Run this in Escher to see a rotating cube in the browser.

import ThreeJS

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    eventloop = every(1/60)
    rx = 0.0
    ry = 0.0
    rz = 0.0
    map(eventloop) do _
        rx += 0.5
        ry += 0.5
        rz += 0.5
        ThreeJS.outerdiv() <<
                (ThreeJS.initscene() <<
                    [
                        ThreeJS.mesh(0.0, 0.0, 0.0; rx=rx, ry=ry, rz=rz) <<
                        [
                            ThreeJS.box(5.0, 5.0, 5.0), ThreeJS.material(Dict(:kind=>"phong",:color=>"red"))
                        ],
                        ThreeJS.pointlight(150.0, 150.0, 150.0),
                        ThreeJS.pointlight(-150.0, -150.0, -150.0),
                        ThreeJS.camera(0.0, 0.0, 250.0)
                    ]
                )
        end
end
