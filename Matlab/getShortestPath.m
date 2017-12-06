function [dist, path, pred, G] = getShortestPath(start, goal, X, Y, TRI)

    numNodes = size(TRI,1);
    G = zeros(numNodes, numNodes);

    for i = 1:numNodes
        currTrianglePos = getPathAlongCentroids(i, X, Y, TRI);
        neighbors = getTriangleNeighbors(i, TRI);
        for j = 1:size(neighbors, 1)
            neighborPos = getPathAlongCentroids(neighbors(j), X, Y, TRI);
            G(i, neighbors(j)) = sqrt((currTrianglePos(1) - neighborPos(1)).^2 + (currTrianglePos(2) - neighborPos(2)).^2);
        end
    end
    
    G = sparse(G);
    [dist, path, pred] = graphshortestpath(G, start, goal);
end
