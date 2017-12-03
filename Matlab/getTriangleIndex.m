function [ output_args ] = getTriangleIndex(p, P, TRI)
%GETTRIANGLEINDEX Given a point and a triangulated map, find its triangle
%index
%   Detailed explanation goes here
    X = P(:,1);
    Y = P(:,2);
    triplot(TRI,X,Y);
    hold on
    plot(p(1),p(2),'r','.')
end

