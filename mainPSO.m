clc;
close all;

for zz = 1:1
    tic
    clc
    % F_idx = 14
    main_run = zz;
    GBEST = [];
    n_swarm = 100; % number of initial population
    iter = 300; % number of iteration
    c1 = 2;
    c2 = 2;
    w = 0.8;
    dim = 17;
    min_var = [-1 * ones(1, 10)];
    max_var = [1 * ones(1, 10)];

    D = length(max_var); % number of variable
    Nparam = D;
    [s, n_var] = size(max_var);
    upper_v = .2 .* max_var;
    lower_v = -.2 .* max_var;
    m = n_swarm;

    for i = 1:n_swarm
        [pop] = population(1, D, min_var, max_var);
        [pop_cost(i, :)] = goal_function(pop, 1, D);
    end
    
    pop;
    pop_cost;
    pop_cost_sort = sortrows(pop_cost, n_var+1);
    g_best = pop_cost_sort(1, :);
    p_best(1:n_swarm, :) = pop_cost(1:n_swarm, :);
    for i = 1:n_swarm
        v(i, :) = zeros(1, n_var);
    end
    pop_cost2 = zeros(n_swarm, n_var+1);

    g_best1 = g_best;

    %%
    for i = 1:iter
        clc;
        main_run = zz;
        iteration = i;
        for j = 1:n_swarm
            c2 = 2;
            c1 = 2;
            v(j, :) = c1 * rand * (p_best(j, 1:n_var) - pop_cost(j, 1:n_var)) + ...
                c2 * rand * (g_best(1, 1:n_var) - pop_cost(j, 1:n_var)) + ...
                w * v(j, 1:n_var);

            xxxz = find(v(j, :)-upper_v > 0);
            v(j, xxxz) = upper_v(xxxz);
            xxxz = find(v(j, :)-lower_v < 0);
            v(j, xxxz) = lower_v(xxxz);

            pop_cost_new1(j, 1:n_var) = pop_cost(j, 1:n_var) + v(j, 1:n_var);

            pop = pop_cost_new1(j, 1:n_var);
            s3 = find(pop(1, 1:D)-max_var > 0);
            pop(s3) = max_var(s3);
            s4 = find(min_var-pop(1, 1:D) > 0);
            pop(s4) = min_var(s4);
            [pop_cost1] = goal_function(pop, 1, n_var);
            if pop_cost1(1, end) < p_best(j, end)
                p_best(j, :) = pop_cost1(1, :);
            end
            pop_cost2(j, :) = pop_cost1(1, :);
        end
        pop_cost = pop_cost2;
        pop_cost_sort = sortrows(pop_cost, n_var+1);
        g_best1 = pop_cost_sort(1, :);

        if g_best1(1, end) < g_best(1, end)
            g_best = g_best1;
        end

        p(zz, :) = g_best(1, :);
        lll(zz, i) = g_best(1, end);
        GBEST(1, i) = g_best(1, end);
    end
    g_best;
    res_PSO.etime(zz) = toc;
    res_PSO.x_best(zz, :) = g_best(1:end-1);
    res_PSO.f_best(zz) = g_best(end);
    res_PSO.plot_best(zz, :) = GBEST;

end
res_PSO.etime(zz)
res_PSO.x_best(zz, :)
zzzs = [p, lll];
p;
save('res_PSO_RPO', 'res_PSO')
BFV = min(res_PSO.f_best);
AVB = mean(res_PSO.f_best);
stdev = std(res_PSO.f_best);
%
plot(res_PSO.plot_best(zz, :), '-', 'linewidth', 2)
