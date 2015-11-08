import ThreeJS
import Colors: colormap

# Run in Escher to get updatable surf and mesh plots

function surf(f::Function)
 ThreeJS.outerdiv() <<
            (ThreeJS.initscene() <<
                [
                    ThreeJS.mesh(0.0, 0.0, 0.0) <<
                    [
                        ThreeJS.parametric(100,100,-10:10, -10:10,f),
                        ThreeJS.material(Dict(:kind=>"lambert",:color=>"white",
                        :colorkind=>"vertex"));
                    ],
                    ThreeJS.ambientlight(),
                    ThreeJS.camera(30.0, 30.0, 30.0)
                ]
            )
end

function mesh(f::Function)
 ThreeJS.outerdiv() <<
            (ThreeJS.initscene() <<
                [
                    ThreeJS.meshlines(50, 50, -10:10, -10:10, f),
                    ThreeJS.ambientlight(),
                    ThreeJS.camera(30.0, 30.0, 30.0);
                ]
            )
end
main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    push!(window.assets, "codemirror")
    push!(window.assets, "layout2")
    inp = Input(Dict())
    s = sampler() # A thing that lets you watch widgets/behaviors upon updates to other behaviors
    print
    default = "(x,y) -> sin(x) * cos(y)"
    editor = watch!(s, codemirror(default, name=:code))
    code_cell = trigger!(s, keypress("ctrl+enter shift+enter", editor))
    t, plots = wire(
                    tabs(["Surf";"Mesh";]),
                    pages(
                    [
                        lift(inp) do f
                            fn = get(f,:code,default)
                            try
                                surf(eval(parse(fn)))
                            catch
                                Elem(:div, "Something went wrong. Please check your syntax and try again. Contact rohitvarkey@gmail.com for more assistance.")
                            end
                        end;
                        lift(inp) do f
                            fn = get(f,:code,default)
                            try
                                mesh(eval(parse(fn)))
                            catch
                                Elem(:div, "Something went wrong. Please check your syntax and try again. Contact rohitvarkey@gmail.com for more assistance.")
                            end
                        end;
                    ]
                    ),
                    :tab_channel,
                    :selected
                )

    plugsampler(s,
        vbox(
                md"""Enter an anonymous function with 2 variables.
                    `ctrl+enter` or `shift+enter` to redraw the plot.
                    Use the mouse the drag, zoom and pan.
                    The function is plotted with x and y between -10 and 10 and
                    with 100 steps and 50 steps in both axes for the surf and the
                    mesh respectively. Try resizing the browser if you cant see a codebox""",
                code_cell,
                vskip(2em),
                t, plots
            ) |> pad(2em)
   ) >>> inp
end
