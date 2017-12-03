function [P,TRI] = constrainedDelaunay(filename)
%CONSTRIANEDDELAUNAY Given input map image, output Points and Triangluation
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
end