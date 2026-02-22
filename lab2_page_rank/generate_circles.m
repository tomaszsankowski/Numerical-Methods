function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
index_number = 193363; % numer Twojego indeksu
L1 = mod(index_number,10);
ctr = 1;
rand_counts = zeros(n_max,1);
counts_mean = zeros(n_max,1);
if(mod(L1,2)==0)
    circles = zeros(n_max,3);
    while(ctr<(n_max+1))
    rand_counts(ctr,1) = rand_counts(ctr,1)+1;
    r = rand*r_max;
    x = rand*a;
    y = rand*a;
    if(x-r>=0 && x+r<=a && y+r<=a && y-r>=0)
        flag = true;
        for j=1:ctr
            r2 = circles(j,1);
            x2 = circles(j,2);
            y2 = circles(j,3);
            d = sqrt((x-x2)^2 + (y-y2)^2);
            if( (d<=r2-r) || (d<=r-r2) || (d<=r+r2) )
                flag = false;
            end
        end
        if(flag)
            circles(ctr,:) = [r x y];
            ctr = ctr + 1;
        end
    end
    end
else
    circles = zeros(3,n_max);
    while(ctr<(n_max+1))
    rand_counts(ctr,1) = rand_counts(ctr,1)+1;
    r = rand*r_max;
    x = rand*a;
    y = rand*a;
    if(x-r>=0 && x+r<=a && y+r<=a && y-r>=0)
        flag = true;
        for j=1:ctr
            r2 = circles(1,j);
            x2 = circles(2,j);
            y2 = circles(3,j);
            d = sqrt((x-x2)^2 + (y-y2)^2);
            if( (d<=r2-r) || (d<=r-r2) || (d<=r+r2) )
                flag = false;
            end
        end
        if(flag)
            circles(:,ctr) = [r ; x ; y];
            ctr = ctr + 1;
        end
    end
    end
end
counts_mean = cumsum(rand_counts);
for i=1:200
    counts_mean(i,1) = counts_mean(i,1)/i;
end
if(mod(L1,2)==1)
    circle_tmp(1,:) = circles(1,:).^2*pi;
    circle_areas = cumsum(circle_tmp);
else
    circle_tmp(:,1) = circles(:,1).^2*pi;
    circle_areas = cumsum(circle_tmp);
end
end
