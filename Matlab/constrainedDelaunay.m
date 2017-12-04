%% process input image
% get pixel coordinate of free space
shape = im2bw(imread('img.png'));
%shape = imread('img.png');
free_ind = find(shape);
[X, Y] = ind2sub(size(shape), free_ind);

% a starting point for tracing boundary
[start_x, start_y] = ind2sub(size(shape),free_ind(1));
start_p = [start_x, start_y];
contour = bwtraceboundary(shape, start_p, 'W');

% get boundary indices
[~,contour_ind]=ismember(contour,[X,Y],'rows');
contour_next = circshift(contour_ind,-1);
C = [contour_ind, contour_next];


%% try delaunay with constraint
% do dealunay
len = size(C, 1);
skipEvery = 5;
cPts = floor(linspace(1, (len - mod(len, skipEvery)), floor(len/skipEvery)))';
xNew = X(C(cPts, 1), :);
yNew = Y(C(cPts, 1), :);
cNew = [linspace(1, size(cPts, 1), size(cPts, 1))', circshift(linspace(1, size(cPts, 1), size(cPts, 1)), -1)'];

for i = 1:20
    xCoor = floor(rand() * (max(xNew)-min(xNew))) + min(xNew);
    yCoor = floor(rand() * (max(yNew)-min(yNew))) + min(yNew);
    if inpolygon(xCoor, yCoor, X, Y)
        xNew = [ xNew; xCoor ];
        yNew = [ yNew; yCoor ];
    end
end

DT = delaunayTriangulation(xNew, yNew, cNew);

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

xPos = DT.Points(:,2);
yPos = DT.Points(:,1);
yMax = size(shape, 1);
xMax = size(shape, 2);
triangles = TRI;

writeToOff('test.off', xPos, yPos, triangles, xMax, yMax)
