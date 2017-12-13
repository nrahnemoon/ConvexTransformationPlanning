function [xPos, yPos, triangles] = readOff(fileName)

    text = fileread(fileName);
    lines = splitlines(text);
    vf = strsplit(lines{2,1}, ' ');
    numVertices = str2num(vf{1,1});
    numFaces = str2num(vf{1,2});
    
    xPos = zeros(numVertices, 1);
    yPos = zeros(numVertices, 1);
    triangles = zeros(numFaces, 3);
    
    i = 3;
    pos = 1;
    while 1
        data = strsplit(lines{i,1});
        if size(data, 2) ~= 8
            break;
        end
        xPos(pos,1) = str2num(data{7});
        yPos(pos,1) = str2num(data{8});
        pos = pos + 1;
        i = i + 1;
    end
    
    pos = 1;
    while 1
        data = strsplit(lines{i,1});
        if size(data, 2) ~= 4
            break;
        end
        for j = 1:3
            triangles(pos,j) = str2num(data{j+1});
        end
        pos = pos + 1;
        i = i + 1;
    end
end
