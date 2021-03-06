format compact

n = 5;
n2 = 5;
n3 = 5;
tdot_max = 2500;
mag_max = sqrt(3/2)*200;
tdot = linspace(0.01, tdot_max, n3);

phase_min = pi/2;
phase_max = pi;
mag_vec = linspace(1, sqrt(3/2)*200, n2);
phase = linspace(phase_min, phase_max, n);
torque_vec = zeros(length(n), 4);

% mag_log_vec = zeros(length(n2)*length(n3), 1);
% phi_max_vec = zeros(length(n2)*length(n3), 1);
% torque_max_vec = zeros(length(n2)*length(n3), 1);
% tdot_vec = zeros(length(n2)*length(n3), 1);
% i_mag_vec =  zeros(length(n2)*length(n3), 1);

count = 1;

for k = 1:n3
    for x = 1:n
        [t, t_pm, t_rel, i_mag] = motor_fun(mag_max, phase(x), tdot(k));
        torque_vec(x,:) = [t, t_pm, t_rel, i_mag];
    end
    t_max = max(torque_vec(:,1));
    ind = find(torque_vec(:,1) == t_max);
    phi_max = phase(ind);
    i_mag_max = torque_vec(ind,4);
    
    t_max_vec(k) = t_max;
    phi_max_vec(k) = phi_max;
    i_mag_max_vec(k) = i_mag_max;
    k
    
end

figure;plot(tdot, t_max_vec);
figure;plot(tdot, phi_max_vec);
figure;plot(tdot, i_mag_max_vec);

%{
for k = 1:n3
    for j = 1:n2
        parfor x = 1:n
            [t, t_pm, t_rel, i_mag] = motor_fun(mag_vec(j), phase(x), tdot(k));
            torque_vec(x,:) = [t, t_pm, t_rel, i_mag];
        end
        t_max = max(torque_vec(:,1));
        ind = find(torque_vec(:,1) == t_max);
        phi_max = phase(ind);
        i_mag_max = torque_vec(ind,4);
        
        mag_log_vec(count) = mag_vec(j);
        torque_max_vec(count) = t_max;
        phi_max_vec(count) = phi_max;
        tdot_vec(count) = tdot(k);
        i_mag_vec(count) = i_mag_max;
        
        count = count+1;
        %figure; plot(phase, torque_vec(:,1));
    end
     k
end
%}

% figure; plot(tdot, phi_max_vec);
% xlabel('Theta dot');
% ylabel('Phase');



% figure;plot(phase, torque_vec);
% title(strcat('Torque Components, ', num2str(mag), ' Amps'));
% legend('Total', 'PM', 'Reluctance');
% xlabel('Current Angle (rad)');
% ylabel('Torque (N-m)');


% figure;plotyy(tdot, phi_max_vec, tdot, torque_max_vec);
% data = [tdot', phi_max_vec'];
% save('2d_lut.mat', 'data');

% figure;scatter3(tdot_vec, mag_log_vec, phi_max_vec, 20, phi_max_vec, 'filled'); 
% view(0, 90); colorbar();
% xlabel('Rad/s'); ylabel('Current Command'); zlabel('Phase');
% figure;scatter3(tdot_vec, mag_log_vec, torque_max_vec, 20, torque_max_vec, 'filled'); 
% view(0, 90); colorbar();
% xlabel('Rad/s'); ylabel('Current Command'); zlabel('Torque');
% figure;scatter3(tdot_vec, i_mag_vec, torque_max_vec, 20, torque_max_vec, 'filled'); 
% view(0, 90); colorbar();
% xlabel('Rad/s'); ylabel('Current'); zlabel('Torque');
% 
% data = [tdot_vec, mag_log_vec, i_mag_vec, phi_max_vec, torque_max_vec];
% save('2d_lut.mat', 'data');