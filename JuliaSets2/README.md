
Wiki: [Julia Sets](https://en.wikipedia.org/wiki/Julia_set)

The Julia set of a complex number $c$ is the set of points $z \in \mathbb{C}$ for which the sequence

$$
\begin{aligned}
z_0 &= z\\
z_{n+1} &= z_n^2 + c \space\space\space\space\space  n \in \mathbb{N}
\end{aligned}
$$

does not diverge. The difference with the Mandelbrot set is that in the Julia set, $c$ is fixed and $z_0$ varies.

In the GIF below you can see how the value of $c$ viewed in relation to the Mandelbrot set affects the shape of the Julia set. For example, the Julia set is connected if and only if $c$ is in the Mandelbrot set, and it is a Cantor set if $c$ is in the complement of the Mandelbrot set. You may try this program and see if you can find other interesting properties of the Julia sets (e.g. observe the number of "petals" in the Julia sets changes as you change $c$).

![Julia and Mandelbrot](./results/julia_mandelbrot_inverted.gif)
