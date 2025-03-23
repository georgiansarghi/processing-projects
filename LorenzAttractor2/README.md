Wiki: [Lorenz system](https://en.wikipedia.org/wiki/Lorenz_system)

The Lorenz system is a set of three ordinary differential equations that describe a simple model of atmospheric convection. Edward Lorenz discovered that the system exhibits chaotic behavior for certain parameter values. The equations are:

$$
\begin{aligned}
\dot{x} &= \sigma(y - x) \\
\dot{y} &= x(\rho - z) - y \\
\dot{z} &= xy - \beta z
\end{aligned}
$$

where $\sigma, \rho, \beta \in \mathbb{R}.$

The GIF below shows the evolution of 300 slightly different initial conditions in the Lorenz system with $\sigma = 10, \rho = 28, \beta = 8/3$. Even if the initial conditions are very close, the trajectories diverge exponentially fast.

![Lorenz Attractor](./results/lorenz_crop.gif)
