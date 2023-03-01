function [result] = RatioCompute(grid_x,grid_y)
%% ------------------ Initialise the parameters -----------------
radius = 0;
ratio = 0;
Xi = 0;
Yi = 0;
Xs = 0;
Ys = 0;
%% ------------------ Compute the center -----------------
Xc = floor(grid_x/2);
Yc = floor(grid_y/2);
% ------------ Compute the coordinate of each cell -------
for row=1:grid_y
    for column=1:grid_x
         if (row ~= Yc) && (column ~= Xc) % --- to avoid picking up the center ---- %
            Xi = abs(Xc - column) + 1;
            Yi = abs(Yc - row) + 1;
            Xs = Xs + (Xi - Xc)^2;
            Ys = Ys + (Yi - Yc)^2;
         end
    end
end
% ----------- Compute the radius -------------------
radius = sqrt((Xs + Ys)/(grid_x * grid_y)) ;
% ----------- Compute the ratio --------------------
ratio = 0.8944/radius;
% ---------- concatenate the result ----------------
result = [radius,ratio];
end