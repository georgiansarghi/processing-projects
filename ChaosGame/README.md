Wiki: [Chaos game](https://en.wikipedia.org/wiki/Chaos_game)

The "Chaos Game" is a form of iterated function system (IFS) (see below). The process to generate one of these is rather simple. For examle, to generate a Sierpinski triangle:

1. Start with a set of vertices that form a triangle ($s = 3$)
2. Choose a random point anywhere in the plane.
3. Randomly select one of the vertices of the triangle.
4. Move the point halfway ($r = 1/2$) towards the selected vertex.
5. Go to step 3.

For different regular polygons, you might want to choose $r$ to be the so-called "kissing number" of the polygon (see wiki page). The wiki page also explains modifications to the algorithm that are quite interesting.

![Chaos Game 2D](./results/chaos_2d_kissing.gif)
