import Compat
using Colors
export mesh, box, sphere, pyramid, cylinder, torus, parametric, meshlines,
       material, camera, pointlight, spotlight, ambientlight, vertex

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
        attributes = @d (
            :x => x, :y => y, :z => z, :rx => rx, :ry => ry, :rz => rz
        )
    )
end

"""
Creates a Box geometry of width `w`, height `h` and depth `d`.
Should be put in a `mesh` along with another material Elem to render.
"""
function box(w::Float64,h::Float64,d::Float64)
   Elem(:"three-js-box", attributes = @d (:w=>w, :h=>h, :d=>d))
end

"""
Creates a Sphere geometry of radius `r`. 
Should be put in a `mesh` along with another material Elem to render.
"""
function sphere(r::Float64)
    Elem(:"three-js-sphere", attributes = @d (:r=>r))
end

"""
Creates a square base Pyramid geometry of base `b` and height `h`. 
Should be put in a `mesh` along with another material Elem to render.
"""
function pyramid(b::Float64,h::Float64)
    Elem(:"three-js-pyramid", attributes = @d (:base => b, :height => h))
end

"""
Creates a Cylinder geometry of bottom radius `bottom`, top radius `top` and 
height `h`. 
Should be put in a `mesh` along with another material Elem to render.
"""
function cylinder(top::Float64,bottom::Float64,height::Float64)
    Elem(
        :"three-js-cylinder",
        attributes = @d (:top => top, :bottom => bottom, :height => height)
    )
end

"""
Creates a Torus geometry of radius `radius` and tube radius `tube`.
Should be put in a `mesh` along with another material Elem to render.
"""
function torus(radius::Float64,tube::Float64)
    Elem(
        :"three-js-torus",
        attributes = @d (:r => radius, :tube => tube)
    )
end

"""
Creates a vertex at position `(x,y,z)`.
"""
function vertex(x::Float64,y::Float64,z::Float64)
    Elem(:"three-js-vertex", attributes = @d (:x => x, :y => y, :z => z))
end

"""
Creates a parametric surface.
Takes `x` values between `xrange` divided into `slices+1` equal intervals. 
Takes `y` values between `yrange` divided into `stacks+1` equal intervals.
Applies a function `f` passed to all such `x` and `y` values and creates vertices
of coordinates `(x,y,z)` and a surface containing these vertices.
"""
function parametric(
    slices::Int,
    stacks::Int,
    xrange::Range,
    yrange::Range,
    f::Function
    )
    geom = Elem(
        :"three-js-parametric",
        attributes = @d (:slices => slices, :stacks => stacks)
    )
    xrange = linspace(xrange.start, xrange.stop, slices+1)
    yrange = linspace(yrange.start, yrange.stop, stacks+1)
    vertices = [vertex(x, f(x,y), y) for x=xrange, y=yrange]
    geom = geom << vertices
end

"""
Creates a mesh plot.
Takes `x` values between `xrange` divided into `slices+1` equal intervals. 
Takes `y` values between `yrange` divided into `stacks+1` equal intervals.
Applies a function `f` passed to all such `x` and `y` values and creates 
vertices of coordinates `(x,y,z)` and a joins them horizontally and vertically,
creating a mesh
"""
function meshlines(
    slices::Int, 
    stacks::Int, 
    xrange::Range, 
    yrange::Range, 
    f::Function
    )
    geom = Elem(
        :"three-js-meshlines",
        attributes = @d( :slices => slices, :stacks => stacks)
    )
    xrange = linspace(xrange.start, xrange.stop, slices+1)
    yrange = linspace(yrange.start, yrange.stop, stacks+1)
    vertices = [vertex(x, f(x,y), y) for x=xrange, y=yrange]
    geom = geom << vertices
end

"""
Creates a material tag with properties passed in as a dictionary.
"""
function material(props::Dict=@d ())
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
        attributes = @d (
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
        attributes = @d (
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
        attributes = @d (
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
        attributes = @d (:kind => "ambient", :color => colorString)
    )
end
