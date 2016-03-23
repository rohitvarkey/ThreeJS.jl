# Helper functions to help set material properties are defined here.

import Colors: Color, hex
export meshcolor, wireframe, edges, visible, lambert, basic, phong, normal

function meshcolor(color::Color)
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
    :hidden, !visible
end

function edges(edgeColor::Color)
    color = string("#" * hex(color))
    :edges, color
end

# To allow edges to be set to false.
function edges(edges::Bool=true)
    :edges, edges
end
