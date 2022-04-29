using SimplePosets, SimplePosetAlgorithms

# using SimpleGraphs, SimplePlanarGraphs  # remove his later
export is_planar

"""
    is_planar(G::SimpleGraph)
Return `true` if the graph is planar.

**Note**: This is a simple implementation, but not efficient. It's a place holder
until we have a better one. 
"""
function is_planar(G::SimpleGraph)::Bool
    # Create a poset from G and see if it has dimension ≤ 3.
    P = SimplePoset(G)
    try
        R = realizer(P,3)
        return true
    catch
        return false
    end
    return false

end