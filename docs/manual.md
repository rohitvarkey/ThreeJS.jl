### How to create a scene?

For rendering Three-JS elements, all tags should be nested in a `three-js` tag.
This can be done by using the `initscene` function. An outer div to put this in
is also required and can be created by using the `outerdiv` function.

The code snippet below should get a scene initialized.
```julia
using ThreeJS
outerdiv() << initscene()
```

By default, a scene of `1000px x 562px` is created. Support to change this will
be added soon.

### Creating meshes

In Three-JS, meshes are objects that can be drawn in the scene. These require a
`geometry` and a `material` to be created. Meshes decide the properties as to the
position of where the object is drawn.

A mesh can be created using the `mesh` function taking the coordinates `(x,y,z)`
as its arguments.

A `geometry` and a `material` element should be nested inside this `mesh`.

#### Geometries

Geometries hold all details necessary to describe a 3D model. These can be
thought of as the shapes we want to display.

ThreeJS.jl provides support to render the following geometry primitives:

- Boxes - `box(width, height, depth)`
- Spheres - `sphere(radius)`
- Pyramids - `pyramid(base, height)`
- Cylinders - `cylinder(topradius, bottomradius, height)`
- Tori - `torus(radius, tuberadius)`
- Parametric Surfaces - `parametric(slices, stacks, xrange, yrange, function)`
- Dodecahedron - `dodecahedron(radius)`
- Icosahedron - `icosahedron(radius)`
- Octahedron - `octahedron(radius)`
- Tetrahedron - `tetrahedron(radius)`
- Planes - `plane(width, height)`

These functions will return the appropriate `geometry` tags that are to be nested
inside a `mesh` along with a `material` to render.

#### Custom Geometries

The `geometry` function is able to render custom geometries, which are specified
by the vertices and the faces.

#### Materials

Materials are what decides how the model responds to light, color and such
properties of the material.

A `material` tag is created by using the `material` function. Properties are
to be passed as a `Dict` to this function.

Available properties are:

- `color` - Can be any CSS color value.
- `kind` - Can be [`lambert`](http://threejs.org/docs/#Reference/Materials/MeshLambertMaterial),
[`basic`](http://threejs.org/docs/#Reference/Materials/MeshBasicMaterial),
[`phong`](http://threejs.org/docs/#Reference/Materials/MeshPhongMaterial), or
[`normal`](http://threejs.org/docs/#Reference/Materials/MeshNormalMaterial)
- `wireframe` - `true` or `false`
- `visible` - `true` or `false`

Some helper functions to get these key value pairs is given in `src/properties.jl`.

#### Putting them together

```julia
mesh(0.0, 0.0, 0.0) <<
    [box(1.0,1.0,1.0), material(Dict(:kind=>"basic",:color=>"red")]
```

will create a cube of size 1.0 of red color and with the basic material.

### Lines

Lines can be drawn by specifying the vertices of the line in the order to be
joined. Lines can either be of `"strip"` or `"pieces"` kinds, which decide how
the vertices should be joined. `"strip"` lines join all vertices, while "pieces"
only joins the first and second, third and fourth and so on. Colors for the
vertices of the lines can also be specified.

Lines are also meshes and has the properties of a mesh too, like position and
rotation. Like meshes, they are a child of the `scene`.

#### Line Materials

Lines also require a material to decide properties of a line.
The `linematerial` function can be used to do this and specify some properties
for the line. The `linematerial` should be a child of the `line` element.

#### Drawing lines

The `line` function can be used to draw lines.

```julia
line([(0.0, 0.0, 0.0), (1.0, 1.0, 1.0)]) <<
        linematerial(Dict(:color=>"red"))
```

#### Mesh grids

Drawing mesh grids can be achieved by using the `meshlines` function. It creates
a set of lines to form the grid and assigns colors to the vertices based on the
z values.

If you are looking for a 2D grid, use the `grid` function. It creates a grid on
the XY plane which can then be rotated as required.

### Cameras

No 3D scene can be properly displayed without a camera to view from. ThreeJS.jl
provides support for a Perspective Camera view using the `camera` function.

This sets the position of the camera, along with properties like `near` plane,
`far` plane, `fov` for field of view (in degrees), and `aspect` ratio.

The `camera` tag should be a child of the `scene`.

### Lights

ThreeJS.jl provides support for 3 kinds of lighting.

- [Ambient](http://threejs.org/docs/#Reference/Lights/AmbientLight) - `ambientlight(color)`
- [Point](http://threejs.org/docs/#Reference/Lights/PointLight) -
`pointlight(x, y, z; color, intensity, distance)`
- [Spot](http://threejs.org/docs/#Reference/Lights/SpotLight) -
`spotlight(x, y, z; color, intensity, distance, angle, exponent, shadow)`

These tags should also be a child of the `scene`.

### Controls

By default, ThreeJS adds [TrackballControls](http://threejs.org/examples/misc_controls_trackball.html)
to every scene drawn. This lets you interact with the scene by using the
trackpad or mouse to rotate, pan and zoom.

### Interactivity

You can use the [reactive functionality](https://shashi.github.io/Escher.jl/reactive.html)
provided by Escher to create Signals of the 3D graphic elements produced.
These can let you create graphics that can be interacted with using UI elements
like sliders. Try launching `escher --serve` (if you have Escher installed)
in the `examples/` directory and heading to `localhost:5555/box.jl` on the
browser. You can see a box whose width, depth, height and rotation about
each axes can be set and the box will update accordingly!

Currently, this functionality does not work in IJulia notebooks. Hopefully,
this will be fixed soon and you can use `Interact`(https://github.com/JuliaLang/Interact.jl)
to do the same in IJulia notebooks.

### Animations

You can also do animations by using Reactive signals. See
`examples/rotatingcube.jl` as an example. It is implemented in Escher,
so running an Escher server from that directory and heading to
`localhost:5555/rotatingcube.jl` should give you a cube which is
rotating!

NOTE: Adding new objects to a scene will force a redraw of the scene, resetting
the camera.

### Example

```julia
using ThreeJS
outerdiv() << (initscene() <<
    [
        mesh(0.0, 0.0, 0.0) <<
        [
            box(1.0,1.0,1.0), material(Dict(:kind=>"lambert",:color=>"red"))
        ],
        pointlight(3.0, 3.0, 3.0),
        camera(0.0, 0.0, 10.0)
    ])
```

Running the above in an IJulia notebook should draw a red cube,
which is illuminated by a light from a corner.

For Escher, after the script above is run, the following code should give the
same result.

```julia
using ThreeJS
using Compat

main(window) = begin
    push!(window.assets,("ThreeJS","threejs"))
    vbox(
        title(2,"ThreeJS"),
        outerdiv() <<
        (
        initscene() <<
        [
            mesh(0.0, 0.0, 0.0) <<
                [
                    ThreeJS.box(1.0, 1.0, 1.0),
                    material(Dict(:kind=>"lambert",:color=>"red"))
                ],
            pointlight(3.0, 3.0, 3.0),
            camera(0.0, 0.0, 10.0)
        ]
        )
    )
end
```
