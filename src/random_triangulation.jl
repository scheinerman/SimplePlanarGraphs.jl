using Triangle
export Triangulation, RandomTriangulation
"""
`RandomTriangulation(n)` creates a random `n`-vertex planar graph 
all of whose bounded faces are triangles. 
"""
function RandomTriangulation(n::Int)::SimpleGraph{Int}
    pts = rand(n,2)
    G = Triangulation(pts)
    embed(G,:tutte)
    name(G,"Random Triangulation")
    return G
end 


"""
`Triangle(point_list)` creates a graph that is the Delauney triangulation
of the `n`-by-`2` matrix `point_list` whose rows give the coordinates 
of the points. 
"""
function Triangulation(pts::Array{Float64,2})::SimpleGraph 
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
    embed_rot(G)
    name(G,"Triangulation")
    return G 
end
