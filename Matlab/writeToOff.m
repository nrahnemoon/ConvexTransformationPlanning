function writeToOff(fileName, xPos, yPos, triangles, xMax, yMax)

    fileID = fopen(fileName, 'w');

    % STCOFF define file format for the OFF File
    fprintf(fileID, 'STCOFF\r\n');
    
    % {numVertices} {numFaces} 0
    % E.g.,: 6 4 0
    fprintf(fileID, '%d %d 0\r\n', size(xPos, 1), size(triangles, 1));
    
    % Output vertices
    for i = 1:size(xPos, 1)
        % {xPos} {yPos} 0 {R} {G} {B} {xPos/xMax} {yPos/yMax}
        % E.g.,: 0.5 0.5 0 32 32 32 0.25 0.25
        fprintf(fileID, '%f %f 0 32 32 32 %f %f\r\n', xPos(i, 1), yPos(i, 1), (xPos(i,1)/xMax), (yPos(i,1)/yMax));
    end
    
    % Output faces
    for i = 1:size(triangles, 1)
        % {numVertices} {vertex1} {vertex2} {vertex3}
        % E.g.,: 3 0 1 5
        v1 = (triangles(i, 1) - 1);
        v2 = (triangles(i, 2) - 1);
        v3 = (triangles(i, 3) - 1);
        fprintf(fileID, '%d %d %d %d\r\n', size(triangles, 2), v1, v2, v3);
    end
    
    fprintf('\r\n');
    fclose(fileID);
end

