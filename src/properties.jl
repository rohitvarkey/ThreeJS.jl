# Helper functions to help set material properties are defined here.

import Color: ColorValue, hex
export meshcolor, wireframe, edges, visible, lambert, basic, phong, normal

function meshcolor(color::ColorValue)
    color = string("#" * hex(color))
    :color, color
end

function wireframe(wireframe::Bool=true)
    :wireframe, wireframe
end

function lambert()
    :kind, "lambert"
end

function basic()
    :kind, "basic"
end

function phong()
    :kind, "phong"
end

function normal()
    :kind, "normal"
end

function visible(visible::Bool=true)
    :visible, visible
end

function edges(edgeColor::ColorValue)
    color = string("#" * hex(color))
    :edges, color
end

# To allow edges to be set to false.
function edges(edges::Bool=true)
    :edges, edges
end
