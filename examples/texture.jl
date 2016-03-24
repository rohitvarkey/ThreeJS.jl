import ThreeJS 

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    ThreeJS.outerdiv() << 
    (ThreeJS.initscene() <<
        [
            ThreeJS.mesh(0.0, 0.0, 0.0) << 
            [
                #Any accessible URL can be provided to the texture attribute to render it as texture
                ThreeJS.box(2.0, 2.0, 2.0),
                ThreeJS.material(Dict(:kind=>"texture",:texture=>"assets/crate.png"))
            ],
            ThreeJS.mesh(3.0, 3.0, 3.0) << 
            [
                ThreeJS.plane(2.0, 2.0),
                ThreeJS.material(Dict(:kind=>"texture",:texture=>"assets/doge.png"))
            ],
            ThreeJS.pointlight(10.0, 10.0, 10.0),
            ThreeJS.camera(0.0, 0.0, 20.0)
        ]
    )
end
