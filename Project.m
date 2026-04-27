%% Optimal Control Course Project: Stochastic Portfolio Rebalancing

clear; clc; close all;

% --- 1. Parameters ---
T = 1;              % Time horizon (1 year)
dt = 1/252;         % Time step (daily)
time = 0:dt:T;      % Time vector
N_steps = length(time);
N_paths = 2000;     % Higher paths for smoother histograms

r = 0.03;           % Risk-free rate (3%)
mu = 0.08;          % Expected stock return (8%)
sigma = 0.20;       % Stock volatility (20%)
gamma = 3;          % Risk aversion coefficient (The Controller's "Tuning")
W0 = 1000;          % Initial wealth

% --- 2. Define Control Strategies ---
% Strategy 1: Optimal (Derived from HJB: u* = (mu - r) / (sigma^2 * gamma))
u_star = (mu - r) / (sigma^2 * gamma);

% Strategy 2: Fixed 50/50 Split
u_half = 0.50;

% Strategy 3: Benchmark (100% Stocks)
u_bench = 1.00;

fprintf('--- Control Strategies ---\n');
fprintf('Optimal Strategy (u*): %.2f%%\n', u_star * 100);
fprintf('Balanced Strategy:     %.2f%%\n', u_half * 100);
fprintf('Aggressive Strategy:   %.2f%%\n\n', u_bench * 100);

% --- 3. Pre-allocate Wealth Arrays ---
W_opt   = zeros(N_paths, N_steps);
W_half  = zeros(N_paths, N_steps);
W_bench = zeros(N_paths, N_steps);

W_opt(:,1)   = W0;
W_half(:,1)  = W0;
W_bench(:,1) = W0;

% --- 4. Monte Carlo Simulation (Discretized SDE) ---
for i = 1:N_paths
    for t = 1:N_steps-1
        Z = randn(); % Standard Normal Random Variable (dW = Z*sqrt(dt))
        
        % Optimal Update
        W_opt(i, t+1) = W_opt(i, t) + W_opt(i, t) * ...
            ((r + u_star*(mu - r))*dt + u_star*sigma*sqrt(dt)*Z);
        
        % 50/50 Update
        W_half(i, t+1) = W_half(i, t) + W_half(i, t) * ...
            ((r + u_half*(mu - r))*dt + u_half*sigma*sqrt(dt)*Z);
        
        % Benchmark Update
        W_bench(i, t+1) = W_bench(i, t) + W_bench(i, t) * ...
            ((r + u_bench*(mu - r))*dt + u_bench*sigma*sqrt(dt)*Z);
    end
end

% --- 5. Calculate Expected Utility ---
% U(W) = W^(1-gamma) / (1-gamma)
util_opt   = (W_opt(:, end).^(1-gamma)) / (1-gamma);
util_half  = (W_half(:, end).^(1-gamma)) / (1-gamma);
util_bench = (W_bench(:, end).^(1-gamma)) / (1-gamma);

% --- 6. Visualization ---

% Figure 1: Trajectories Comparison
figure('Name', 'Wealth Trajectories', 'Position', [100, 100, 1200, 400]);
subplot(1,3,1);
plot(time, W_opt(1:30, :)', 'Color', [0 0.6 0 0.2]); hold on;
plot(time, mean(W_opt), 'k', 'LineWidth', 2); title('Optimal (u=0.42)');
grid on; ylabel('Wealth'); ylim([600 1400]);

subplot(1,3,2);
plot(time, W_half(1:30, :)', 'Color', [0 0 0.8 0.2]); hold on;
plot(time, mean(W_half), 'k', 'LineWidth', 2); title('Balanced (u=0.50)');
grid on; ylim([600 1400]);

subplot(1,3,3);
plot(time, W_bench(1:30, :)', 'Color', [0.8 0 0 0.2]); hold on;
plot(time, mean(W_bench), 'k', 'LineWidth', 2); title('Aggressive (u=1.0)');
grid on; ylim([600 1400]);

% Figure 2: Final Wealth Distribution (Histogram)
figure('Name', 'Final Wealth Distribution');
histogram(W_half(:, end), 'Normalization', 'pdf', 'FaceColor', 'b', 'FaceAlpha', 0.8); hold on;
histogram(W_bench(:, end), 'Normalization', 'pdf', 'FaceColor', 'r', 'FaceAlpha', 0.6);
histogram(W_opt(:, end), 'Normalization', 'pdf', 'FaceColor', 'g', 'FaceAlpha', 0.4); 
title('Comparison of Distribution of Final Wealth');
legend('Optimal (HJB)', '50/50 Split', '100% Stock');
xlabel('Final Wealth (W_T)'); ylabel('Probability Density');
grid on;

% --- 7. Final Results Output ---
fprintf('--- Final Performance Results ---\n');
fprintf('Strategy      | Mean Wealth | Expected Utility\n');
fprintf('----------------------------------------------\n');
fprintf('Optimal (HJB) | %.2f      | %.8f\n', mean(W_opt(:,end)), mean(util_opt));
fprintf('50/50 Split   | %.2f      | %.8f\n', mean(W_half(:,end)), mean(util_half));
fprintf('Aggressive    | %.2f      | %.8f\n', mean(W_bench(:,end)), mean(util_bench));

fprintf('\nNote: The "Optimal" strategy should have the HIGHEST (least negative) Expected Utility,\n');
fprintf('even if it does not have the highest Mean Wealth.\n');