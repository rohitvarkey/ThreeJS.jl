import Compat
using Colors, GeometryTypes, Requires
export mesh, box, sphere, pyramid, cylinder, torus, parametric, meshlines,
       material, camera, pointlight, spotlight, ambientlight, line,
       linematerial, geometry, dodecahedron, icosahedron, octahedron,
       tetrahedron, plane, grid, pointcloud, pointmaterial, text, raycastable

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
        attributes = Dict(
            :x => x, :y => y, :z => z, :rx => rx, :ry => ry, :rz => rz
        )
    )
end

"""
Creates a Box geometry of `width`, `height` and `depth`.
Should be put in a `mesh` along with another material Elem to render.
"""
function box(width::Real, height::Real, depth::Real)
   Elem(:"three-js-box", attributes = Dict(:width=>width, :height=>height, :depth=>depth))
end

"""
Creates a Sphere geometry of radius `r`.
Should be put in a `mesh` along with another material Elem to render.
"""
function sphere(r::Float64)
    Elem(:"three-js-sphere", attributes = Dict(:r=>r))
end

"""
Creates a square base Pyramid geometry of base `b` and height `h`.
Should be put in a `mesh` along with another material Elem to render.
"""
function pyramid(b::Float64,h::Float64)
    Elem(:"three-js-pyramid", attributes = Dict(:base => b, :height => h))
end

"""
Creates a Cylinder geometry of bottom radius `bottom`, top radius `top` and
height `h`.
Should be put in a `mesh` along with another material Elem to render.
"""
function cylinder(top::Float64,bottom::Float64,height::Float64)
    Elem(
        :"three-js-cylinder",
        attributes = Dict(:top => top, :bottom => bottom, :height => height)
    )
end

"""
Creates a Torus geometry of radius `radius` and tube radius `tube`.
Should be put in a `mesh` along with another material Elem to render.
"""
function torus(radius::Float64,tube::Float64)
    Elem(
        :"three-js-torus",
        attributes = Dict(:r => radius, :tube => tube)
    )
end

"""
Creates a Dodecahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.
"""
function dodecahedron(radius::Float64)
    Elem(
        :"three-js-dodecahedron",
        attributes = Dict(:r => radius)
    )
end

"""
Creates a icosahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.
"""
function icosahedron(radius::Float64)
    Elem(
        :"three-js-icosahedron",
        attributes = Dict(:r => radius)
    )
end

"""
Creates a icosahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.
"""
function octahedron(radius::Float64)
    Elem(
        :"three-js-octahedron",
        attributes = Dict(:r => radius)
    )
end

"""
Creates a tetrahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.
"""
function tetrahedron(radius::Float64)
    Elem(
        :"three-js-tetrahedron",
        attributes = Dict(:r => radius)
    )
end

"""
Creates a plane in the XY plane with specified width and height centered
around the origin.
Should be put in a `mesh` along with another material Elem to render.
"""
function plane(width::Real, height::Real)
    Elem(
        :"three-js-plane",
        attributes = Dict(:w => width, :h => height)
    )
end

"""
Creates a geometry.
This should be a child of a `mesh`.
Vertices of the geometry are passed in as a vector of `Tuples` of the coordinates
along with faces of the geometry which are again passed in as a vector of `Tuples`
of `Int` representing the indices of the vertices to be joined.
"""
function geometry(
    vertices::Vector{Tuple{Float64, Float64, Float64}},
    faces::Vector{Tuple{Int, Int, Int}}
    )
    #TODO: Add Vectors accepting facecolors and vertexcolors as keywords
    x = [coords[1] for coords in vertices]
    y = [coords[2] for coords in vertices]
    z = [coords[3] for coords in vertices]
    face = zeros(size(faces,1) * 3)
    for i=1:size(faces, 1)
        face[3i - 2] = faces[i][1] - 1
        face[3i - 1] = faces[i][2] - 1
        face[3i] = faces[i][3] - 1
    end
    geom = Elem(
        :"three-js-geometry",
        attributes = Dict(
            :x => x,
            :y => y,
            :z => z,
            :faces => face,
        )
    )
    geom
end

