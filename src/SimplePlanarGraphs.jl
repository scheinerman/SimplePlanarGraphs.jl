module SimplePlanarGraphs
using SimpleGraphs, LinearAlgebra

export quick_planar_check



"""
`quick_planar_check(G::SimpleGraph)` performs very basic necessary checks for a 
graph to be planar (or not). These checks include edge/girth bound and 5-degeneracy.

If this function returns `false` the graph is definitely not planar. If it 
returns `true` it might be planar, but it might not.
"""
function quick_planar_check(G::SimpleGraph)::Bool
    n = NV(G)
    if n ≤ 4
        return true
    end

    g = girth(G)
    if g == 0
        return true
    end
    m = NE(G)
    if m ≤ g * (n - 2) / (g - 2)
        return true
    end

    H = trim(G, 5)
    if NV(H) == 0
        return true
    end
    return false
end


include("count_cross.jl")
include("face_finder.jl")
include("random_triangulation.jl")
include("poset_planarity.jl")

end