# this code is designed to explore a graph to attempt to find attempt a face

using SimpleGraphs  # remove later
# export face_finder

function face_finder(G::SimpleGraph{T}) where T 
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

function _finder_connected(G::SimpleGraph{T}) where T 
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
