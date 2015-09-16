import Compat
using Colors
export mesh, box, sphere, pyramid, cylinder, torus, parametric, meshlines,
       material, camera, pointlight, spotlight, ambientlight, vertex, line,
       linematerial, geometry, face, dodecahedron, icosahedron, octahedron,
       tetrahedron

"""
Creates a Three-js mesh at position (`x`,`y`,`z`).
Keyword arguments for rotation are available, being `rx`, `ry` and `rz` for
rotation about X, Y and Z axes respectively. These are to be specified in
degrees.
Geometry and Material tags are added as children to this Elem, to render a mesh.
"""
function mesh(
        x::Float64,
        y::Float64,
        z::Float64;
        rx::Float64 = 0.0,
        ry::Float64 = 0.0,
        rz::Float64 = 0.0,
    )
    Elem(
        :"three-js-mesh",
        attributes = (@compat Dict(
            :x => x, :y => y, :z => z, :rx => rx, :ry => ry, :rz => rz
        ))
    )
end

"""
Creates a Box geometry of width `w`, height `h` and depth `d`.
Should be put in a `mesh` along with another material Elem to render.
"""
function box(w::Float64,h::Float64,d::Float64)
   Elem(:"three-js-box", attributes = @compat Dict(:w=>w, :h=>h, :d=>d))
end

"""
Creates a Sphere geometry of radius `r`.
Should be put in a `mesh` along with another material Elem to render.
"""
function sphere(r::Float64)
    Elem(:"three-js-sphere", attributes = @compat Dict(:r=>r))
end

"""
Creates a square base Pyramid geometry of base `b` and height `h`.
Should be put in a `mesh` along with another material Elem to render.
"""
function pyramid(b::Float64,h::Float64)
    Elem(:"three-js-pyramid", attributes = @compat Dict(:base => b, :height => h))
end

"""
Creates a Cylinder geometry of bottom radius `bottom`, top radius `top` and
height `h`.
Should be put in a `mesh` along with another material Elem to render.
"""
function cylinder(top::Float64,bottom::Float64,height::Float64)
    Elem(
        :"three-js-cylinder",
        attributes = @compat Dict(:top => top, :bottom => bottom, :height => height)
    )
end

"""
Creates a Torus geometry of radius `radius` and tube radius `tube`.
Should be put in a `mesh` along with another material Elem to render.
"""
function torus(radius::Float64,tube::Float64)
    Elem(
        :"three-js-torus",
        attributes = @compat Dict(:r => radius, :tube => tube)
    )
end

"""
Creates a Dodecahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.
"""
function dodecahedron(radius::Float64)
    Elem(
        :"three-js-dodecahedron",
        attributes = @compat Dict(:r => radius)
    )
end

"""
Creates a icosahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.
"""
function icosahedron(radius::Float64)
    Elem(
        :"three-js-icosahedron",
        attributes = @compat Dict(:r => radius)
    )
end

"""
Creates a icosahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.
"""
function octahedron(radius::Float64)
    Elem(
        :"three-js-octahedron",
        attributes = @compat Dict(:r => radius)
    )
end

"""
Creates a tetrahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.
"""
function tetrahedron(radius::Float64)
    Elem(
        :"three-js-tetrahedron",
        attributes = @compat Dict(:r => radius)
    )
end

"""
Creates a geometry.
This should be a child of a `mesh`.
Vertices of the geometry are specified as `vertex` children of the `geometry`
element. Faces are specified as `face` children.
Total number of vertices and total number of faces are arguments to this
function.
"""
function geometry(totalvertices::Int, totalfaces::Int)
    Elem(
        :"three-js-geometry",
        attributes = @compat Dict(
            :totalvertices => totalvertices,
            :totalfaces => totalfaces
        )
    )
end

"""
Creates a face with vertex indices `a`, `b` and `c`.

A keyword argument `color` is accepted setting the color of the face.
NOTE: Face colors come into effect only when the related material has
`FaceColors` as its `colorkind` property.
"""
function face(a::Int, b::Int, c::Int; color::RGB{U8} = colorant"white")
    colorString = string("#"*hex(color))
    Elem(
        :"three-js-face",
        attributes = @compat Dict(
            :a => a, :b => b, :c => c, :faceColor => colorString
        )
    )
