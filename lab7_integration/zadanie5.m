function [lake_volume, x, y, z, zmin] = zadanie5()

    N = 1e6;
    zmin = -50;

    x = 100*rand(1,N); % [m]
    y = 100*rand(1,N); % [m]
    z = zmin*rand(1,N); % [m]
    h = get_lake_depth(x,y);

    N1 = sum(z >= h);

    V = 100*100*50;

    lake_volume = N1 * V / N;
end