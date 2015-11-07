# ThreeJS

## Exported

---

<a id="method__ambientlight.1" class="lexicon_definition"></a>
#### ambientlight() [¶](#method__ambientlight.1)
Creates an ambient light tag.
Ambient light is applied equally to all objects.
The color of the light is set using the `color` argument.


*source:*
[ThreeJS/src/render.jl:351](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L351)

---

<a id="method__ambientlight.2" class="lexicon_definition"></a>
#### ambientlight(color::ColorTypes.RGB{FixedPointNumbers.UfixedBase{UInt8, 8}}) [¶](#method__ambientlight.2)
Creates an ambient light tag.
Ambient light is applied equally to all objects.
The color of the light is set using the `color` argument.


*source:*
[ThreeJS/src/render.jl:351](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L351)

---

<a id="method__box.1" class="lexicon_definition"></a>
#### box(w::Float64,  h::Float64,  d::Float64) [¶](#method__box.1)
Creates a Box geometry of width `w`, height `h` and depth `d`.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:35](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L35)

---

<a id="method__camera.1" class="lexicon_definition"></a>
#### camera(x::Float64,  y::Float64,  z::Float64) [¶](#method__camera.1)
Creates a camera tag.
Perspective camera at position `(x,y,z)` created. Keyword arguments of `near`,
`far`,`aspect`, and `fov` is accepted.


*source:*
[ThreeJS/src/render.jl:266](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L266)

---

<a id="method__cylinder.1" class="lexicon_definition"></a>
#### cylinder(top::Float64,  bottom::Float64,  height::Float64) [¶](#method__cylinder.1)
Creates a Cylinder geometry of bottom radius `bottom`, top radius `top` and
height `h`.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:60](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L60)

---

<a id="method__dodecahedron.1" class="lexicon_definition"></a>
#### dodecahedron(radius::Float64) [¶](#method__dodecahedron.1)
Creates a Dodecahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:82](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L82)

---

<a id="method__geometry.1" class="lexicon_definition"></a>
#### geometry(vertices::Array{Tuple{Float64, Float64, Float64}, 1},  faces::Array{Tuple{Int64, Int64, Int64}, 1}) [¶](#method__geometry.1)
Creates a geometry.
This should be a child of a `mesh`.
Vertices of the geometry are passed in as a vector of `Tuples` of the coordinates
along with faces of the geometry which are again passed in as a vector of `Tuples`
of `Int` representing the indices of the vertices to be joined.


*source:*
[ThreeJS/src/render.jl:141](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L141)

---

<a id="method__grid.1" class="lexicon_definition"></a>
#### grid(size::Float64,  step::Float64) [¶](#method__grid.1)
Creates a grid element.
These should be a child of the scene tag created by `initscene`.
The `size` represents the total size and the `step` represents the distance
between consecutive lines of the grid.

The grid can be translated and rotated using keyword arguments,
`x`,`y`,`z` for the (x, y, z) coordinate and `rx`, `ry` and `rz`
as the rotation about the X, Y and Z axes respectively.


*source:*
[ThreeJS/src/render.jl:474](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L474)

---

<a id="method__icosahedron.1" class="lexicon_definition"></a>
#### icosahedron(radius::Float64) [¶](#method__icosahedron.1)
Creates a icosahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:93](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L93)

---

<a id="method__initscene.1" class="lexicon_definition"></a>
#### initscene() [¶](#method__initscene.1)
Initiates a three-js scene

*source:*
[ThreeJS/src/ThreeJS.jl:17](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/ThreeJS.jl#L17)

---

<a id="method__line.1" class="lexicon_definition"></a>
#### line(vertices::Array{Tuple{Float64, Float64, Float64}, 1}) [¶](#method__line.1)
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


*source:*
[ThreeJS/src/render.jl:378](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L378)

---

<a id="method__line.2" class="lexicon_definition"></a>
#### line(verticeswithcolor::Array{Tuple{Float64, Float64, Float64, ColorTypes.Color{T, N}}, 1}) [¶](#method__line.2)
Helper function to make creating `line` easier.
`Tuples` of vertices with their color also as part of the `Tuple`
is expected as the argument.


*source:*
[ThreeJS/src/render.jl:416](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L416)

---

<a id="method__linematerial.1" class="lexicon_definition"></a>
#### linematerial() [¶](#method__linematerial.1)
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


*source:*
[ThreeJS/src/render.jl:460](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L460)

---

<a id="method__linematerial.2" class="lexicon_definition"></a>
#### linematerial(props) [¶](#method__linematerial.2)
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


*source:*
[ThreeJS/src/render.jl:460](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L460)

---

<a id="method__material.1" class="lexicon_definition"></a>
#### material() [¶](#method__material.1)
Creates a material tag with properties passed in as a dictionary.


*source:*
[ThreeJS/src/render.jl:257](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L257)

---

<a id="method__material.2" class="lexicon_definition"></a>
#### material(props::Dict{K, V}) [¶](#method__material.2)
Creates a material tag with properties passed in as a dictionary.


*source:*
[ThreeJS/src/render.jl:257](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L257)

---

<a id="method__mesh.1" class="lexicon_definition"></a>
#### mesh(x::Float64,  y::Float64,  z::Float64) [¶](#method__mesh.1)
Creates a Three-js mesh at position (`x`,`y`,`z`).
Keyword arguments for rotation are available, being `rx`, `ry` and `rz` for
rotation about X, Y and Z axes respectively. These are to be specified in
degrees.
Geometry and Material tags are added as children to this Elem, to render a mesh.


*source:*
[ThreeJS/src/render.jl:15](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L15)

---

<a id="method__meshlines.1" class="lexicon_definition"></a>
#### meshlines(slices::Int64,  stacks::Int64,  xrange::Range{T},  yrange::Range{T},  f::Function) [¶](#method__meshlines.1)
Creates a mesh plot.
Takes `x` values between `xrange` divided into `slices+1` equal intervals.
Takes `y` values between `yrange` divided into `stacks+1` equal intervals.
Applies a function `f` passed to all such `x` and `y` values and creates
vertices of coordinates `(x,y,z)` and a joins them horizontally and vertically,
creating a mesh.

Returns an array of `line` elements which should be under the `scene`.

A colormap can also be passed to set the vertice colors to a corresponding color
using the keyword argument `colormap`.


*source:*
[ThreeJS/src/render.jl:225](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L225)

---

<a id="method__octahedron.1" class="lexicon_definition"></a>
#### octahedron(radius::Float64) [¶](#method__octahedron.1)
Creates a icosahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:104](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L104)

