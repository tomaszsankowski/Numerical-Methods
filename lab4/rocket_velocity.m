function velocity_delta = rocket_velocity(t)

% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety

if t <= 0
        error("Time must be greater than zero!")
else
    M = 750; % [m/s]
    m0 = 150000; % [kg]
    u = 2000; % [m/s]
    q = 2700; % [kg/s]
    g = 1.622; % [m/s^2]
    
    Z = u * log(m0/(m0-q*t))-g*t;
    
    velocity_delta = Z - M;
end

end
