version = "master"

function updatejs()
    file = "$version.zip"

    download("https://github.com/rohitvarkey/three-js/archive/$file", file)
    run(`unzip -qq $file`)
    mv("three-js-$version", joinpath(dirname(@__FILE__), "..", "assets", "bower_components", "three-js"), remove_destination=true)
end

# Install the three-js webcomponents
mktempdir(dir -> cd(updatejs, dir))
