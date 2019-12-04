function [pop_cost] = goal_function(pop, m, D)
    cost = zeros(m, 1);
    for i = 1:m
        cost(i, 1) = sphere_objf(pop(i, :));
        pop_cost(i, 1:D+1) = [pop(i, 1:D), cost(i, 1)];
    end
end