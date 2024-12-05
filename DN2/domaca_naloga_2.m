clc;
clear all;

temperature = readmatrix('vozlisca_temperature_dn2.txt', 'NumHeaderLines', 4);
x = temperature(:,1);
y = temperature(:,2);
T = temperature(:,3);
celice = readmatrix('celice_dn2.txt', 'NumHeaderLines', 2);
xT = 0.403;
yT = 0.503;
t = ones(1, 3);

tic;
T1_interpolacija = scatteredInterpolant(x, y, T);
T1 = T1_interpolacija(xT, yT);
t(1) = toc;

tic;
xq = linspace(0, 370*0.01, 371);
yq = linspace(0, 240*0.01, 241);

[X, Y] = meshgrid(xq, yq);
T_grid = T1_interpolacija(X, Y);
T2_interpolacija = griddedInterpolant({xq, yq}, T_grid');
T2 = T2_interpolacija(xT, yT);
t(2) = toc;

tic;
T3 = T_interpolacija(celice,x,y,T,xT,yT);
t(3) = toc;

tmin = find(t == min(t));
display(t)
display("Najhitrejša metoda je: " + tmin)

[xymin,fval] = fminsearch(@(xy) -T2_interpolacija(xy(1),xy(2)),[1,1]);
display("Maksimalna temperatura: " + -fval + char(10) + "[x, y] = [" + xymin(1) + ", " + xymin(2) + "]")

function Tint = T_interpolacija(celice, x, y, T, xT, yT) 
    for i = 1:size(celice, 1)
        cell_points = celice(i,:); 
        cell_point1 = cell_points(1);
        cell_point2 = cell_points(2);
        cell_point3 = cell_points(3);
        cell_point4 = cell_points(4);
    
        x1 = x(cell_point1);
        x2 = x(cell_point2);
        x3 = x(cell_point3);
        x4 = x(cell_point4);
    
        y1 = y(cell_point1);
        y2 = y(cell_point2);
        y3 = y(cell_point3);
        y4 = y(cell_point4);
    
        if x1<xT && x2>xT
            if y1<yT && y3>yT
                xmax = x2;
                xmin = x1;
                ymax = y3;
                ymin = y1;
             
                T11 = T(cell_point1);
                T21 = T(cell_point2);
                T22 = T(cell_point3);
                T12 = T(cell_point4);
    
                A1 = (xmax-xT)/(xmax-xmin);
                A2 = (xT-xmin)/(xmax-xmin);
                B1 = (ymax-yT)/(ymax-ymin);
                B2 = (yT-ymin)/(ymax-ymin);
    
                K1 = A1*T11+A2*T21;
                K2 = A1*T12+A2*T22;
    
                Tint = B1*K1+B2*K2;
            end
        end
    
    end
end