% Manually made for star trek shape

X = [0.5; 0.5; 1; 1.5; 1.5; 1];
Y = [0.5; 1; 2; 1; 0.5; 1];
C = [linspace(1, size(X, 1), size(X, 1))', circshift(linspace(1, size(X, 1), size(X, 1))', -1)];

xPos = X;
yPos = Y;
yMax = 2;
xMax = 2;
for i = 1:200
    xCoor = rand() * (max(xPos)-min(xPos)) + min(xPos);
    yCoor = rand() * (max(yPos)-min(yPos)) + min(yPos);
    if inpolygon(xCoor, yCoor, X, Y)
        xPos = [ xPos; xCoor ];
        yPos = [ yPos; yCoor ];
    end
end

DT = delaunayTriangulation(xPos, yPos, C);
inside = isInterior(DT);
TRI = DT.ConnectivityList(inside, :);
triangles = TRI;

writeToOff('starTrek.off', xPos, yPos, triangles, xMax, yMax)
