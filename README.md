# SimplePlanarGraphs




Experimental (for now) place to try out planarity algorithms 
in support of `SimpleGraphs`. 

**Caveat Emptor**: This code is not ready for prime time! This is not a registered module, so to install
use 
```
]dev https://github.com/scheinerman/SimplePlanarGraphs.jl.git
```

## Generating Planar Graphs

The function `RandomTriangulation(n::Int)` creates an `n`-vertex planar graph in 
which all faces, except perhaps the outside face, are triangles. 

It uses the `Triangulation(pts)` function where `pts` is an `n`-by-`2` array
of numbers. This builds the Delauney triangulation graph on those points.

## Planarity Testing

The function `is_planar` tests if a graph has a planar embedding. 

The current implementation is based on Schnyder's theorem that connects planarity
to poset dimension. It works, but isn't speedy.


## Counting Crossings

The function `count_cross(G)` counts the number of crossings in the `xy`-embedding 
of the graph `G`.

## Face Finder

The function `face_finder(G)` returns the vertices of a cycle of `G` that might be 
a face in some planar embedding. Tons of caveats here:
* The graph might be planar and `face_finder` might fail to return a face.
* The graph might be nonplanar and yet `face_finder` returns a cycle. 

However, we think the following is true:
* If the graph is planar and 3-connected, and if `face_finder` returns a cycle of the 
graph, then that cycle is a face in some planar embedding of `G`. 

To test if that works, we can use that face to create a Tutte embedding and derive a 
rotation system from that. Then we can calculate the Euler characteristic. If that
returns 2, then for sure we have a planar graph and the rotation system associated
with the graph is a planar embedding. 

### Method

The idea is that we assume the graph `G` is planar and find a short cycle `C`. If 
deleting that cycle from `G` leaves a connected graph, then that cycle
is a face of `G`.

### Example

The `BuckyBall()` graph is created with a planar embedding/rotation system in place,
so we can calculate its planar dual. That's a planar graph, but the `dual` function
doesn't give its output a rotation system (it should, just haven't done that yet).

In this example, we set up `G` as the dual of the `BuckyBall` and note that the default
rotation system it gets is far from planar. We then use `face_finder` to find a face 
and then use that as the outside face of a Tutte embedding. From there we derive a
rotation system and note that it is planar.

```julia
julia> G = relabel(dual(BuckyBall()))
SimpleGraph{Int64} (n=32, m=90)

julia> euler_char(G)
[ Info: Giving this graph, UndirectedGraph{Int64} (n=32, m=90), a default rotation system.
-54

julia> F = face_finder(G)
3-element Array{Int64,1}:
  1
 24
  2

julia> embed(G,:tutte,outside=F)

julia> embed_rot(G)

julia> euler_char(G)
2
```
