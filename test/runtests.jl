using Test, SimpleGraphs, SimplePlanarGraphs
@test count_cross(Icosahedron())==0
G = Cube(3)
embed(G,:combined)
@test count_cross(G) == 2

G = RandomTriangulation(17)
@test count_cross(G) == 0
@test euler_char(G) == 2
H = dual(G)
embed(H,:tutte)
@test count_cross(H) == 0
@test euler_char(H) == 2
