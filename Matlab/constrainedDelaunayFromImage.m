function [P,TRI] = constrainedDelaunayFromImage(filename)
%CONSTRIANEDDELAUNAYFROMIMAGE Given input map image, output Points and Triangluation
%   filename: input image filename
%   P: set of points coordinate
%   TRI: set of triangluation, from indices of P

    %% process input image
    % get pixel coordinate of free space
    shape = im2bw(imread(filename));

    free_ind = find(shape);
    [Y, X] = ind2sub(size(shape), free_ind);

    % a starting point for tracing boundary
    [start_y, start_x] = ind2sub(size(shape),free_ind(1));
    start_p = [start_y, start_x];
    contour = bwtraceboundary(shape, start_p, 'W');

    % get boundary indices
    [~,contour_ind]=ismember(contour,[Y, X],'rows');
    contour_next = circshift(contour_ind,-1);
    C = [contour_ind, contour_next];
    %% try delaunay with constraint
    % do dealunay
    DT = delaunayTriangulation(X,Y,C);


    subplot(1,2,1)
    hold on
    plot(contour(:,2),contour(:,1),'r','LineWidth',2);
    triplot(DT)
    axis image
    set(gca,'Ydir','reverse')


    subplot(1,2,2)
    hold on
    plot(contour(:,2),contour(:,1),'r','LineWidth',2);
    % trim the delaunay
    inside = isInterior(DT);
    triplot(DT.ConnectivityList(inside, :),DT.Points(:,1),DT.Points(:,2))
    axis image
    set(gca,'Ydir','reverse')


    % this is what we need
    TRI = DT.ConnectivityList(inside, :);
    P = DT.Points;
    
    nContour = size(C, 1);
    xPos = X(C(:, 1), 1);
    yPos = Y(C(:, 1), 1);
    yMax = size(shape, 1);
    xMax = size(shape, 2);
    cPos = [linspace(1, nContour, nContour)', circshift(linspace(1, nContour, nContour), -1)'];
    for i = 1:200
        xCoor = rand() * (max(xPos)-min(xPos)) + min(xPos);
        yCoor = rand() * (max(yPos)-min(yPos)) + min(yPos);
        if inpolygon(xCoor, yCoor, X, Y)
            xPos = [ xPos; xCoor ];
            yPos = [ yPos; yCoor ];
        end
    end
    
    DT = delaunayTriangulation(xPos, yPos, cPos);
    inside = isInterior(DT);
    TRI = DT.ConnectivityList(inside, :);
    triangles = TRI;


    writeToOff('img.off', xPos, yPos, triangles, xMax, yMax)
end