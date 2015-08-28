# WebGL

A Julia module to render graphical objects, especially 3-D objects, using WebGL.
Outputs [Patchwork](https://github.com/shashi/Patchwork.jl) Elems of 
[three-js](https://github.com/rohitvarkey/three-js) custom elements. Meant to be
used to help packages like [Compose3D](https://github.com/rohitvarkey/Compose3D.jl)
render 3D output.

### Where can these be used?

This can be used in [IJulia](https://github.com/JuliaLang/IJulia.jl/)
notebooks to embed 3D Graphics. Support for [Escher](https://github.com/shashi/Escher.jl)
is being worked on.

### Dependencies

WebGL lets you interact with the GPU in a browser. As long as you have a modern
browser, and it supports WebGL (Check this [link](https://get.webgl.org/)
to see if it does!), the output of this package will just work.

You will need to serve the asset files found in `assets/` in your server.
For IJulia, the asset files need to be copied to the profile directory being
served. 

```bash
cp -r ~/.julia/v0.4/WebGL/assets/ ~/.ipython/<profile_name>/static/components/compose3d
```

Then adding a HTML import to the `three-js.html` file in `bower_components/three-js`
will get you all set up!

Running Pkg.build("WebGL") will run a script that will copy the asset files to
the `profile_julia` folder. Then running `ipython notebook --profile=julia`
should serve the static files.

### How to create a scene?

For rendering Three-JS elements, all tags should be nested in a `three-js` tag.
This can be done by using the `initscene` function. An outer div to put this in
is also required and can be created by using the `outerdiv` function.

The code snippet below should get a scene initialized.
```julia
using WebGL
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

WebGL.jl provides support to render the following geometry primitives:

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
- `edges` - `false` or color of the edges. This will attempt to show only
hard edges and not all triangles as wireframe will display.

Some helper functions to get these key value pairs is given in `src/properties.jl`.

#### Putting them together

```julia
mesh(0.0, 0.0, 0.0) << 
    [box(1.0,1.0,1.0), material(Dict(:kind=>"basic",:color=>"red")]
```

will create a cube of size 1.0 of red color and with the basic material. 

### Cameras

No 3D scene can be properly displayed without a camera to view from. WebGL.jl
provides support for a Perspective Camera view using the `camera` function.

This sets the position of the camera, along with properties like `near` plane,
`far` plane, `fov` for field of view (in degrees), and `aspect` ratio.

The `camera` tag should be a child of the `scene`.

### Lights

WebGL.jl provides support for 3 kinds of lighting.

- [Ambient](http://threejs.org/docs/#Reference/Lights/AmbientLight) - `ambientlight(color)`
- [Point](http://threejs.org/docs/#Reference/Lights/PointLight) -
`pointlight(x, y, z; color, intensity, distance)`
- [Spot](http://threejs.org/docs/#Reference/Lights/SpotLight) -
`spotlight(x, y, z; color, intensity, distance, angle, exponent, shadow)`

These tags should also be a child of the `scene`.

### Example

```julia
using WebGL
outerdiv() << initscene() <<
    [
        mesh(0.0, 0.0, 0.0) << 
        [
            box(1.0,1.0,1.0), material(Dict(:kind=>"lambert",:color=>"red")
        ],
        pointlight(3.0, 3.0, 3.0),
        camera(0.0, 0.0, 10.0)
    ]
```

This should draw a red cube, which is illuminated by a light from a corner.
