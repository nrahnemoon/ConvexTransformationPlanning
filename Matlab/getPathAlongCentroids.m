function [ path ] = getPathAlongCentroids( triangle_ids, X, Y, TRI )
%GETPATHALONGCENTROIDS Summary of this function goes here
%   Detailed explanation goes here
triangles_vertices = TRI(triangle_ids,:);

path = [];

for i = 1:length(triangle_ids)
    x = X(triangles_vertices(i,:));
    y = Y(triangles_vertices(i,:));
    [ geom, iner, cpmo ] = polygeom( x, y );
    path = [path; geom(2), geom(3)];
end

