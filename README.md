# ThreeJS

Linux, OSX: [![Build Status](https://travis-ci.org/rohitvarkey/ThreeJS.jl.svg?branch=master)](https://travis-ci.org/rohitvarkey/ThreeJS.jl)

Windows: [![Build status](https://ci.appveyor.com/api/projects/status/0ldau5x8fxx09kgv/branch/master?svg=true)](https://ci.appveyor.com/project/rohitvarkey/threejs-jl/branch/master)

Code Coverage: [![Coverage Status](https://coveralls.io/repos/rohitvarkey/ThreeJS.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/rohitvarkey/ThreeJS.jl?branch=master)
[![codecov.io](http://codecov.io/github/rohitvarkey/ThreeJS.jl/coverage.svg?branch=master)](http://codecov.io/github/rohitvarkey/ThreeJS.jl?branch=master)

A Julia module to render graphical objects, especially 3-D objects, using
the ThreeJS abstraction over WebGL.
Outputs [Patchwork](https://github.com/shashi/Patchwork.jl) Elems of
[three-js](https://github.com/rohitvarkey/three-js) custom elements. Meant to be
used to help packages like [Compose3D](https://github.com/rohitvarkey/Compose3D.jl)
render 3D output.

|[![](https://camo.githubusercontent.com/171887ec9b737effd8e5a3639c6675aac8702d9b/68747470733a2f2f676973742e6769746875622e636f6d2f726f6869747661726b65792f31643635393235383530313938626332383466352f7261772f623764633431663262336638363963313033646362636237393633326639323339373736376230312f726f746174696e675f637562652e676966)](https://github.com/rohitvarkey/ThreeJS.jl/blob/df78531c88dd2619be73fef74b4b5268cfd89c4d/examples/rotatingcube.jl)|[![](https://gist.github.com/rohitvarkey/1d65925850198bc284f5/raw/5a05d50fe48ada9463de2631e6287b41a4e78899/3dpath.png?raw=true)](https://github.com/rohitvarkey/ThreeJS.jl/blob/df78531c88dd2619be73fef74b4b5268cfd89c4d/examples/3dpath.jl)|
|---|---|
|[![](https://gist.github.com/rohitvarkey/1d65925850198bc284f5/raw/5a05d50fe48ada9463de2631e6287b41a4e78899/scale_cat.gif?raw=true)](https://github.com/rohitvarkey/ThreeJS.jl/blob/df78531c88dd2619be73fef74b4b5268cfd89c4d/examples/mesh.jl)|[![](https://gist.github.com/rohitvarkey/1d65925850198bc284f5/raw/5a05d50fe48ada9463de2631e6287b41a4e78899/surfmesh.gif?raw=true)](https://github.com/rohitvarkey/ThreeJS.jl/blob/df78531c88dd2619be73fef74b4b5268cfd89c4d/examples/surfmesh.jl)|

Click on any of the above examples to see the code used to draw them.

### Where can these be used?

This can be used in [IJulia](https://github.com/JuliaLang/IJulia.jl/)
and [Escher](https://github.com/shashi/Escher.jl) to embed 3D graphics.

### Dependencies

WebGL lets you interact with the GPU in a browser. As long as you have a modern
browser, and it supports WebGL (Check this [link](https://get.webgl.org/)
to see if it does!), the output of this package will just work.

### Installation

```julia
Pkg.add("ThreeJS")
```

### Development

Running `Pkg.build("ThreeJS")` fetches and installs the [three-js](https://github.com/rohitvarkey/three-js)
webcomponents. This will be done automatically if you install ThreeJS.jl using `Pkg.add("ThreeJS")`.

However, if you clone ThreeJS.jl (with `Pkg.clone` or otherwise), then these webcomponents
must be installed manually into `assets/bower_components`. This is done to allow simultaneous
development of both repositories.

### Documentation

API documentation can be found [here](https://rohitvarkey.github.io/ThreeJS.jl).

#### IJulia

For use in IJulia notebooks, `using ThreeJS` will set up everything including
static files.

NOTE: If you are restarting the kernel, and doing `using ThreeJS` again, please
reload the page, after deleting the cell where you did `using ThreeJS`.

#### Escher

Adding `push!(window.assets,("ThreeJS","threejs"))` in your Escher code,
will get the static files set up and you can do 3D Graphics in Escher!

#### General web servers

To use in a web server, you will need to serve the asset files found in the
`assets/` directory. Then adding a HTML import to the `three-js.html` file in
the `assets/bower_components/three-js` will get you all set up! This is done
by adding the following line to your HTML file.

```html
<link rel="import" href="assets/bower_components/three-js/three-js.html">
```

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
[`phong`](http://threejs.org/docs/#Reference/Materials/MeshPhongMaterial),
[`normal`](http://threejs.org/docs/#Reference/Materials/MeshNormalMaterial), or
`texture`(for texture mapping)
- `texture` - URL of image to be mapped as texture. Will be applied only if `kind` is set to `texture`.
- `wireframe` - `true` or `false`
- `hidden` - `true` or `false`
- `transparent` - `true` or `false`. Set to `true` to get proper rendering for transparent objects.
- `opacity` - Number between 0.0 and 1.0 (fully opaque).

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