"""
Create a geometry from an AbstractMesh (via GeometryTypes).
The scale parameter will scale the mesh vertices in the corresponding axis.
"""
function ThreeJS.geometry{VT,N,T,O}(m::AbstractMesh{VT,Face{N,T,O}};scale=(1,1,1))
    vs = [(Float64(i[1])*scale[1],
           Float64(i[2])*scale[2],
           Float64(i[3])*scale[3]) for i in m.vertices]
    fs = [(Int(i[1])-O,Int(i[2])-O,Int(i[3])-O) for i in m.faces]
    ThreeJS.geometry(vs,fs)
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
    xrange = linspace(xrange.start, xrange.stop, slices+1)
    yrange = linspace(yrange.start, yrange.stop, stacks+1)
    xs = [x for x=xrange, y=yrange]
    ys = [y for x=xrange, y=yrange]
    zs = Float64[f(x,y) for x=xrange, y=yrange]
    zrange = maximum(zs) - minimum(zs)
    zmax = maximum(zs)
    colormaplength = length(colormap)
    colors = [
        "#"*hex(colormap[ceil(Int,(zmax - f(x,y))/zrange * (colormaplength-1)+1)])
        for x=xrange, y=yrange
    ]
    geom = Elem(
        :"three-js-parametric",
        attributes = Dict(
            :slices => slices,
            :stacks => stacks,
            :x => xs,
            :y => zs,
            :z => ys,
            :vertexcolors => colors
        )
    )
end

"""
Creates a mesh plot.
Takes `x` values between `xrange` divided into `slices+1` equal intervals.
Takes `y` values between `yrange` divided into `stacks+1` equal intervals.
Applies a function `f` passed to all such `x` and `y` values and creates
vertices of coordinates `(x,y,z)` and a joins them horizontally and vertically,
creating a mesh.

Returns an array of `line` elements which should be under the `scene`.

A colormap can also be passed to set the vertice colors to a corresponding color
using the keyword argument `colormap`.
"""
function meshlines{T<:Colors.Color}(
    slices::Int,
    stacks::Int,
    xrange::Range,
    yrange::Range,
    f::Function;
    colormap::AbstractVector{T} = Colors.colormap("RdBu")
    )
    xrange = linspace(xrange.start, xrange.stop, slices+1)
    yrange = linspace(yrange.start, yrange.stop, stacks+1)
    zs = [f(x,y) for x=xrange, y=yrange]
    zrange = maximum(zs) - minimum(zs)
    zmax = maximum(zs)
    colormaplength = length(colormap)
    findcolor(z::Float64) = colormap[
        ceil(Int,(zmax - z)/zrange * (colormaplength-1)+1)
    ]
    meshmaterial = linematerial(Dict(:color => "white", :colorkind => "vertex"))
    xlines = Elem[
        line(Tuple{Float64, Float64, Float64, Color}[(x, f(x,y), y, findcolor(f(x,y))) for x=xrange]) << meshmaterial
        for y=yrange
    ]
    ylines = Elem[
        line(Tuple{Float64, Float64, Float64, Color}[(x, f(x,y), y, findcolor(f(x,y))) for y=yrange]) << meshmaterial
        for x=xrange
    ]
    [xlines; ylines] #Return all the line elements as an array
end

