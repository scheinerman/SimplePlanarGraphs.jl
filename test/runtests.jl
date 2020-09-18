using Test, SimpleGraphs, SimplePlanarGraphs
@test count_cross(Icosahedron())==0
G = Cube(3)
embed(G,:combined)
@test count_cross(G) == 2