end

"""
Creates a vertex at position `(x,y,z)`.
A keyword argument of `color` can also be passed to set the vertex color to that
color.
"""
function vertex(x::Float64,y::Float64,z::Float64; color::Colors.Color=colorant"black")
    colorString = string("#"*hex(color))
    Elem(
        :"three-js-vertex",
        attributes = @compat Dict(:x => x, :y => y, :z => z, :color => colorString)
    )
end

"""
Creates a parametric surface.
Takes `x` values between `xrange` divided into `slices+1` equal intervals.
Takes `y` values between `yrange` divided into `stacks+1` equal intervals.
Applies a function `f` passed to all such `x` and `y` values and creates vertices
of coordinates `(x,y,z)` and a surface containing these vertices.

A colormap can also be passed to set the vertice colors to a corresponding color
using the keyword argument `colormap`.
NOTE: Such colors will be displayed only with a `material` with `colorkind` set
to `"vertex"` and `color` to `"white"`.
"""
function parametric{T<:Colors.Color}(
    slices::Int,
    stacks::Int,
    xrange::Range,
    yrange::Range,
    f::Function;
    colormap::AbstractVector{T} = Colors.colormap("RdBu")
    )
    geom = Elem(
        :"three-js-parametric",
        attributes = @compat Dict(:slices => slices, :stacks => stacks)
    )
    xrange = linspace(xrange.start, xrange.stop, slices+1)
    yrange = linspace(yrange.start, yrange.stop, stacks+1)
    zs = [f(x,y) for x=xrange, y=yrange]
    zrange = maximum(zs) - minimum(zs)
    zmax = maximum(zs)
    colormaplength = length(colormap)
    vertices = [
                    vertex(
                        x, f(x,y), y;
                        color = colormap[ceil(Int,(zmax - f(x,y))/zrange * (colormaplength-1)+1)]
                    )
                    for x=xrange, y=yrange
                ]
    geom = geom << vertices
end

"""
Creates a mesh plot.
Takes `x` values between `xrange` divided into `slices+1` equal intervals.
Takes `y` values between `yrange` divided into `stacks+1` equal intervals.
Applies a function `f` passed to all such `x` and `y` values and creates
vertices of coordinates `(x,y,z)` and a joins them horizontally and vertically,
creating a mesh

A colormap can also be passed to set the vertice colors to a corresponding color
using the keyword argument `colormap`.
NOTE: Such colors will be displayed only with a `material` with `colorkind` set
to `"vertex"` and `color` to `"white"`.
"""
function meshlines{T<:Colors.Color}(
    slices::Int,
    stacks::Int,
    xrange::Range,
    yrange::Range,
    f::Function,
    colormap::AbstractVector{T} = Colors.colormap("RdBu")
    )
    geom = Elem(
        :"three-js-meshlines",
        attributes = @compat Dict( :slices => slices, :stacks => stacks)
    )
    xrange = linspace(xrange.start, xrange.stop, slices+1)
    yrange = linspace(yrange.start, yrange.stop, stacks+1)
    zs = [f(x,y) for x=xrange, y=yrange]
    zrange = maximum(zs) - minimum(zs)
    zmax = maximum(zs)
    colormaplength = length(colormap)
    vertices = [
                    vertex(
                        x, f(x,y), y;
                        color = colormap[ceil(Int,(zmax - f(x,y))/zrange * (colormaplength-1)+1)]
                    )
                    for x=xrange, y=yrange
                ]
    geom = geom << vertices
end

"""
Creates a material tag with properties passed in as a dictionary.
"""
function material(props::Dict=@compat Dict())
    Elem(:"three-js-material", attributes = props)
end

"""
Creates a camera tag.
Perspective camera at position `(x,y,z)` created. Keyword arguments of `near`,
`far`,`aspect`, and `fov` is accepted.
"""
function camera(
    x::Float64,
    y::Float64,
    z::Float64;
    fov::Float64=45.0,
    aspect::Float64=16/9,
    near::Float64=0.1,
    far::Float64=10000.0
    )
    Elem(
        :"three-js-camera",
        attributes = @compat Dict(
            :x => x, :y => y,:z => z,
            :fov => fov,:aspect => aspect, :near => near, :far => far
        )
    )
end

