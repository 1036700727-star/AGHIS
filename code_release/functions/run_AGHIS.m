function [hat_y_t] = run_AGHIS(Y, X, id_list, eta, rho)


[~, d] = size(X);

w = zeros(d,1);

gv_t = zeros(d,1);
m_t = zeros(d,1);

Weight = 1;

Num_P = 0;
Num_N = 0;

W_GD_P = 0;
W_GD_N = 0;

lambda = 0.001;
gamma = 2;
M = 1;

hat_y_t = zeros(1,length(id_list));

for t = 1:length(id_list)

    ID = id_list(t);
    x_t = X(ID,:)';
    y_t = Y(ID);

    f_t = w' * x_t;

    if f_t >= 0
        hat_y_t(t) = 1;
    else
        hat_y_t(t) = -1;
    end

    if y_t == 1
        Num_P = Num_P + 1;
    else
        Num_N = Num_N + 1;
    end

    if y_t * f_t <= 1

        h_t = y_t * f_t;

        l_t = -(1/M) * (max(0,1-h_t)^2) * log(1/(1 + exp(-h_t)));

        if t > 2

            if y_t == 1
                Weight = rho * l_t * 2 * Num_N / max(Num_P,1) * W_GD_N / max(W_GD_P + W_GD_N,1);
            else
                Weight = l_t * 2 * W_GD_P / max(W_GD_P + W_GD_N,1);
            end

            if Weight > 2e2
                Weight = 2e2;
            elseif Weight < 1e-2
                Weight = 1e-2;
            end

        end

        der_l_t = (1/M) * (gamma * (1-h_t) * log(1/(1 + exp(-h_t))) * y_t * x_t - ((1-h_t)^gamma) * (1 - 1/(1 + exp(-h_t))) * y_t * x_t);

        gv_t = gv_t + der_l_t .* der_l_t;
        m_t = der_l_t;

        adaptive_g = gv_t;

        for j = 1:length(adaptive_g)

            if adaptive_g(j) == 0
                adaptive_g(j) = 0;
            else
                adaptive_g(j) = adaptive_g(j)^(-1/2);
            end

        end

        w = w - Weight * eta * (adaptive_g .* m_t);

        w = w * min(1, 1/(sqrt(lambda) * sum(abs(w))));

        if y_t == 1
            W_GD_P = W_GD_P + norm(Weight * eta * adaptive_g .* m_t);
        else
            W_GD_N = W_GD_N + norm(Weight * eta * adaptive_g .* m_t);
        end

    end

end