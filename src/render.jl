export mesh, box, sphere, pyramid, cylinder, torus

"""
Creates a Three-js mesh at position (`x`,`y`,`z`).
Geometry and Material tags are added as children to this Elem, to render a mesh.
"""
function mesh(x::Float64,y::Float64,z::Float64)
    Elem(:"three-js-mesh",x=x,y=y,z=z)
end

"""
Creates a Box geometry of width `w`, height `h` and depth `d`. 
Should be put in a `mesh` along with another material Elem to render.
"""
function box(w::Float64,h::Float64,d::Float64)
   Elem(:"three-js-box",w=w,h=h,d=d) 
end

"""
Creates a Sphere geometry of radius `r`. 
Should be put in a `mesh` along with another material Elem to render.
"""
function sphere(r::Float64)
    Elem(:"three-js-sphere",r=r)
end

"""
Creates a square base Pyramid geometry of base `b` and height `h`. 
Should be put in a `mesh` along with another material Elem to render.
"""
function pyramid(b::Float64,h::Float64)
    Elem(:"three-js-pyramid",base=b,height=h)
end

"""
Creates a Cylinder geometry of bottom radius `bottom`, top radius `top` and 
height `h`. 
Should be put in a `mesh` along with another material Elem to render.
"""
function cylinder(top::Float64,bottom::Float64,height::Float64)
    Elem(:"three-js-cylinder",top=top,bottom=bottom,height=height)
end

"""
Creates a Torus geometry of radius `radius` and tube radius `tube`.
Should be put in a `mesh` along with another material Elem to render.
"""
function torus(radius::Float64,tube::Float64)
    Elem(:"three-js-torus",r=radius, tube=tube)
end


