%% process input image
% get pixel coordinate of free space
shape = im2bw(imread('img.png'));
free_ind = find(shape);
[X, Y] = ind2sub(size(shape), free_ind);

% a starting point for tracing boundary
[start_x, start_y] = ind2sub(size(shape),free_ind(1));
start_p = [start_x, start_y];
contour = bwtraceboundary(shape, start_p, 'W');

% get boundary indices
[~,contour_ind]=ismember(contour,[X,Y],'rows');
contour_next = circshift(contour_ind,-1)
C = [contour_ind, contour_next];
%% try delaunay with constraint
% do dealunay
DT = delaunayTriangulation(X,Y,C)


subplot(1,2,1)
hold on
plot(contour(:,1),contour(:,2),'r','LineWidth',2);
triplot(DT)
axis equal

subplot(1,2,2)
hold on
plot(contour(:,1),contour(:,2),'r','LineWidth',2);
% trim the delaunay
inside = isInterior(DT);
triplot(DT.ConnectivityList(inside, :),DT.Points(:,1),DT.Points(:,2))
axis equal

% this is what we need
TRI = DT.ConnectivityList(inside, :);

