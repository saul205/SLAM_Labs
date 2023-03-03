%-------------------------------------------------------------------------
% University of Zaragoza
%
% Author:  J. Neira
%-------------------------------------------------------------------------
% SLAM for Karel the robot in 1D
%-------------------------------------------------------------------------

clear all; % varialbes
close all; % figures
randn('state', 1); % always use same random number sequence
rand('state', 1); % always use same random number sequence
format long

%-------------------------------------------------------------------------
% configuration parameters

global config;

% display correlation matrix and pause at every step
config.step_by_step = 0;

%number of robot motions for each local map
config.steps_per_map = 1000;

% figure counter (to always plot a new figure)
config.fig = 0;
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
% 1D world characteristics

global world;

% In the absolute W reference, these will not change during program execution
world.true_point_locations = [0.5:1:100000]';

% In the absolute W reference, this will change as the robot moves
world.true_robot_location = 0;

%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
% robot characteristics

global robot;

%    factor_x: fraction of the motion that constitutes odometry error
%     true_uk: ground true robot motion per step

robot.factor_x = 0.1; % ten percent
robot.true_uk = 1; % each true motion is 1m
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
% sensor characteristics
global sensor;

%     factor_z: measurement error is this fraction of the distance
%    range_min: minimum sensor range
%    range_max: maximum sensor range

sensor.factor_z = 0.01; % one percent
sensor.range_min = 0;
sensor.range_max = 2;
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
% all map details

global map;

%            R0: absolute location of base reference for map
%         hat_x: estimated robot and feature locations
%         hat_P: robot and feature covariance matrix
%             n: number of features in map
%        true_x: true robot and feature location (with respect to R0)
%      true_ids: true label of features in map (according to world)
%  stats.true_x: true robotlocation wrt R0 for the whole trajectory
% stats.error_x: robotlocation error at every step of the trajectory
% stats.sigma_x: robot location uncertainty at every step of the trajectory
%  stats.cost_t: computational cost (elapsed time) for each step
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
% measurements (not global, but this is the structure)

%            z_k: measured distance to all visible features
%            R_k: covariance of z_k
%          ids_f: true ids of the ones that are already in the map
%          ids_n: true ids of the ones that new to the map
%        z_pos_f: positions in z_r of ids_f
%        z_pos_n: positions in z_r of ids_n
%        x_pos_f: positions in hat_x of ids_f
%            z_f: z_k(ids_f), measurements to features already in the map
%            R_f: R_k(ids_f), meas. cov. to features already in the map
%            z_n: z_k(ids_n), measurements to features new to the map
%            R_n: R_k(ids_n), Meas. cov. to features new to the map
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
% BEGIN
%-------------------------------------------------------------------------
n_maps = 4;

map = Kalman_filter_slam (map, config.steps_per_map, world.true_robot_location);
map2 = struct();
map1 = map;
for i = 1:n_maps-1
    map1 = map;
    map2 = Kalman_filter_slam (map2, config.steps_per_map, world.true_robot_location);
    map = join_maps(map1, map2);
end
display_map_results (map);

