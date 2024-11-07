% 1 Naloga

data = importdata("naloga1_1.txt","",2);
t= data.data(:,1);

% 2 Naloga

fid = fopen("naloga1_2.txt");
line = fgetl(fid);
count = 1;
while ~feof(fid)
    line = fgetl(fid);
    P(count) = str2double(line);

    count = count+1;
end
P = P.';

% 3 Naloga

function I = trapezna_metoda(x, y)

    n = length(x);
    
    I=0;

    for i = 1:n-1
        h = x(i+1) - x(i);
        I = I + (h / 2) * (y(i) + y(i+1)); 
    end
end
i_func =trapezna_metoda(t,P);

i_trapz = trapz(t, P);

plot(t,P)