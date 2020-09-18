export count_cross

function _orientation(a, b, c)
    A = ones(3, 3)
    A[1, 2:3] = a
    A[2, 2:3] = b
    A[3, 2:3] = c
    return sign(det(A))
end

function _cross(a, b, c, d)::Bool
    if _orientation(a, b, c) * _orientation(a, b, d) >= 0
        return false
    end
    if _orientation(c, d, a) * _orientation(c, d, b) >= 0
        return false
    end
    return true
end

"""
`count_cross(G::SimpleGraph)` returns the number of edge crossings
in the `xy`-embedding of this graph. 
"""
function count_cross(G::SimpleGraph)::Int
    EE = elist(G)
    m = length(EE)
    count = 0
    xy = getxy(G)
    for i = 1:m-1
        e1 = EE[i]
        a = xy[e1[1]]
        b = xy[e1[2]]
        for j = i+1:m
            e2 = EE[j]
            if length(intersect(e1, e2)) == 0 # common end point doesn't count
                c = xy[e2[1]]
                d = xy[e2[2]]
                if _cross(a,b,c,d)
                    count += 1
                end
            end
        end

    end
    return count
end