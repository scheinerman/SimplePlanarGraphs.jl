
export face_finder

"""
`face_finder(G::UG)` will attempt to find a face of the graph. 
Presently, it is *extremely* limited in what it can do.

*If* the graph `G` is planar and 3-connected, and *if* a face is 
returned, it probably is an actual face in some planar embedding of `G`.

See the `README` for this module for more detail.
"""
function face_finder(G::UG{T}) where T 
    if is_acyclic(G)
        return T[]
    end 
    G = trim(G,1)  # remove twigs
    
    comps = collect(components(G))

    for A in comps
        GG = induce(G,A)
        C = _finder_connected(GG)
        if length(C) > 0
            return C 
        end
    end
    return T[]

end

function _finder_connected(G::UG{T}) where T 
    C = girth_cycle(G)
    if all(deg(G).==2)
        return C
    end

    H = deepcopy(G)
    for v in C 
        delete!(H,v)
    end
    if is_connected(H)
        return C 
    end 
    return face_finder(H)
end
