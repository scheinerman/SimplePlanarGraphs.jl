module SimplePlanarGraphs
using SimpleGraphs, LinearAlgebra

export quick_planar_check



"""
`quick_planar_check(G::SimpleGraph)` performs the most basic check for a 
graph to be planar (or not). Specifically, we return true if the number of 
vertices `n` is less than 5 or if the number of edges is at most `3n-6`.
"""
quick_planar_check(G::SimpleGraph)::Bool = NV(G)<5 || NE(G)<=3*NV(G)-6 


include("count_cross.jl")
include("face_finder.jl")
include("random_triangulation.jl")
  
end