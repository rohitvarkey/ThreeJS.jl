module ThreeJSTest

using ThreeJS
using FactCheck
using Colors
using Compat

import Patchwork: Elem
# write your own tests here
facts("Testing General Functions") do
    context("Testing outerdiv") do
        @fact outerdiv() -->
            Elem(
                :div,
                style=@compat Dict(:width=>"100%", :height=>"600px")
            )
        @fact outerdiv("90%","200px") -->
            Elem(
                :div,
                style=@compat Dict(:width=>"90%", :height=>"200px")
            )
    end
    context("Testing initscene") do
        @fact initscene() --> Elem(:"three-js")
    end
end

facts("Testing Render Elem Outputs") do
    context("Testing mesh") do
        @fact mesh(10.0, 10.0, 10.0) -->
            Elem(
                :"three-js-mesh",
                attributes = @compat Dict(
                    :x => 10.0,
                    :y => 10.0,
                    :z => 10.0,
                    :rx => 0.0,
                    :ry => 0.0,
                    :rz => 0.0
                )
            )
        @fact mesh(10.0, 10.0, 10.0, rx = 20.0, ry = 15.0, rz = 240.0) -->
             Elem(
                :"three-js-mesh",
                attributes = @compat Dict(
                    :x => 10.0,
                    :y => 10.0,
                    :z => 10.0,
                    :rx => 20.0,
                    :ry => 15.0,
                    :rz => 240.0
                )
            )
    end
    context("Testing geometry tags") do
        @fact box(10.0, 11.0, 12.0) -->
            Elem(
                :"three-js-box",
                attributes = @compat Dict(:w => 10.0, :h => 11.0, :d => 12.0)
            )
        @fact sphere(10.0) -->
            Elem(:"three-js-sphere", attributes = @compat Dict(:r => 10.0))
        @fact pyramid(10.0, 12.0) -->
            Elem(
                :"three-js-pyramid",
                attributes = @compat Dict(:base => 10.0, :height => 12.0)
            )
        @fact cylinder(10.0, 11.0, 12.0) -->
            Elem(
                :"three-js-cylinder",
                attributes = @compat Dict(:top => 10.0, :bottom => 11.0, :height => 12.0)
            )
        @fact torus(12.0, 2.0) -->
            Elem(:"three-js-torus", attributes = @compat Dict(:r => 12.0, :tube => 2.0))
        @fact plane(12.0, 2.0) -->
            Elem(:"three-js-plane", attributes = @compat Dict(:w => 12.0, :h => 2.0))
        colormap = Colors.colormap("RdBu")
        zs = [0.0, 1.0, 2.0, 1.0, 2.0, 3.0, 2.0, 3.0, 4.0, 3.0, 4.0, 5.0]
        colors = map(z -> "#"*hex(colormap[ceil(Int,(5-z)/5 * (100-1)+1)]), zs)
        @fact parametric(2, 3, 0:2, 0:3, (x, y) -> x + y) -->
            Elem(
                :"three-js-parametric",
                attributes = @compat Dict(:slices => 2, :stacks => 3)
            ) <<
                [
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 0.0, :z => 0.0, :y => 0.0, :color => colors[1]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 1.0, :z => 0.0, :y => 1.0, :color => colors[2]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 2.0, :z => 0.0, :y => 2.0, :color => colors[3]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 0.0, :z => 1.0, :y => 1.0, :color => colors[4]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 1.0, :z => 1.0, :y => 2.0, :color => colors[5]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 2.0, :z => 1.0, :y => 3.0, :color => colors[6]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 0.0, :z => 2.0, :y => 2.0, :color => colors[7]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 1.0, :z => 2.0, :y => 3.0, :color => colors[8]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 2.0, :z => 2.0, :y => 4.0, :color => colors[9]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 0.0, :z => 3.0, :y => 3.0, :color => colors[10]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 1.0, :z => 3.0, :y => 4.0, :color => colors[11]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 2.0, :z => 3.0, :y => 5.0, :color => colors[12]
                        )
                    ),
                ]
        @fact meshlines(2, 3, 0:2, 0:3, (x, y) -> x + y) -->
            Elem(
                :"three-js-meshlines",
                attributes = @compat Dict(:slices => 2, :stacks => 3)
            ) <<
                [
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 0.0, :z => 0.0, :y => 0.0, :color => colors[1]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 1.0, :z => 0.0, :y => 1.0, :color => colors[2]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 2.0, :z => 0.0, :y => 2.0, :color => colors[3]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 0.0, :z => 1.0, :y => 1.0, :color => colors[4]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 1.0, :z => 1.0, :y => 2.0, :color => colors[5]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 2.0, :z => 1.0, :y => 3.0, :color => colors[6]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 0.0, :z => 2.0, :y => 2.0, :color => colors[7]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 1.0, :z => 2.0, :y => 3.0, :color => colors[8]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 2.0, :z => 2.0, :y => 4.0, :color => colors[9]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 0.0, :z => 3.0, :y => 3.0, :color => colors[10]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 1.0, :z => 3.0, :y => 4.0, :color => colors[11]
                        )
                    ),
                    Elem(
                        :"three-js-vertex",
                        attributes = @compat Dict(
                            :x => 2.0, :z => 3.0, :y => 5.0, :color => colors[12]
                        )
                    ),
                ]
        @fact dodecahedron(4.0) --> 
            Elem(:"three-js-dodecahedron", attributes = @compat Dict(:r => 4.0))
        @fact icosahedron(4.0) --> 
            Elem(:"three-js-icosahedron", attributes = @compat Dict(:r => 4.0))
        @fact octahedron(4.0) --> 
            Elem(:"three-js-octahedron", attributes = @compat Dict(:r => 4.0))
        @fact tetrahedron(4.0) --> 
            Elem(:"three-js-tetrahedron", attributes = @compat Dict(:r => 4.0))
    end
    context("Testing vertex") do
        @fact vertex(2.0, 3.0, 4.0) -->
            Elem(
                :"three-js-vertex",
                attributes = @compat Dict(
                    :x => 2.0, :y => 3.0, :z => 4.0, :color => "#000000"
                )
            )
    end
    context("Testing face") do
        @fact face(1, 2, 3) -->
            Elem(
                :"three-js-face",
                attributes = @compat Dict(
                    :a => 1, :b => 2, :c => 3, :faceColor => "#FFFFFF"
                )
            )
        @fact face(1, 2, 3; color = colorant"red") -->
            Elem(
                :"three-js-face",
                attributes = @compat Dict(
                    :a => 1, :b => 2, :c => 3, :faceColor => "#FF0000"
                )
            )
    end
    context("Testing geometry") do
        @fact geometry(4, 5) -->
            Elem(
                :"three-js-geometry",
                attributes = @compat Dict(:totalvertices => 4, :totalfaces => 5)
            )
        verts = [(i, i, i) for i = 1.0:3.0]
        faces = [(1 , 2, 3)]
        @fact geometry(verts, faces) -->
            Elem(
                :"three-js-geometry",
                attributes = @compat Dict(:totalvertices => 3, :totalfaces => 1)
            ) << 
            [
                Elem(
                    :"three-js-vertex",
                    attributes = @compat Dict(
                        :x => 1.0, :y => 1.0, :z => 1.0, :color => "#000000"
                    )
                ),
                Elem(
                    :"three-js-vertex",
                    attributes = @compat Dict(
                        :x => 2.0, :y => 2.0, :z => 2.0, :color => "#000000"
                    )
                ),
                Elem(
                    :"three-js-vertex",
                    attributes = @compat Dict(
                        :x => 3.0, :y => 3.0, :z => 3.0, :color => "#000000"
                    )
                ),
                Elem(
                    :"three-js-face",
                    attributes = @compat Dict(
                        :a => 0, :b => 1, :c =>2, :faceColor => "#FFFFFF"
                    )
                )
            ]
    end
    context("Testing light tags") do
        @fact pointlight(10.0, 11.0, 12.0) -->
            Elem(
                :"three-js-light",
                attributes = @compat Dict(
                :x => 10.0, :y => 11.0 , :z => 12.0,
                :kind => "point",
                :color => "#FFFFFF",
                :intensity => 1.0,
                :distance => 0.0
                )
            )
        @fact pointlight(
            10.0, 11.0, 12.0,
            intensity = 2.0, distance = 1000.0, color = colorant"red"
            ) --> Elem(
                :"three-js-light",
                attributes = @compat Dict(
                    :x => 10.0, :y => 11.0 , :z => 12.0,
                    :kind => "point",
                    :color => "#FF0000",
                    :intensity => 2.0,
                    :distance => 1000.0
                )
        )
        @fact spotlight(10.0, 11.0, 12.0) -->
            Elem(
                :"three-js-light",
                attributes = @compat Dict(
                    :x => 10.0, :y => 11.0 , :z => 12.0,
                    :kind => "spot",
                    :color => "#FFFFFF",
                    :intensity => 1.0,
                    :distance => 0.0,
                    :angle => 60.0,
                    :exponent => 8.0,
                    :shadow => false
                )
            )
        @fact spotlight(
            10.0, 11.0, 12.0,
            intensity = 2.0, distance = 1000.0, color = colorant"red",
            angle = 45.0, exponent = 10.0, shadow = true
            ) --> Elem(
                :"three-js-light",
                attributes = @compat Dict(
                    :x => 10.0, :y => 11.0 , :z => 12.0,
                    :kind => "spot",
                    :color => "#FF0000",
                    :intensity => 2.0,
                    :distance => 1000.0,
                    :angle => 45.0,
                    :exponent => 10.0,
                    :shadow => true
                )
            )
        @fact ambientlight() -->
            Elem(
                :"three-js-light",
                attributes = @compat Dict(:kind => "ambient", :color => "#FFFFFF")
            )
        @fact ambientlight(colorant"red") -->
            Elem(
                :"three-js-light",
                attributes = @compat Dict(:kind => "ambient", :color => "#FF0000")
            )
    end
    context("Testing camera tag") do
        @fact camera(10.0, 11.0, 12.0) -->
            Elem(
                :"three-js-camera",
                attributes = @compat Dict(
                    :x => 10.0,
                    :y => 11.0,
                    :z => 12.0,
                    :fov => 45.0,
                    :aspect => 16/9,
                    :near => 0.1,
                    :far => 10000.0
                )
            )
    end
    context("Testing line") do
        @fact line(4, x = 10.0, y = 10.0, z = 10.0, rx = 20.0, ry = 15.0,
                   rz = 240.0, kind = "pieces") -->
             Elem(
                :"three-js-line",
                attributes = @compat Dict(
                    :totalvertices => 4,
                    :kind => "pieces",
                    :x => 10.0,
                    :y => 10.0,
                    :z => 10.0,
                    :rx => 20.0,
                    :ry => 15.0,
                    :rz => 240.0
                )
            )
        @fact line(4) -->
             Elem(
                :"three-js-line",
                attributes = @compat Dict(
                    :totalvertices => 4,
                    :kind => "strip",
                    :x => 0.0,
                    :y => 0.0,
                    :z => 0.0,
                    :rx => 0.0,
                    :ry => 0.0,
                    :rz => 0.0
                )
            )
    end
    context("Testing line material") do
        @fact linematerial() --> Elem(:"three-js-line-material", attributes=@compat Dict())
        @fact linematerial(@compat Dict(:kind=>"dashed", :color=>"red")) -->
            Elem(
            :"three-js-line-material",
            attributes = @compat Dict(
                :kind => "dashed",
                :color => "red"
            )
        )
    end
    context("Testing material") do
        @fact material() --> Elem(:"three-js-material", attributes = @compat Dict())
        @fact material(@compat Dict(:kind=>"basic", :color=>"red")) -->
            Elem(
            :"three-js-material",
            attributes = @compat Dict(
                :kind => "basic",
                :color => "red"
            )
        )
    end
    context("Testing grid") do
        @fact grid(10.0, 1.0) --> Elem(
            :"three-js-grid",
            attributes = Dict(
                :size => 10.0,
                :step => 1.0,
                :x => 0.0,
                :y => 0.0,
                :z => 0.0,
                :rx => 0.0,
                :ry => 0.0,
                :rz => 0.0,
                :colorgrid => "#000000",
                :colorcenter => "#000000"
            )
        )
        @fact grid(
            10.0, 2.0, x = 10.0, colorgrid = colorant"red",
            colorcenter = colorant"green", ry = 10.0
        ) --> Elem(
            :"three-js-grid",
            attributes = Dict(
                :size => 10.0,
                :step => 2.0,
                :x => 10.0,
                :y => 0.0,
                :z => 0.0,
                :rx => 0.0,
                :ry => 10.0,
                :rz => 0.0,
                :colorgrid => "#FF0000",
                :colorcenter => "#008000"
            )
        )
    end
end

facts("Testing property helpers") do
    context("Testing meshcolor") do
        @fact meshcolor(colorant"red") --> (:color, "#FF0000")
    end
    context("Testing kinds") do
        @fact lambert() --> (:kind, "lambert")
        @fact basic() --> (:kind, "basic")
        @fact phong() --> (:kind, "phong")
        @fact normal() --> (:kind, "normal")
    end
    context("Testing wireframe") do
        @fact wireframe() --> (:wireframe, true)
        @fact wireframe(false) --> (:wireframe, false)
    end
    context("Testing visibility") do
        @fact visible() --> (:visible, true)
        @fact visible(false) --> (:visible, false)
    end
end

FactCheck.exitstatus()
end
