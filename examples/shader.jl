import ThreeJS

using Reactive

vert = """
        varying vec2 rg;

        void main() {
          rg = uv;
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
        """

frag = """
        varying vec2 rg;
        uniform float b;
        uniform float a;

        void main() {
            gl_FragColor = vec4(rg, b, a); }
        """

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    push!(window.assets,"nested-props")

    ti = map(_->time(), fps(30))

    map(ti) do t
    ThreeJS.outerdiv() <<
    (ThreeJS.initscene() <<
        [
            ThreeJS.mesh(0.0, 0.0, 0.0) <<
            [
                ThreeJS.plane(1.0, 1.0),
                ThreeJS.shadermaterial(
                    uniforms=PropHook("escher-property-hook",
                        Dict(:b=>Dict(:type=>"f", :value=>sin(t)^2), :a=>Dict(:type=>"f", :value=>cos(t)^2))),
                    vertexshader=vert,
                    fragmentshader=frag,)
            ],
            ThreeJS.camera(0.0, 0.0, 2.0)
        ]
    )
    end
end
