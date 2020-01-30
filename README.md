# Julia2Python

[Julia installation for Mac](https://www.softcover.io/read/7b8eb7d0/juliabook/introduction#sec-julia_mac)

In the Terminal, hit *julia*, and install JuMP and Cbc for optimization solver (this is the COIN-OR solver, it's free and quite powerful).

Also, install *PyCall* to connect with Python

```julia
using Pkg

Pkg.add("JuMP")
Pkg.add("Cbc")
Pkg.add("PyCall")
```

After that, follow the instructions presented in the answer section [here](https://stackoverflow.com/questions/49750067/running-julia-jl-file-in-python)

## Run Julia from Python



Finally, run the code below. I included two examples: 

a) The first example is a very small and simple linear program where some of the constants are given as function arguments from Python

