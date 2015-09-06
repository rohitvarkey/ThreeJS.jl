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

### Where can these be used?

This can be used in [IJulia](https://github.com/JuliaLang/IJulia.jl/)
notebooks to embed 3D Graphics. [Escher](https://github.com/shashi/Escher.jl)
also supports ThreeJS, but you'll need the `master` version of Escher.

### Dependencies

WebGL lets you interact with the GPU in a browser. As long as you have a modern
browser, and it supports WebGL (Check this [link](https://get.webgl.org/)
to see if it does!), the output of this package will just work.

### Set up

```julia
Pkg.clone("https://github.com/rohitvarkey/ThreeJS.jl")
```

#### IJulia

For use in IJulia notebooks, `using ThreeJS` will set up everything including
static files.

NOTE: If you are restarting the kernel, and doing `using ThreeJS` again, please
reload the page, after deleting the cell where you did `using ThreeJS`.

#### Escher

You will need the `master` of Escher to run `ThreeJS` which can be obtained by
running the following in a Julia REPL.

```julia
Pkg.checkout("Escher")
```

Now, adding `push!(window.assets,("ThreeJS","threejs"))` in your Escher code,
will get the static files set up and you can do 3D Graphics in Escher!

#### General web servers

To use in a web server, you will need to serve the asset files found in the
`assets/` directory. Then adding a HTML import to the `three-js.html` file in
the `assets/bower_components/three-js` will get you all set up! This is done
by adding the following line to your HTML file.

```html
<link rel="import" href="assets/bower_components/three-js/three-js.html>
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

These functions will return the appropriate `geometry` tags that are to be nested
inside a `mesh` along with a `material` to render.

<!--
TODO: Add docs for meshlines
-->

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
                    material(@compat(Dict(:kind=>"lambert",:color=>"red")))
                ],
            pointlight(3.0, 3.0, 3.0),
            camera(0.0, 0.0, 10.0)
        ]
        )
    )
end
```
