import ThreeJS

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    w = Signal(1.0)
    h = Signal(1.0)
    d = Signal(1.0)
    rx = Signal(0.0)
    ry = Signal(0.0)
    rz = Signal(0.0)
    o = Signal(1.0)
    vbox(
        "ThreeJS Example",
        vskip(2em),
        hbox(
            vbox(
                "Sides",
                hbox("width",slider(1.0:5.0) >>> w),
                hbox("height",slider(1.0:5.0) >>> h),
                hbox("depth",slider(1.0:5.0) >>> d),
            ),
            hskip(2em),
            vbox(
                "Rotations",
                hbox("x", slider(0.0:5.0:360.0) >>> rx),
                hbox("y", slider(0.0:5.0:360.0) >>> ry),
                hbox("z", slider(0.0:5.0:360.0) >>> rz),
            ),
            hbox("opacity",slider(0.0:0.1:1.0, value = 1.0) >>> o),
        ),
        vskip(2em),
        map(w, h, d, rx, ry, rz, o) do w, h, d, rx, ry, rz, o
        ThreeJS.outerdiv() <<
            (ThreeJS.initscene() <<
                [
                    ThreeJS.mesh(0.0, 0.0, 0.0, rx = rx, ry = ry, rz = rz) <<
                    [
                        ThreeJS.box(w, h, d), ThreeJS.material(Dict(:kind=>"lambert",:color=>"red", :transparent=>true, :opacity=>o))
                    ],
                    ThreeJS.pointlight(10.0, 10.0, 10.0),
                    ThreeJS.camera(0.0, 0.0, 10.0)
                ]
            )
        end
    ) |> pad(2em)
end
