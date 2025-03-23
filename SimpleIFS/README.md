
Wiki: [Iterated function system](https://en.wikipedia.org/wiki/Iterated_function_system), [Fractal Compression](https://en.wikipedia.org/wiki/Fractal_compression)

This project generates fractal patterns using an iterated function system (IFS).
This is similar in spirit to the "Chaos Game" project, but the IFS definition is more general.

An IFS is a collection of functions that are applied iteratively to a point in the plane. The functions are chosen randomly from a set of affine transformations, and the point is moved according to the chosen function. If the maps are contractive, the generated points will converge to an "attractor" that is often a fractal. One could also use non-linear transformations, and you would still have convergence :)

For example, the Barnsley fern is defined in code as follows:

```java
ifs.addFunction(new Function(0.85, 0.04, -0.04, 0.85, 0, 1.60, 0.85)); //  Successively smaller leaflets
ifs.addFunction(new Function(0.20, -0.26, 0.23, 0.22, 0, 1.60, 0.07)); //  Largest left-hand leaflet
ifs.addFunction(new Function(-0.15, 0.28, 0.26, 0.24, 0, 0.44, 0.07)); //  Largest right-hand leaflet
ifs.addFunction(new Function(0, 0, 0, 0.16, 0, 0, 0.01)); // Stem
```

The first 4 parameters of each function are the coefficients of the linear transformation, the next 2 are the translation, and the last one is the probability of choosing that function in the next iteration.

Starting from a random point, the program applies the functions iteratively, and you can see the fern emerge (on the right side of the GIF below).

![Iterated Function System - Tree](./results/tf_x2.gif)