"""
Creates a point light tag.
A point light at position `(x,y,z)` is created. Keyword arguments of `color`
setting the color of the light, `intensity` and `distance` for setting the
intensity and distance properties are also accepted.
"""
function pointlight(
    x::Float64,
    y::Float64,
    z::Float64;
    color::Colors.RGB{U8}=colorant"white",
    intensity::Float64=1.0,
    distance::Float64=0.0
    )
    colorString = string("#"*hex(color))
    Elem(
        :"three-js-light",
        attributes = @compat Dict(
            :x => x, :y => y, :z => z,
            :kind => "point",
            :color => colorString,
            :intensity => intensity,
            :distance => distance
        )
    )
end

"""
Creates a spot light tag.
A spot light at position `(x,y,z)` is created. Keyword arguments of `color`
setting the color of the light, `intensity`, `distance`, `angle`, `exponent`,
`shadow` for setting the intensity, distance, angle(in degrees) and exponent
properties are also accepted. `Shadow` is a `Bool` to set if shadows are
enabled or not.
"""
function spotlight(
    x::Float64,
    y::Float64,
    z::Float64;
    color::Colors.RGB{U8}=colorant"white",
    intensity::Float64=1.0,
    distance::Float64=0.0,
    angle::Float64=60.0,
    exponent::Float64=8.0,
    shadow::Bool=false
    )
    colorString = string("#"*hex(color))
    Elem(
        :"three-js-light",
        attributes = @compat Dict(
            :x => x, :y => y, :z => z,
            :kind => "spot",
            :color => colorString,
            :intensity => intensity,
            :distance => distance,
            :angle => angle,
            :exponent => exponent,
            :shadow => shadow
        )
    )
end

"""
Creates an ambient light tag.
Ambient light is applied equally to all objects.
The color of the light is set using the `color` argument.
"""
function ambientlight(color::Colors.RGB{U8}=colorant"white")
    colorString = string("#"*hex(color))
    Elem(
        :"three-js-light",
        attributes = @compat Dict(:kind => "ambient", :color => colorString)
    )
end

"""
Creates a line tag.
Line tags should be a child of the scene tag created by `initscene`.
Vertices of the line to be drawn should be nested inside this
tag using `vertex`.
The material to be associated with the line can be set using
`linematerial` which should also be a child of the line tag.
Requires the total number of vertices in the line as an argument.
A keyword argument, `kind` is also provided to set how the lines
should be drawn. `"strip"` and `"pieces"` are the possible values.

The line can be translated and rotated using keyword arguments,
`x`,`y`,`z` for the (x, y, z) coordinate and `rx`, `ry` and `rz`
as the rotation about the X, Y and Z axes respectively.
"""
function line(
        totalvertices::Int;
        x::Float64 = 0.0,
        y::Float64 = 0.0,
        z::Float64 = 0.0,
        rx::Float64 = 0.0,
        ry::Float64 = 0.0,
        rz::Float64 = 0.0,
        kind::String = "strip"
    )
    Elem(
        :"three-js-line",
        attributes = @compat Dict(
            :totalvertices => totalvertices,
            :x => x,
            :y => y,
            :z => z,
            :rx => rx,
            :ry => ry,
            :rz => rz,
            :kind => kind,
        )
    )
end

"""
Creates a line material tag.
These tags should be the child of a line tag.
Possible properties that can be set are:
    - `kind` - `"basic"` or `"dashed"`
    - `color` - Any CSS color value.
    - `linewidth` - Sets the width of the line.
    - `scale` - For `"dashed"` only. Scale of the dash.
    - `dashSize` -  For `"dashed"` only. Sets size of the dash.
    - `linecap` - Ends of the line. Possible values are `"round"`, `"butt"`, and
    `"square"`.
    - `linejoin` - Appearance of line joins. Possible values are `"round"`,
    `"bevel"` and `"miter"`.
Refer the ThreeJS docs for [`LineDashedMaterial`](http://threejs.org/docs/#Reference/Materials/LineDashedMaterial)
and [`LineBasicMaterial`](http://threejs.org/docs/#Reference/Materials/LineBasicMaterial)
for more details.

These properties should be passed in as a `Dict`.
"""
function linematerial(props = @compat Dict())
    Elem(:"three-js-line-material", attributes = props)
end