---

<a id="method__outerdiv.1" class="lexicon_definition"></a>
#### outerdiv() [¶](#method__outerdiv.1)
Outer div to keep the three-js tag in.

*source:*
[ThreeJS/src/ThreeJS.jl:12](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/ThreeJS.jl#L12)

---

<a id="method__outerdiv.2" class="lexicon_definition"></a>
#### outerdiv(w::AbstractString) [¶](#method__outerdiv.2)
Outer div to keep the three-js tag in.

*source:*
[ThreeJS/src/ThreeJS.jl:12](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/ThreeJS.jl#L12)

---

<a id="method__outerdiv.3" class="lexicon_definition"></a>
#### outerdiv(w::AbstractString,  h::AbstractString) [¶](#method__outerdiv.3)
Outer div to keep the three-js tag in.

*source:*
[ThreeJS/src/ThreeJS.jl:12](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/ThreeJS.jl#L12)

---

<a id="method__parametric.1" class="lexicon_definition"></a>
#### parametric(slices::Int64,  stacks::Int64,  xrange::Range{T},  yrange::Range{T},  f::Function) [¶](#method__parametric.1)
Creates a parametric surface.
Takes `x` values between `xrange` divided into `slices+1` equal intervals.
Takes `y` values between `yrange` divided into `stacks+1` equal intervals.
Applies a function `f` passed to all such `x` and `y` values and creates vertices
of coordinates `(x,y,z)` and a surface containing these vertices.

A colormap can also be passed to set the vertice colors to a corresponding color
using the keyword argument `colormap`.
NOTE: Such colors will be displayed only with a `material` with `colorkind` set
to `"vertex"` and `color` to `"white"`.


*source:*
[ThreeJS/src/render.jl:179](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L179)

---

<a id="method__plane.1" class="lexicon_definition"></a>
#### plane(width::Float64,  height::Float64) [¶](#method__plane.1)
Creates a plane in the XY plane with specified width and height centered
around the origin.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:127](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L127)

---

<a id="method__pointlight.1" class="lexicon_definition"></a>
#### pointlight(x::Float64,  y::Float64,  z::Float64) [¶](#method__pointlight.1)
Creates a point light tag.
A point light at position `(x,y,z)` is created. Keyword arguments of `color`
setting the color of the light, `intensity` and `distance` for setting the
intensity and distance properties are also accepted.


*source:*
[ThreeJS/src/render.jl:290](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L290)

---

<a id="method__pyramid.1" class="lexicon_definition"></a>
#### pyramid(b::Float64,  h::Float64) [¶](#method__pyramid.1)
Creates a square base Pyramid geometry of base `b` and height `h`.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:51](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L51)

---

<a id="method__sphere.1" class="lexicon_definition"></a>
#### sphere(r::Float64) [¶](#method__sphere.1)
Creates a Sphere geometry of radius `r`.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:43](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L43)

---

<a id="method__spotlight.1" class="lexicon_definition"></a>
#### spotlight(x::Float64,  y::Float64,  z::Float64) [¶](#method__spotlight.1)
Creates a spot light tag.
A spot light at position `(x,y,z)` is created. Keyword arguments of `color`
setting the color of the light, `intensity`, `distance`, `angle`, `exponent`,
`shadow` for setting the intensity, distance, angle(in degrees) and exponent
properties are also accepted. `Shadow` is a `Bool` to set if shadows are
enabled or not.


*source:*
[ThreeJS/src/render.jl:319](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L319)

---

<a id="method__tetrahedron.1" class="lexicon_definition"></a>
#### tetrahedron(radius::Float64) [¶](#method__tetrahedron.1)
Creates a tetrahedron geometry of radius `radius`.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:115](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L115)

---

<a id="method__torus.1" class="lexicon_definition"></a>
#### torus(radius::Float64,  tube::Float64) [¶](#method__torus.1)
Creates a Torus geometry of radius `radius` and tube radius `tube`.
Should be put in a `mesh` along with another material Elem to render.


*source:*
[ThreeJS/src/render.jl:71](https://github.com/rohitvarkey/ThreeJS.jl/tree/f88bc238a7397a98c5d14f2978bfd716f7076b8b/src/render.jl#L71)

