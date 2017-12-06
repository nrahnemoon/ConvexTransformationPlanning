function [distance] = getPathDistance(path)

    distance = 0;
    for i = 1:(size(path, 1) - 1)
        distance = distance + sqrt( ( path(i,1)- path(i+1,1) ).^2 + ( path(i,2) - path(i+1,2) ).^2 );
    end

end

