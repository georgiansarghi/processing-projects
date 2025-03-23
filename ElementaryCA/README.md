
Wiki: [Elementary cellular automaton](https://en.wikipedia.org/wiki/Elementary_cellular_automaton)

An implementation of the well known 1D elementary cellular automaton. The automaton evolves over time based on a specific rule, which determines the state of each cell in the next generation based on the state at the same position and its neighbors in the previous generation. This means that, for every possible configuration of three cells ($2^3$), a rule specifies the state of the center cell in the next generation. This gives $2^{2^3} = 256$ possible rules.

The rules shown below are 73, 126, 45 and 30, all with a single bit set to 1 (in the center) as the initial condition.

![Elementary Cellular Automata](./results/ca.gif)
