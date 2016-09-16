#Run this in Escher to see a rotating cube in the browser. Clicking on the cube triggers
#a raycaster that changes its color.

import ThreeJS

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))

    eventloop = every(1/60)
    pointpick = Signal(Dict())

    rx = 0.0
    ry = 0.0
    rz = 0.0
    colors = cycle(("red", "green", "blue"))

    raycastable_camera = subscribe(pointpick, ThreeJS.raycastable(ThreeJS.camera(0.0, 0.0, 20.0), "click"))

    color, i = next(colors, start(colors))
    map(eventloop, map(point -> (isempty(point) ? (color, i) : next(colors, i)), pointpick)) do _, pair
        color, i = pair

        rx += 0.5
        ry += 0.5
        rz += 0.5
        ThreeJS.outerdiv() <<
                (ThreeJS.initscene() <<
                    [
                        ThreeJS.mesh(0.0, 0.0, 0.0; rx=rx, ry=ry, rz=rz) <<
                        [
                            ThreeJS.box(5.0, 5.0, 5.0), ThreeJS.material(Dict(:kind=>"phong", :color=>color))
                        ],
                        ThreeJS.pointlight(10.0, 10.0, 10.0),
                        ThreeJS.pointlight(-10.0, -10.0, -10.0),
                        Escher.render(raycastable_camera, Dict())
                    ]
                )
        end
end
