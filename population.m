function [pop] = population(m, D, min_var, max_var)
    for i = 1:m
        pop = rand(1, D) .* (max_var(1, :) - min_var(1, :)) + min_var(1, :);
    end
end