import ThreeJS
import Colors: colormap
main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    ts = linspace(0,8π,100);
    x = map(cos,ts)
    y = 0.1ts .* map(sin,ts)
    z = 1.0:100.0;
    vertices = Tuple{Float64, Float64, Float64}[(x[i]*25,z[i],y[i]*25) for i in 1:size(x,1)]
    ThreeJS.outerdiv() <<
            (ThreeJS.initscene() <<
                [
                    ThreeJS.line(vertices) <<
                    [
                        ThreeJS.linematerial(Dict(:color=>"blue"))
                    ],
                    ThreeJS.ambientlight(),
                    ThreeJS.camera(0.0, 0.0, 400.0)
                ]
            )
end
