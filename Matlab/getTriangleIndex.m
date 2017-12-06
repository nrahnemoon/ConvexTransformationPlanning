function [triangle_ind] = getTriangleIndex(p, X, Y, TRI)
%GETTRIANGLEINDEX Given a point and a triangulated map, find its triangle
%index
%   Detailed explanation goes here
    xq = p(1);
    yq = p(2);
    
    min_dist = inf;
    
    triangle_ind = 0;
    for i = 1:length(TRI)
        tri_v = TRI(i,:);
        xv = X(tri_v);
        yv = Y(tri_v);
        in = inpolygon(xq,yq,xv,yv);
        if in
            [ geom, iner, cpmo ] = polygeom(xv, yv);
            if (geom(2)-p(1))^2+(geom(3)-p(2))^2 < min_dist
                triangle_ind = i;
            end
        end
    end
    
    
end

