using Triangle
export triangulation, random_triangulation
"""
`random_triangulation(n)` creates a random `n`-vertex planar graph 
all of whose bounded faces are triangles. 
"""
function random_triangulation(n::Int)::SimpleGraph{Int}
    pts = rand(n,2)
    G = triangulation(pts)
    embed_rot(G)
    embed(G,:tutte)
    return G
end 

function triangulation(pts::Array{Float64,2})::SimpleGraph 
    n,c = size(pts)
    G = IntGraph(n)
    idx = collect(1:n)
    TT = basic_triangulation(pts,idx)
    xy = Dict{Int,Array{Float64,1}}()
    for v = 1:n
        xy[v] = pts[v,:]
    end

    for T in TT 
        a,b,c = T 
        add!(G,a,b)
        add!(G,a,c)
        add!(G,b,c)
    end 
    embed(G,xy)
    return G 
end
