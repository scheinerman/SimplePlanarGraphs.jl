using SimplePosets, SimplePosetAlgorithms

# using SimpleGraphs, SimplePlanarGraphs  # remove his later
export is_planar, schnyder_realizer

"""
    is_planar(G::UG)
Return `true` if the graph is planar.

**Note**: This is a simple implementation, but not efficient. It's a place holder
until we have a better one. 
"""
function is_planar(G::UG)::Bool
    # Create a poset from G and see if it has dimension ≤ 3.

    if cache_check(G, :is_planar)
        return cache_recall(G, :is_planar)
    end

    if !quick_planar_check(G)
        return false
    end

    if count_cross(G) == 0
        cache_save(G, :is_planar, true)
        return true 
    end

    try
        R = schnyder_realizer(G)
        cache_save(G, :is_planar, true)
        return true
    catch
        cache_save(G, :is_planar, false)
        return false
    end
    cache_save(G, :is_planar, false)
    return false
end

"""
    schnyder_realizer(G)

Return an `n`-by-`3` matrix each of whose columns contains the vertices of `G`.
This is a reduced version of a three-dimensional realizer of `P(G)`.

Throws an error if `G` is not planar.
"""
function schnyder_realizer(G::UG{T}) where {T}
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

