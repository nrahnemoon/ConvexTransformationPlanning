function [triangle_ind] = getTriangleIndex(p, X, Y, TRI)
%GETTRIANGLEINDEX Given a point and a triangulated map, find its triangle
%index
%   Detailed explanation goes here
    xq = p(1);
    yq = p(2);
    
    dist=bsxfun(@hypot,X-xq,Y-yq);
    voi_id = find(dist==min(dist));
    
%     [tri_ids, ~] = find(TRI==voi_id(1));
%     
%     tri_v_ids = TRI(tri_ids,:);
    for i = 1:length(TRI)
        tri_v = TRI(i,:);
        xv = X(tri_v);
        yv = Y(tri_v);
        in = inpolygon(xq,yq,xv,yv);
        if in
            break
        end
    end
    
    if in == 0
        disp('cant find triangle')
    end
    
    triangle_ind = i;
end

