# Introduction

A Julia module to render graphical objects, especially 3-D objects, using
the [three.js](https://threejs.org) abstraction over WebGL.
Outputs [Patchwork](https://github.com/shashi/Patchwork.jl) Elems of
[three-js](https://github.com/rohitvarkey/three-js) custom elements. Meant to be
used to help packages like [Compose3D](https://github.com/rohitvarkey/Compose3D.jl)
render 3D output.

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
<link rel="import" href="assets/bower_components/three-js/three-js.html>
```
