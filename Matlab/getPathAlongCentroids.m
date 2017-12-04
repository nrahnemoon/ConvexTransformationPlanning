function [ path ] = getPathAlongCentroids( triangle_ids, P, TRI )
%GETPATHALONGCENTROIDS Summary of this function goes here
%   Detailed explanation goes here
triangles_vertices = TRI(triangle_ids,:);

path = [];

for i = 1:length(triangle_ids)
    x = P(triangles_vertices(i,:), 1);
    y = P(triangles_vertices(i,:), 2);
    [ geom, iner, cpmo ] = polygeom( x, y ) 
    path = [path; geom(2), geom(3)];
end

