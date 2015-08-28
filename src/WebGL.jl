module WebGL

import Patchwork
import Patchwork.Elem
using Compat

export outerdiv, initscene

include("render.jl")

"Outer div to keep the three-js tag in."
function outerdiv(w::String="100%",h::String="600px")
    Elem(:div, style=@compat Dict(:width=>w, :height=>h))
end

"Initiates a three-js scene"
function initscene()
        Elem(:"three-js")
end

if isdefined(Main, :IJulia)
    display(
        MIME"text/html"(),
        "<link rel=import href=/static/components/compose3d/bower_components/three-js/three-js.html>"
    )
end

end # module