%-------------------------------------------------------------------------
% END
%-------------------------------------------------------------------------
%-------------------------------------------------------------------------
% Map Joining
%-------------------------------------------------------------------------
function[map] = join_maps(map1, map2)

    m = map1.n;
    n = map2.n;
    
    A = sparse([eye(m + 1); ones(n, 1), zeros(n, m)]); 
    B = sparse([zeros(m+1, n); eye(n)]);

    map.hat_x = A * map1.hat_x + B * map2.hat_x(2:end);
    map.true_x = A * map1.true_x + B * map2.true_x(2:end);

    B = sparse([zeros(m+1, n+1); zeros(n, 1), eye(n, n)]);
    B(1,1) = 1;
    map.hat_P = A*map1.hat_P*A' + B*map2.hat_P*B';
    map.hat_x(1) = map2.hat_x(1) + map1.hat_x(1);
    map.true_x(1) = map2.true_x(1) + map1.true_x(1);

    map.true_ids = [map1.true_ids; map2.true_ids(2:end)];
    map.R0 = map1.R0;
    
    map.stats.true_x = [map1.stats.true_x; map2.stats.true_x(2:end) + map1.stats.true_x(end)];
    map.stats.error_x = [map1.stats.error_x; map2.stats.error_x(2:end) + map1.stats.error_x(end)];
    map.stats.sigma_x = [map1.stats.sigma_x; sqrt(map2.stats.sigma_x(2:end).^2 + map1.stats.sigma_x(end).^2)];
    map.stats.cost_t = [map1.stats.cost_t; map2.stats.cost_t(2:end)];

    map.n = n+m;
    
    % -------- Map fusion --------------------------------------------
    n = map.n + 1;
    
    % Find duplicated ids and their indexes
    counts = find(histcounts(map.true_ids, 0:max(map.true_ids)+1) >= 2) - 1;
    cols = reshape(find(ismember(map.true_ids, counts)), 2, []);

    H = sparse(zeros(size(counts, 2), n));

    rows = 1:size(counts, 2);
    idx = sub2ind([size(counts, 2), n], rows, cols(:, 1)');
    H(idx) = 1;
    idx = sub2ind([size(counts, 2), n], rows, cols(:, 2)');
    H(idx) = -1;

    K = (map.hat_P * H') / (H * map.hat_P * H');
    map.hat_x = map.hat_x + K * (-H * map.hat_x);
    map.hat_P = (eye(n) - K * H) * map.hat_P;
    
    % Delete features
    for d = counts
       b = find(map.true_ids == d);
       map.hat_x(b(end), :) = [];
       map.true_x(b(end), :) = [];
       map.true_ids(b(end), :) = [];
       map.n = map.n - 1;
       map.hat_P(b(end), :) = [];
       map.hat_P(:, b(end)) = [];
    end

end
%-------------------------------------------------------------------------
% Kalman_filter_slam
%-------------------------------------------------------------------------

function[map] = Kalman_filter_slam (map, steps, location)

% initial ground truth of hat_x 
map.true_x = zeros(steps);
map.true_x = [0];

% initial number of features
map.n = 0;

% initial map state and covariance
map.R0 = location;

map.hat_x = zeros(steps);
map.hat_x = [0];

map.hat_P = zeros(steps,steps);
map.hat_P = [0];

% feature ids, for robot = 0
map.true_ids = [0];

% useful statistics
map.stats.true_x = [0];
map.stats.error_x = [];
map.stats.sigma_x = [];
map.stats.cost_t = [];

for k = 0:steps
    
    tstart = tic;
    
    if k > 0
        [map] = compute_motion (map);
    end
    
    % get measurements
    [measurements] = get_measurements_and_data_association(map);
    
    % seen features already in the map? KF update!
    if not(isempty(measurements.z_f))
        [map] = update_map (map, measurements);
    end
    
    % some new features?
    if not(isempty(measurements.z_n))
        [map] = add_new_features (map, measurements);
    end
    
    % record statistics
    map.stats.error_x = [map.stats.error_x; (map.stats.true_x(end) - map.hat_x(1))];
    map.stats.sigma_x = [map.stats.sigma_x; sqrt(map.hat_P(1,1))];
    map.stats.cost_t = [map.stats.cost_t; toc(tstart)];
    
end
end

%-------------------------------------------------------------------------
% compute_motion
%-------------------------------------------------------------------------

function [map] = compute_motion (map)

global config;
global robot;
global world;

% move robot and update ground truth robot location
world.true_robot_location = world.true_robot_location + robot.true_uk;

% odometry error
sigma_xk = robot.factor_x * robot.true_uk;
error_k = randn(1)*sigma_xk;

% estimated motion
map.hat_x(1) = map.hat_x(1) + robot.true_uk + error_k;
map.hat_P(1,1) = map.hat_P(1,1) + sigma_xk^2;

% update ground truth for the current map
map.true_x(1) = map.true_x(1) + robot.true_uk;
map.stats.true_x = [map.stats.true_x; map.stats.true_x(end) + robot.true_uk];

if config.step_by_step
    fprintf('Move to %d...\n',map.true_x(1));
    plot_correlation(map.hat_P);
    pause
end
end

%-------------------------------------------------------------------------
% get_measurements
%-------------------------------------------------------------------------

function [measurements] = get_measurements_and_data_association(map)

global world;
global sensor;

distances = world.true_point_locations - world.true_robot_location;
visible_ids = find((distances >= sensor.range_min) & (distances <= sensor.range_max));
visible_d = distances(visible_ids);
n_visible = length(visible_ids);

% sensor error
sigma_z = sensor.factor_z * visible_d;
error_z = randn(n_visible, 1) .* sigma_z;

measurements.z_k = visible_d + error_z;
measurements.R_k = diag(sigma_z.^2);

% data association
measurements.ids_f = intersect(map.true_ids, visible_ids);
measurements.ids_n = setdiff(visible_ids, map.true_ids);
measurements.z_pos_f = find(ismember(visible_ids, measurements.ids_f));
measurements.z_pos_n = find(ismember(visible_ids, measurements.ids_n));
measurements.x_pos_f = find(ismember(map.true_ids, visible_ids));

%features already in the map
measurements.z_f = measurements.z_k(measurements.z_pos_f);
measurements.R_f = measurements.R_k(measurements.z_pos_f,measurements.z_pos_f);

%new features
measurements.z_n = measurements.z_k(measurements.z_pos_n);
measurements.R_n = measurements.R_k(measurements.z_pos_n,measurements.z_pos_n);

end

%-------------------------------------------------------------------------
% update_map
%-------------------------------------------------------------------------

function[map] = update_map (map, measurements)

global config;

% DO SOMETHING HERE!
% You need to compute H_k, y_k, S_k, K_k and update map.hat_x and map.hat_P

n = numel(measurements.ids_f);
a = zeros(n, map.n);

rows = 1:n;
cols = measurements.x_pos_f - 1;
idx = sub2ind([n, map.n], rows, cols);

a(idx) = 1;

H_k = [-ones(n, 1), a];
y_k = measurements.z_f - H_k*map.hat_x;
S_k = H_k * map.hat_P * H_k' + measurements.R_f;

K_k = map.hat_P*H_k'/S_k;

map.hat_x = map.hat_x + K_k*y_k;
map.hat_P = (eye(map.n + 1) - K_k*H_k)*map.hat_P;

if config.step_by_step
    fprintf('Updape map for last %d features...\n',length(measurements.ids_f));
    plot_correlation(map.hat_P);
    pause
end
end

%-------------------------------------------------------------------------
% add_new_features
%-------------------------------------------------------------------------

function [map] = add_new_features (map, measurements)

global config;
global world;

% DO SOMETHING HERE!
% update map.hat_x, map.hat_P, map.true_ids, map.true_x, map.n

m = map.n;
n = size(measurements.z_n, 1);

A = sparse([eye(m + 1); ones(n, 1), zeros(n, m)]); 
B = sparse([zeros(m+1, n); eye(n)]);
map.hat_x = A * map.hat_x + B * measurements.z_n;
map.hat_P = A*map.hat_P*A' + B*measurements.R_n*B';
map.true_x = A * map.true_x + B * (world.true_point_locations(measurements.ids_n) - world.true_robot_location);

map.n = m + n;
map.true_ids = [map.true_ids; measurements.ids_n];

if config.step_by_step
    fprintf('Add %d new features...\n',length(measurements.ids_n));
    plot_correlation(map.hat_P);
    pause
end
end

%-------------------------------------------------------------------------
% display_results
%-------------------------------------------------------------------------

function  display_map_results (map)

global config;

config.fig = config.fig + 1;
figure(config.fig);
axis([0 length(map.hat_x) -2*max(sqrt(diag(map.hat_P))) 2*max(sqrt(diag(map.hat_P)))]);
grid on;
hold on;
plot(map.true_ids, map.hat_x-map.true_x, 'ro','Linewidth', 2);
plot(map.true_ids, 2*sqrt(diag(map.hat_P)), 'b+','Linewidth', 2);
plot(map.true_ids, -2*sqrt(diag(map.hat_P)), 'b+','Linewidth', 2);
xlabel('Feature number (robot = 0)');
ylabel('meters (m)');
title('Map estimation error + 2sigma bounds');

config.fig = config.fig + 1;
figure(config.fig);
plot_correlation(map.hat_P);
title(sprintf('Correlation matrix of size %d', size(map.hat_P,1)));

config.fig = config.fig + 1;
figure(config.fig);
grid on;
hold on;
plot(map.stats.true_x, map.stats.cost_t,'r-','Linewidth',2);
xlabel('step');
ylabel('seconds');
title('Cost per step');

config.fig = config.fig + 1;
figure(config.fig);
grid on;
hold on;
plot(map.stats.true_x,cumsum(map.stats.cost_t),'r-','Linewidth',2);
xlabel('step');
ylabel('seconds');
title('Cumulative cost');

config.fig = config.fig + 1;
figure(config.fig);
axis([0 map.stats.true_x(end) -2*max(map.stats.sigma_x) 2*max(map.stats.sigma_x)]);
grid on;
hold on;
plot(map.stats.true_x, map.stats.error_x,'r-','Linewidth',2);
plot(map.stats.true_x, 2*map.stats.sigma_x,'b-','Linewidth',2);
plot(map.stats.true_x,-2*map.stats.sigma_x,'b-','Linewidth',2);
xlabel('meters (m)');
ylabel('meters (m)');
title('Robot estimation error + 2sigma bounds');

end

%-------------------------------------------------------------------------
% plot_correlation
%-------------------------------------------------------------------------

function plot_correlation(P)

ncol=256 ;

% hot cold colormap
cmap=hsv2rgb([linspace(2/3, 0, ncol)' 0.9*ones(ncol,1) ones(ncol,1)]) ;
cmap(1,:)=[0 0 0] ;
colormap(cmap) ;

corr = correlation(P);
imagesc(abs(corr), [0 1]) ;  % no sign

axis image;
colorbar ;

end

%-------------------------------------------------------------------------
% correlation
%-------------------------------------------------------------------------

function Corr=correlation(Cov)

sigmas = sqrt(diag(Cov));
Corr = diag(1./sigmas)*Cov*diag(1./sigmas);

end
