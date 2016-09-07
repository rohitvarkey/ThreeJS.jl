import ThreeJS

t = every(1.0)

using Reactive


vert = """
        varying vec2 v_uv;

        void main() {
          v_uv = uv;
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
        """

frag = """
        varying vec2 v_uv;
        uniform float alpha;

        void main() { gl_FragColor = vec4(v_uv, 0.0, alpha); }
        """

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    push!(window.assets,"nested-props")

    t = map(_->time(), fps(10))

    map(t) do x
    ThreeJS.outerdiv() <<
    (ThreeJS.initscene() <<
        [
            ThreeJS.mesh(0.0, 0.0, 0.0) <<
            [
                ThreeJS.plane(8.0, 8.0),
                ThreeJS.shadermaterial(
                    uniforms=PropHook("escher-property-hook", Dict(:alpha=>Dict(:type=>"f", :value=>abs(sin(x))))),
                    vertexshader=vert,
                    fragmentshader=frag,)
            ],
            ThreeJS.pointlight(10.0, 10.0, 10.0),
            ThreeJS.camera(0.0, 0.0, 20.0)
        ]
    )
    end
end
