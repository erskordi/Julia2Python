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

I included all the Julia files here, along with the data files necessary for the TSP example.

The first example is a very small and simple linear program where some of the constants are given as function arguments from Python. You can use it to verify that everything works fine. 

```python
from julia.api import Julia

jl = Julia(compiled_modules=False) # this is necessary due to some incompatibilities that have to do with the current version of these packages.
from julia import Main # make sure to import Main AFTER command jl=Julia(compiled_modules=False) due to the aforementioned incompatibilities
fn = Main.include('./script.jl')

fn(1,5,5,3) # these values are from the original version of the LP
```

Finally, for the TSP, the input is the table of distances between the cities, and a path to save the txt of the outputs (This code extacts the objective function value). We can have any kind of inputs, scalars, vectors, tables. 

Basically, we can extract any value from the Julia script.

```python
from julia.api import Julia

jl = Julia(compiled_modules=False) # this is necessary due to some incompatibilities that have to do with the current version of these packages.
from julia import Main

fn = Main.include('./tsp.jl')
fn("./tsp_25_1.txt","./")
```

