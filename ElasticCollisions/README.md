
Wiki: [Elastic collision](https://en.wikipedia.org/wiki/Elastic_collision)

A simulation of elastic collisions between multiple balls in a 2D environment. The setup initializes a grid of balls, each with a random initial velocity, and one of the balls is marked red to track it's influence on the system. This is not an impressive feat, but getting the collisions right took me more time than I'd like to admit.

This similation can be used to demonstrate "high sensitivity to initial conditions". More precisely, if you nudge one of the balls just a tiny bit, the whole system will evolve in a completely different way given enough time.

The simulation could be optimized in various ways, such as using a priority queue to keep track of the next collisions.
![Elastic Collisions](./results/collisions.gif)
