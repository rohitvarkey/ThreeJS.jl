import ThreeJS

vshader = "
        varying vec2 v_uv;

			void main()	{
                v_uv = uv;
				gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
			}
"

fshader = "
varying vec2 v_uv;
void main() {
gl_FragColor = vec4(v_uv, 0.0, 1.0);
	}
"

#data = rand(UInt8, 512, 512);
#b = base64encode(data)
#                 ThreeJS.datatexture(Dict(:data=>b)),


main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    ThreeJS.outerdiv() <<
    (ThreeJS.initscene() <<
        [
            ThreeJS.mesh(0.0, 0.0, 0.0) <<
            [
                ThreeJS.plane(8.0, 8.0),
                ThreeJS.shadermaterial(Dict(:uniforms=>Dict(:val=>"Hello"), :vertexshader=>vshader,:fragmentshader=>fshader))
            ],
            ThreeJS.pointlight(10.0, 10.0, 10.0),
            ThreeJS.camera(0.0, 0.0, 20.0)
        ]
    )
end
