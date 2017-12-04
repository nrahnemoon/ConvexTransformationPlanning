function [P,TRI] = constrainedDelaunay(X, Y, contour, outputFile)
%CONSTRAINEDDELAUNAY Given a shape defined by set of X,Y points and its
%contour coordinate, get delaunay
%   X: x coordinates of points in shape
%   Y: y coordinates of points in shape
%   contour: the coordinates of points on the contour of the shape

%   P: set of delaunay points (should be the same as [X Y])
%   TRI: set of delaunay triangle indices
    [~,contour_ind]=ismember(contour,[X, Y],'rows');
    contour_next = circshift(contour_ind,-1);
    C = [contour_ind, contour_next];
    
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
    
    xPos = DT.Points(:,2);
    yPos = DT.Points(:,1);
    yMax = size(shape, 1);
    xMax = size(shape, 2);
    triangles = TRI;

    writeToOff(outputFile, xPos, yPos, triangles, xMax, yMax)
end
