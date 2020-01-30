using JuMP, Cbc, Printf

function LP(c1,c2,o1,o2)
	
	m = Model(with_optimizer(Cbc.Optimizer, logLevel=1))

	@variable(m, 0 <= x <= 2 )
	@variable(m, 0 <= y <= 30 )

	@objective(m, Max, o1*x + o2*y )

	@constraint(m, c1*x + c2*y <= 3.0 )

	print(m)
	status = optimize!(m)

	println("Objective value: ", JuMP.objective_value(m))
	println("x = ", JuMP.value(x))
	println("y = ", JuMP.value(y))
	return JuMP.value(x), JuMP.value(y), JuMP.objective_value(m)
end
