Wiki: [Logistic map](https://en.wikipedia.org/wiki/Logistic_map)

This is a simple implementation of the logistic map fractal. The logistic map is a simple mathematical model for population growth, defined by the recursive formula:

$$x_{n+1} = r \cdot x_n \cdot (1 - x_n).$$

Here, $x_n$ is the population at time $n$ and $r$ is a parameter that you could think of as a growth rate.

Below, the $x$-axis represents the parameter $r$ (in the interval $[3, 4]$), and the $y$-axis represents the population. Starting from a population of $x_0 = 0.5$, we plot the populations $x_0, x_1, x_2, \ldots, x_{N}$ for a fixed number of iterations $N$. Initially (smaller values of $r$) the population converges to a stable equilibrium, but as $r$ increases, the system undergoes a period-doubling cascade and eventually enters a chaotic regime. The fun part of this project is that you can zoom in on the bifurcation diagram and see it's fractaly nature :D

![Logistic Map](./results/logistic_map_inverted.gif)

This kind of period doubling cascade is a common feature of chaotic systems. The "Feigenbaum constant" $\delta \approx 4.6692016091029909$ is a universal constant that describes the rate at which the period-doubling bifurcations occur as $r$ increases. ((This is also the ratio of radii of successive circles in the Mandelbrot set, which of course is not a coincidence, but if you ask me why, I would probably show you [this image](https://www.researchgate.net/profile/Tssachin-Venkatesh/publication/343986739/figure/fig1/AS:930432354897922@1598843768697/The-real-line-on-the-mandelbrot-set-lines-up-with-the-bifurcations-in-the-logistic-map-1.jpg) and try to pass it as an explanation.))
