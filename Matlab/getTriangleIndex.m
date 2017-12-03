function [triangle_ind] = getTriangleIndex(p, P, TRI)
%GETTRIANGLEINDEX Given a point and a triangulated map, find its triangle
%index
%   Detailed explanation goes here
    xq = p(1);
    yq = p(2);
    
    vertex_of_interest = round(p);
    [~,voi_id]=ismember(vertex_of_interest, P, 'rows');
    
    [tri_ids, ~] = find(TRI==voi_id);
    
    tri_v_ids = TRI(tri_ids,:);
    for i = 1:length(tri_v_ids)
        tri_v = tri_v_ids(i,:);
        xv = P(tri_v, 1);
        yv = P(tri_v, 2);
        in = inpolygon(xq,yq,xv,yv);
        if in
            break
        end
    end
    
    
    triangle_ind = tri_ids(i);
end

