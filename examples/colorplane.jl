import ThreeJS
import Reactive: every

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"nested-props")

    map(every(1 / 30)) do t
        ThreeJS.outerdiv() <<
        (ThreeJS.initscene() <<
            [
                ThreeJS.mesh(0.0, 0.0, 0.0) <<
                [
                    ThreeJS.plane(1.0, 1.0),
                    ThreeJS.shadermaterial(open(readall, "assets/colorplane.vert", "r"), open(readall, "assets/colorplane.frag", "r");
                        :uniforms => Dict(:b => Dict(:type => "f", :value => sin(t)^2), :a => Dict(:type => "f", :value => cos(t)^2)))
                ],
                ThreeJS.camera(0.0, 0.0, 2.0)
            ]
        )
    end
end
