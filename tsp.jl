using JuMP, Cbc, Distances 

function TSP(file_name::String, return_values::String)

	#file_name = "tsp_25_1.txt"
	#f = open("/Users/erotokritos/Desktop/" * file_name);
	f = open(file_name);
	lines = readlines(f)
	N = length(lines)
	#println("N: ", N)

	c_pos = [Vector{Float64}(undef, 2) for _ in 1:N]

	for i = 1:N
    	    x_str, y_str = split(lines[i])
            c_pos[i] = [parse(Float64, x_str), parse(Float64, y_str)]
	end

	m = Model(with_optimizer(Cbc.Optimizer, logLevel=1, allowableGap=50))
	@variable(m, x[1:N,1:N], Bin)
	@variable(m, u[2:N], Int)
	@objective(m, Min, sum(x[i,j]*euclidean(c_pos[i],c_pos[j]) for i=1:N,j=1:N))
	for i=1:N 
            @constraint(m, x[i,i] == 0)
            @constraint(m, sum(x[i,1:N]) == 1)
	end
	for j=1:N
            @constraint(m, sum(x[1:N,j]) == 1)
	end
	for f=1:N, t=1:N
            @constraint(m, x[f,t]+x[t,f] <= 1)
	end
	for i=2:N, j=2:N
	  if i != j
            @constraint(m, u[i]-u[j]+N*x[i,j] <= N-1)
          end
	end
	for i=2:N
          @constraint(m, u[i]>=0)
	  @constraint(m, u[i]<=N-1)
	end
	

 	#print(m)
	
	optimize!(m)

	println("Objective value: ", JuMP.objective_value(m))
	#println("x = ", JuMP.value.(x))
	#return JuMP.value(x), JuMP.objective_value(m)

	f = open(return_values * "results.txt", "w")
        println(f, "Objective value: ", JuMP.objective_value(m))
        close(f);
end