"""
Creates a material tag with properties passed in as a dictionary.
"""
function material(props::Dict=Dict())
    Elem(:"three-js-material", attributes = filter((k,v)->v!=false, props))
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
    aspect=nothing,
    near::Float64=1.0,
    far::Float64=1000.0
    )
    Elem(
        :"three-js-camera",
        attributes = Dict(
            :x => x, :y => y,:z => z,
            :fov => fov, :aspect => aspect, :near => near, :far => far
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
        attributes = Dict(
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
        attributes = Dict(
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
        attributes = Dict(:kind => "ambient", :color => colorString)
    )
end

"""
Creates a line tag.
Line tags should be a child of the scene tag created by `initscene`.

Vertices of the line to be drawn should be passed in as a `Vector` of
`Tuple{Float64, Float64, Float64}`.
The material to be associated with the line can be set using
`linematerial` which should be a child of the line tag.

A keyword argument, `kind` is also provided to set how the lines
should be drawn. `"strip"` and `"pieces"` are the possible values.

The line can be translated and rotated using keyword arguments,
`x`,`y`,`z` for the (x, y, z) coordinate and `rx`, `ry` and `rz`
as the rotation about the X, Y and Z axes respectively.

Colors for the vertices can be set by passing in a `Vector` of
`Color` as the `vertexcolors` kwarg.
"""
function line{T <: Color}(
        vertices::Vector{Tuple{Float64, Float64, Float64}};
        x::Float64 = 0.0,
        y::Float64 = 0.0,
        z::Float64 = 0.0,
        rx::Float64 = 0.0,
        ry::Float64 = 0.0,
        rz::Float64 = 0.0,
        kind::AbstractString = "strip",
        vertexcolors::Vector{T} = Color[]
    )
    xs = [coords[1] for coords in vertices]
    ys = [coords[2] for coords in vertices]
    zs = [coords[3] for coords in vertices]
    colors = map(x -> "#"*hex(x), vertexcolors)
    Elem(
        :"three-js-line",
        attributes = Dict(
            :xs => xs,
            :ys => ys,
            :zs => zs,
            :x => x,
            :y => y,
            :z => z,
            :rx => rx,
            :ry => ry,
            :rz => rz,
            :kind => kind,
            :vertexcolors => colors
        )
    )
end

"""
Helper function to make creating `line` easier.
`Tuples` of vertices with their color also as part of the `Tuple`
is expected as the argument.
"""
function line{T <: Color}(
        verticeswithcolor::Vector{Tuple{Float64, Float64, Float64, T}};
        x::Float64 = 0.0,
        y::Float64 = 0.0,
        z::Float64 = 0.0,
        rx::Float64 = 0.0,
        ry::Float64 = 0.0,
        rz::Float64 = 0.0,
        kind::AbstractString = "strip"
    )
    vertexcolors = [vertex[4] for vertex in verticeswithcolor]
    vertices = [(vertex[1], vertex[2], vertex[3]) for vertex in verticeswithcolor]
    line(
        vertices,
        x = x,
        y = y,
        z = z,
        rx = rx,
        ry = ry,
        rz = rz,
        kind = kind,
        vertexcolors = vertexcolors
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
function linematerial(props = Dict())
    Elem(:"three-js-line-material", attributes = filter((k,v)-> v!=false, props))
end

"""
Creates a shader material tag.
These tags should be the child of a mesh tag.

The WebGL programs should be passed to `vert` and `frag`. The `defines` and `uniforms`
are dictionaries that map to declarations in the programs. Refer to the ThreeJS docs
for [`ShaderMaterial`](http://threejs.org/docs/api/materials/ShaderMaterial.html)
for more details.
"""
function shadermaterial(vert::AbstractString, frag::AbstractString; defines = Dict(), uniforms = Dict(), kwds...)
    Elem(:"three-js-shader-material"; :vert => vert, :frag => frag,
        :defines => Patchwork.PropHook("escher-property-hook", defines),
        :uniforms => Patchwork.PropHook("escher-property-hook", uniforms),
        kwds...)
end

"""
Creates a data texture tag.
These tags should be the child of a shader material.

The name should be a `sampler2D` in the WebGL programs. The data should be a base64-encoded
string.
"""
function datatexture(name::AbstractString, data::AbstractString, width::Int, height::Int; kwds...)
    Elem(:"three-js-data-texture"; name = name,
        attributes = Dict(
            :data => data,
            :width => width,
            :height => height,
            Dict(kwds)...
        )
    )
end

"""
Convenience function that serializes an array as a base64 string.
"""
function datatexture(name::ASCIIString, data::Array{UInt8, 2}; kwds...)
    datatexture(name, base64encode(data), size(data, 1), size(data, 2);
        :format => "LuminanceFormat", :type => "UnsignedByteType", kwds...)
end


"""
Creates a point cloud tag.
Line tags should be a child of the scene tag created by `initscene`.

Vertices of the points to be drawn should be passed in as a `Vector` of
`Tuple{Float64, Float64, Float64}`.
The material to be associated with the line can be set using
`pointmaterial` which should be a child of the line tag.

The point system can be translated and rotated using keyword arguments,
`x`,`y`,`z` for the (x, y, z) coordinate and `rx`, `ry` and `rz`
as the rotation about the X, Y and Z axes respectively.

Colors for the vertices can be set by passing in a `Vector` of
`Color` as the `vertexcolors` kwarg.
"""
function pointcloud{T <: Color}(
        vertices::Vector{Tuple{Float64, Float64, Float64}};
        x::Float64 = 0.0,
        y::Float64 = 0.0,
        z::Float64 = 0.0,
        rx::Float64 = 0.0,
        ry::Float64 = 0.0,
        rz::Float64 = 0.0,
        vertexcolors::Vector{T} = Color[]
    )
    xs = [coords[1] for coords in vertices]
    ys = [coords[2] for coords in vertices]
    zs = [coords[3] for coords in vertices]
    colors = map(x -> "#"*hex(x), vertexcolors)
    Elem(
        :"three-js-points",
        attributes = Dict(
            :xs => xs,
            :ys => ys,
            :zs => zs,
            :x => x,
            :y => y,
            :z => z,
            :rx => rx,
            :ry => ry,
            :rz => rz,
            :vertexcolors => colors
        )
    )
end

"""
Helper function to make creating `pointcloud`s easier.
`Tuples` of vertices with their color also as part of the `Tuple`
is expected as the argument.
"""
function pointcloud{T<: Color}(
        verticeswithcolor::Vector{Tuple{Float64, Float64, Float64, T}};
        x::Float64 = 0.0,
        y::Float64 = 0.0,
        z::Float64 = 0.0,
        rx::Float64 = 0.0,
        ry::Float64 = 0.0,
        rz::Float64 = 0.0,
    )
    vertexcolors = [vertex[4] for vertex in verticeswithcolor]
    vertices = [(vertex[1], vertex[2], vertex[3]) for vertex in verticeswithcolor]
    pointcloud(
        vertices,
        x = x,
        y = y,
        z = z,
        rx = rx,
        ry = ry,
        rz = rz,
        vertexcolors = vertexcolors
    )
end

"""
Creates a point material tag.
These tags should be the child of a point tag.
Possible properties that can be set are:
    - `color` - Any CSS color value.
    - `size` - Set's size of the points
    - `noattenuation` -  `Bool`. Decides if points should become smaller with
    distance or not.
    - `texture` - Image to be used as texture.
    - `colorkind` - Possible values `"no"`, `"face"`,`"vertex"`
These properties should be passed in as a `Dict`.
    - `alphatest` - Used to discard some fragments when below this value.
"""
function pointmaterial(props = Dict())
    Elem(:"three-js-point-material", attributes = filter((k,v)->v!=false, props))
end

"""
Creates a grid element.
These should be a child of the scene tag created by `initscene`.
The `size` represents the total size and the `step` represents the distance
between consecutive lines of the grid.

The grid can be translated and rotated using keyword arguments,
`x`,`y`,`z` for the (x, y, z) coordinate and `rx`, `ry` and `rz`
as the rotation about the X, Y and Z axes respectively.
"""
function grid(
        size::Float64,
        step::Float64;
        x::Float64 = 0.0,
        y::Float64 = 0.0,
        z::Float64 = 0.0,
        rx::Float64 = 0.0,
        ry::Float64 = 0.0,
        rz::Float64 = 0.0,
        colorcenter::Colors.RGB{U8}=colorant"black",
        colorgrid::Colors.RGB{U8}=colorant"black"
    )
    Elem(
        :"three-js-grid",
        attributes = Dict(
            :size => size,
            :step => step,
            :x => x,
            :y => y,
            :z => z,
            :rx => rx,
            :ry => ry,
            :rz => rz,
            :colorcenter => "#" * hex(colorcenter),
            :colorgrid => "#" * hex(colorgrid)
        )
    )
end

"""
Create a Text Sprite with `content` at position `(x,y,z)`.
"""
function text(x::Float64, y::Float64, z::Float64, content::AbstractString)
   Elem(
        :"three-js-text",
        attributes = Dict(:x=>x, :y=>y, :z=>z, :content=>content)
   )
end

@require Escher begin
    import Escher: Behavior

    immutable Raycaster <: Behavior
        camera
        event
    end

    Escher.render(r::Raycaster, state) = Escher.render(r.camera, state) << Elem(:"three-js-raycaster"; :event => r.event)
    Escher.default_intent(x::Raycaster) = Escher.ToType{Dict{UTF8String, Float64}}()

    """
    Create a raycaster that triggers on the JavaScript event `event`.
    """
    function raycastable(camera::Elem, event::AbstractString = "")
        Raycaster(camera, event)
    end
end
