function [ neighbor_ids ] = getTriangleNeighbors( triangle_id ,TRI )
%GETTRIANGLENEIGHBORS Summary of this function goes here
%   Detailed explanation goes here
    vertices = TRI(triangle_id,:);
    v1 = vertices(1);
    v2 = vertices(2);
    v3 = vertices(3);
    
    edge1 = [v1 v2];
    edge2 = [v2 v3];
    edge3 = [v3 v1];
    
    neighbor_ids = [];
    for i = 1:length(TRI)
        if i ~= triangle_id
%             if all(ismember(edge1,TRI(i,:))) || all(ismember(edge2,TRI(i,:))) || all(ismember(edge3,TRI(i,:)))
            if ismember(v1,TRI(i,:)) || ismember(v2,TRI(i,:)) || ismember(v3,TRI(i,:))
                neighbor_ids = [neighbor_ids;i];
            end
        end
    end
    
    neighbor_ids = [triangle_id; unique(neighbor_ids)];
end

