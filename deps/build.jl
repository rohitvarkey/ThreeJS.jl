# This script copies the assets required by Compose3D to the IPython profile path so 
# as to allow people to use it without trouble.
# It copies the files to the static folder of the julia profile.

import Base: cp

if Pkg.installed("IJulia") == nothing
    error("IJulia not installed")
end

try 
    juliaprof = chomp(readall(`ipython locate profile julia`))
catch
    error("Julia profile not found. Try after building IJulia")
end

staticpath = joinpath(chomp(readall(`ipython locate profile julia`)),"static", "components", "compose3d")
mkpath(staticpath)
assetDir = joinpath(Pkg.dir("Compose3D"),"assets")
print(assetDir)

cp(assetDir,staticpath,remove_destination=true) 
