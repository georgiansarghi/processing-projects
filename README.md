# processing-projects

These are some of my old Processing projects. Some of the images generated with these programs ended up in my [high-school thesis](./.assets/tesina.pdf) (if you don't know italian, you may still enjoy the pictures :)).

## [Chaikin's Algorithm](ChaikinsCurve)

A simple implementation of Chaikin's Algorithm for curve smoothing.

![Chaikin's Algorithm](./ChaikinsCurve/results/chaikins_inverted.gif)

## [Chaos Game](ChaosGame)

This Processing project called "Chaos Game" demonstrates a form of iterated function system (IFS). The "game" generates fractal patterns by repeatedly moving a point towards randomly chosen vertices of a polygon, based on a set ratio. By adjusting the number of sides and the ratio, you can explore different fractal shapes.

![Chaos Game 2D](./ChaosGame/results/chaos_2d.gif)

## [Chaos Game 3D](ChaosGame3D)

This project is the 3D version of the "Chaos Game". It generates fractal patterns by moving a point towards randomly chosen vertices of a tetrahedron.

![Chaos Game 3D](./ChaosGame3D/results/chaos_3d_short.gif)

## [Coastline](Coastline)

This project generates fractal coastlines using a recursive line subdivision approach. Starting with a square, each line is repeatedly divided into two segments with a random offset, creating a jagged, natural-looking coastline.

![Coastlines](./Coastline/results/coastlines.gif)

## [De Jong Attractor](DeJongAttractor)

This project visualizes a 3D variation of the De Jong attractor.

![De Jong Attractor](./DeJongAttractor/results/mille.png)

## [Diffusion Limited Aggregation](DiffusionLimitedAggregation)

This project simulates Diffusion Limited Aggregation (DLA), a process where particles undergo random motion and stick together to form aggregates. The setup starts with a central attractor particle and multiple smaller particles scattered randomly across the screen. The particles move towards the attractor, and if they collide with the attractor or with other "dead" particles, they become "dead" themselves and stop moving.

![Diffu](./DiffusionLimitedAggregation/results/dla_2_30x.gif)

## [Elastic Collisions](ElasticCollisions)

This project simulates elastic collisions between multiple balls in a 2D environment. The setup initializes a grid of balls, each with a random initial velocity, and one of the balls is marked with a distinct color to track the influence of a single ball on the system. The balls move around the screen, bouncing off the walls and each other, conserving momentum and kinetic energy during collisions.

![Elastic Collisions](./ElasticCollisions/results/collisions.gif)

## [Elementary Cellular Automata](ElementaryCellularAutomata)

This project is an implementation of the well known 1D Elementary Cellular Automaton, a discrete model studied in automata theory. The automaton evolves over time based on a specific rule set, which determines the state of each cell in the next generation based on the state at the same position and its neighbors in the previous generation. This means that, for every possible configuration of three cells, a rule specifies the state of the center cell in the next generation. This means that there are $2^{2^3} = 256$ possible rules. The rules shown below are 73, 126, 45 and 30, all with a single bit set to 1 (in the center) as the initial condition.

![Elementary Cellular Automata](./ElementaryCA/results/ca.gif)

## [Gravity](Gravity)

![Gravity](./GravityField/results/gravity.gif)

![Gravity](./GravityField/results/test_small.png)

![Julia and Mandelbrot](./JuliaSets2/results/julia_mandelbrot_inverted_crop.gif)

![Logistic Map](./LogisticMap/results/logistic_map_inverted.gif)

![Lorenz Attractor](./LorenzAttractor2/results/lorenz_crop.gif)

![Mandelbrot Set](./Mandelbrot/results/mandel_2.gif)

![Pythagoras Tree](./PythagorasTree/results/pythagoras_2x.gif)

![Iterated Function System - Tree](./SimpleIFS/results/tf_x2.gif)

![Ulam Spiral](./UlamSpiral/ulam.gif)
