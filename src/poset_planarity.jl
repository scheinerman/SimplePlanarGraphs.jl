using SimplePosets, SimplePosetAlgorithms

# using SimpleGraphs, SimplePlanarGraphs  # remove his later
export is_planar, schnyder_realizer

"""
    is_planar(G::SimpleGraph)
Return `true` if the graph is planar.

**Note**: This is a simple implementation, but not efficient. It's a place holder
until we have a better one. 
"""
function is_planar(G::SimpleGraph)::Bool
    # Create a poset from G and see if it has dimension ≤ 3.

    if !quick_planar_check(G)
        return false
    end

    try
        R = schnyder_realizer(G)
        return true
    catch
        return false
    end
    return false
end

"""
    schnyder_realizer(G)

Return an `n`-by-`3` matrix each of whose columns contains the vertices of `G`.
This is a reduced version of a three-dimensional realizer of `P(G)`.

Throws an error if `G` is not planar.
"""
function schnyder_realizer(G::SimpleGraph{T}) where {T}
    if cache_check(G, :schnyder_realizer)
        return cache_recall(G, :schnyder_realizer)
    end

    P = SimplePoset(G)
    R = realizer(P, 3)
    n = NV(G)

    result = Array{T}(undef, n, 3)

    for k = 1:3
        c = R[:, k]
        result[:, k] = [x for x in c if x isa T]
    end
    cache_save(G, :schnyder_realizer, result)
    return result
end

