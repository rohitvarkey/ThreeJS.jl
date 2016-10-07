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
                style=Dict(:width=>"100%", :height=>"600px")
            )
        @fact outerdiv("90%","200px") -->
            Elem(
                :div,
                style=Dict(:width=>"90%", :height=>"200px")
            )
    end
    context("Testing initscene") do
        @fact initscene() --> Elem(
            :"three-js",
            attributes = Dict(:bgcolor => "#FFFFFF")
        )
        @fact initscene(bgcolor=colorant"black") --> Elem(
            :"three-js",
            attributes = Dict(:bgcolor => "#000000")
        )
    end
end

facts("Testing Render Elem Outputs") do
    context("Testing mesh") do
        @fact mesh(10.0, 10.0, 10.0) -->
            Elem(
                :"three-js-mesh",
                attributes = Dict(
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
                attributes = Dict(
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
                attributes = Dict(:width => 10.0, :height => 11.0, :depth => 12.0)
            )
        @fact sphere(10.0) -->
            Elem(:"three-js-sphere", attributes = Dict(:r => 10.0))
        @fact pyramid(10.0, 12.0) -->
            Elem(
                :"three-js-pyramid",
                attributes = Dict(:base => 10.0, :height => 12.0)
            )
        @fact cylinder(10.0, 11.0, 12.0) -->
            Elem(
                :"three-js-cylinder",
                attributes = Dict(:top => 10.0, :bottom => 11.0, :height => 12.0)
            )
        @fact torus(12.0, 2.0) -->
            Elem(:"three-js-torus", attributes = Dict(:r => 12.0, :tube => 2.0))
        @fact plane(12.0, 2.0) -->
            Elem(:"three-js-plane", attributes = Dict(:w => 12.0, :h => 2.0))
        colormap = Colors.colormap("RdBu")
        ys = [
                0.0 1.0 2.0 3.0
                1.0 2.0 3.0 4.0
                2.0 3.0 4.0 5.0
             ]
        hexcolors = map(z -> "#"*hex(colormap[ceil(Int,(5-z)/5 * (100-1)+1)]), ys)
        colors = Array{Color}(3,4)
        map!(z -> colormap[ceil(Int,(5-z)/5 * (100-1)+1)], colors, ys)
        @fact parametric(2, 3, 0:2, 0:3, (x, y) -> x + y) -->
            Elem(
                :"three-js-parametric",
                attributes = Dict(
                    :slices => 2,
                    :stacks => 3,
                    :x => [
                        0.0 0.0 0.0 0.0
                        1.0 1.0 1.0 1.0
                        2.0 2.0 2.0 2.0
                    ],
                    :y => ys,
                    :z => [
                        0.0 1.0 2.0 3.0
                        0.0 1.0 2.0 3.0
                        0.0 1.0 2.0 3.0
                    ],
                    :vertexcolors => hexcolors
                    )
            )
        @fact meshlines(2, 3, 0:2, 0:3, (x, y) -> x + y) -->
            map(x->x << linematerial(Dict(:color=>"white", :colorkind=>"vertex")),
                [
                line(
                    [(0.0, 0.0, 0.0), (1.0, 1.0, 0.0), (2.0, 2.0, 0.0)],
                    vertexcolors= colors[:, 1]
                ),
                line(
                    [(0.0, 1.0, 1.0), (1.0, 2.0, 1.0), (2.0, 3.0, 1.0)],
                    vertexcolors= colors[:, 2]
                ),
                line(
                    [(0.0, 2.0, 2.0), (1.0, 3.0, 2.0), (2.0, 4.0, 2.0)],
                    vertexcolors= colors[:, 3]
                ),
                line(
                    [(0.0, 3.0, 3.0), (1.0, 4.0, 3.0), (2.0, 5.0, 3.0)],
                    vertexcolors= colors[:, 4]
                ),
                line(
                    [(0.0, 0.0, 0.0), (0.0, 1.0, 1.0), (0.0, 2.0, 2.0), (0.0, 3.0, 3.0)],
                    vertexcolors= reshape(transpose(colors[1, :]), 4)),
                line(
                    [(1.0, 1.0, 0.0), (1.0, 2.0, 1.0), (1.0, 3.0, 2.0), (1.0, 4.0, 3.0)],
                    vertexcolors= reshape(transpose(colors[2, :]), 4)),
                line(
                    [(2.0, 2.0, 0.0), (2.0, 3.0, 1.0), (2.0, 4.0, 2.0), (2.0, 5.0, 3.0)],
                    vertexcolors= reshape(transpose(colors[3, :]), 4))
                ]
            )
        @fact dodecahedron(4.0) -->
            Elem(:"three-js-dodecahedron", attributes = Dict(:r => 4.0))
        @fact icosahedron(4.0) -->
            Elem(:"three-js-icosahedron", attributes = Dict(:r => 4.0))
        @fact octahedron(4.0) -->
            Elem(:"three-js-octahedron", attributes = Dict(:r => 4.0))
        @fact tetrahedron(4.0) -->
            Elem(:"three-js-tetrahedron", attributes = Dict(:r => 4.0))
        verts = [(i, i, i) for i = 1.0:3.0]
    end
    context("Testing geometry") do
        verts = [(i, i, i) for i = 1.0:3.0]
        faces = [(1 , 2, 3)]
        @fact geometry(verts, faces) -->
            Elem(
                :"three-js-geometry",
                attributes = Dict(
                    :x => [1.0, 2.0, 3.0],
                    :y => [1.0, 2.0, 3.0],
                    :z => [1.0, 2.0, 3.0],
                    :faces => [0, 1, 2]
                )
            )
    end
    context("Testing light tags") do
        @fact pointlight(10.0, 11.0, 12.0) -->
            Elem(
                :"three-js-light",
                attributes = Dict(
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
                attributes = Dict(
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
                attributes = Dict(
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
                attributes = Dict(
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
                attributes = Dict(:kind => "ambient", :color => "#FFFFFF")
            )
        @fact ambientlight(colorant"red") -->
            Elem(
                :"three-js-light",
                attributes = Dict(:kind => "ambient", :color => "#FF0000")
            )
    end
    context("Testing camera tag") do
        @fact camera(10.0, 11.0, 12.0) -->
            Elem(
                :"three-js-camera",
                attributes = Dict(
                    :x => 10.0,
                    :y => 11.0,
                    :z => 12.0,
                    :fov => 45.0,
                    :aspect => nothing,
                    :near => 1.0,
                    :far => 1000.0
                )
            )
    end
    context("Testing line") do
        verts = [Tuple{Float64, Float64, Float64}((i, i, i)) for i = 1.0:3.0]
        colors = Color[colorant"red", colorant"blue", colorant"green"]
        vertswithcolors = [Tuple{Float64, Float64, Float64, Color}(
            (verts[i][1], verts[i][2], verts[i][3], colors[i])
        ) for i=1:3]
        @fact line(
        verts, x = 10.0, y = 10.0, z = 10.0, rx = 20.0, ry = 15.0, rz = 240.0,
        kind = "pieces", vertexcolors = colors) -->
             Elem(
                :"three-js-line",
                attributes = Dict(
                    :kind => "pieces",
                    :x => 10.0,
                    :y => 10.0,
                    :z => 10.0,
                    :rx => 20.0,
                    :ry => 15.0,
                    :rz => 240.0,
                    :xs => [1.0, 2.0, 3.0],
                    :ys => [1.0, 2.0, 3.0],
                    :zs => [1.0, 2.0, 3.0],
                    :vertexcolors => map(x->"#"*hex(x),colors)
                )
            )
        @fact line(
        vertswithcolors, x = 10.0, y = 10.0, z = 10.0, rx = 20.0, ry = 15.0,
        rz = 240.0, kind = "pieces") -->
             Elem(
                :"three-js-line",
                attributes = Dict(
                    :kind => "pieces",
                    :x => 10.0,
                    :y => 10.0,
                    :z => 10.0,
                    :rx => 20.0,
                    :ry => 15.0,
                    :rz => 240.0,
                    :xs => [1.0, 2.0, 3.0],
                    :ys => [1.0, 2.0, 3.0],
                    :zs => [1.0, 2.0, 3.0],
                    :vertexcolors => map(x->"#"*hex(x),colors)
                )
            )
        @fact line(verts) -->
             Elem(
                :"three-js-line",
                attributes = Dict(
                    :kind => "strip",
                    :x => 0.0,
                    :y => 0.0,
                    :z => 0.0,
                    :rx => 0.0,
                    :ry => 0.0,
                    :rz => 0.0,
                    :xs => [1.0, 2.0, 3.0],
                    :ys => [1.0, 2.0, 3.0],
                    :zs => [1.0, 2.0, 3.0],
                    :vertexcolors => Color[]
                )
            )
    end
    context("Testing line material") do
        @fact linematerial() --> Elem(:"three-js-line-material", attributes=Dict())
        @fact linematerial(Dict(:kind=>"dashed", :color=>"red")) -->
            Elem(
            :"three-js-line-material",
            attributes = Dict(
                :kind => "dashed",
                :color => "red"
            )
        )
    end
    context("Testing pointclouds") do
        verts = [Tuple{Float64, Float64, Float64}((i, i, i)) for i = 1.0:3.0]
        colors = Color[colorant"red", colorant"blue", colorant"green"]
        vertswithcolors = [
            Tuple{Float64, Float64, Float64, Color}(
                (verts[i][1], verts[i][2], verts[i][3], colors[i])
            ) for i=1:3
        ]
        @fact pointcloud(
        verts, x = 10.0, y = 10.0, z = 10.0, rx = 20.0, ry = 15.0, rz = 240.0,
        vertexcolors = colors) -->
             Elem(
                :"three-js-points",
                attributes = Dict(
                    :x => 10.0,
                    :y => 10.0,
                    :z => 10.0,
                    :rx => 20.0,
                    :ry => 15.0,
                    :rz => 240.0,
                    :xs => [1.0, 2.0, 3.0],
                    :ys => [1.0, 2.0, 3.0],
                    :zs => [1.0, 2.0, 3.0],
                    :vertexcolors => map(x->"#"*hex(x),colors)
                )
            )
        @fact pointcloud(
        vertswithcolors, x = 10.0, y = 10.0, z = 10.0, rx = 20.0, ry = 15.0,
        rz = 240.0) -->
             Elem(
                :"three-js-points",
                attributes = Dict(
                    :x => 10.0,
                    :y => 10.0,
                    :z => 10.0,
                    :rx => 20.0,
                    :ry => 15.0,
                    :rz => 240.0,
                    :xs => [1.0, 2.0, 3.0],
                    :ys => [1.0, 2.0, 3.0],
                    :zs => [1.0, 2.0, 3.0],
                    :vertexcolors => map(x->"#"*hex(x),colors)
                )
            )
        @fact pointcloud(verts) -->
             Elem(
                :"three-js-points",
                attributes = Dict(
                    :x => 0.0,
                    :y => 0.0,
                    :z => 0.0,
                    :rx => 0.0,
                    :ry => 0.0,
                    :rz => 0.0,
                    :xs => [1.0, 2.0, 3.0],
                    :ys => [1.0, 2.0, 3.0],
                    :zs => [1.0, 2.0, 3.0],
                    :vertexcolors => Color[]
                )
            )
    end
    context("Testing point material") do
        @fact pointmaterial() --> Elem(:"three-js-point-material", attributes=Dict())
        @fact pointmaterial(
            Dict(:color => "red", :size=> 10,
            :attenuation => false, :colorkind => "vertex")
        ) -->
            Elem(
            :"three-js-point-material",
            attributes = Dict(
                :colorkind => "vertex",
                :color => "red",
                :size => 10,
            )
        )
    end
    context("Testing material") do
        @fact material() --> Elem(:"three-js-material", attributes = Dict())
        @fact material(Dict(:kind=>"basic", :color=>"red", :wireframe=>false)) -->
            Elem(
            :"three-js-material",
            attributes = Dict(
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
    context("Testing Text") do
        @fact text(0.0, 0.0, 0.0, "Hello!") --> Elem(
            :"three-js-text",
            attributes = Dict(:x => 0.0, :y => 0.0, :z => 0.0, :content => "Hello!")
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
        @fact visible() --> (:hidden, false)
        @fact visible(false) --> (:hidden, true)
    end
end

FactCheck.exitstatus()
end
