import ThreeJS
import Colors: distinguishable_colors
main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    ts = linspace(0,8π,250);
    x = map(cos,ts)
    y = 0.1ts .* map(sin,ts)
    z = linspace(0,100,250)
    vertices = Tuple{Float64, Float64, Float64}[(x[i]*25,z[i],y[i]*25) for i in 1:size(x,1)]
    ThreeJS.outerdiv() <<
            (ThreeJS.initscene() <<
                [
                    ThreeJS.line(vertices) <<
                    [
                        ThreeJS.linematerial(Dict(:color=>"blue"))
                    ],
                    ThreeJS.pointcloud(collect(zip(y*25,z,x*25)), vertexcolors=distinguishable_colors(size(x,1))) <<
                    [
                        ThreeJS.pointmaterial(Dict(:color=>"white", :texture=>"/assets/disc.png", :transparent=>true, :size=>5.0, :colorkind=>"vertex", :alphatest=>0.5))
                    ],
                    ThreeJS.ambientlight(),
                    ThreeJS.camera(0.0, 0.0, 400.0)
                ]
            )
end
