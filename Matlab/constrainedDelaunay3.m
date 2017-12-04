h = impoly
pos = h.getPosition();

xBoundary = pos(:,1);
yBoundary = pos(:,2);
cBoundary = [linspace(1, size(X, 1), size(X, 1))', circshift(linspace(1, size(X, 1), size(X, 1))', -1)];

numSteps = 30;
xStep = (max(xBoundary) - min(xBoundary))/numSteps;
yStep = (max(yBoundary) - min(yBoundary))/numSteps;

xPos = [];
yPos = [];
for i = min(xBoundary):xStep:max(xBoundary)
    for j = min(yBoundary):yStep:max(yBoundary)
        if inpolygon(i, j, xBoundary, yBoundary)
            xPos = [xPos; i];
            yPos = [yPos; j];
        end
    end
end

pos = [xPos, yPos];
triangles = [];
for i = 1:size(xPos, 1)
    [hasTopLeft, topLeftIndex] = ismembertol([xPos(i)-xStep, yPos(i)+yStep], pos, (xStep/10), 'ByRows', true);
    [hasTopRight, topRightIndex] = ismembertol([xPos(i), yPos(i)+yStep], pos, (xStep/10), 'ByRows', true);
    [hasBottomLeft, bottomLeftIndex] = ismembertol([xPos(i)-xStep, yPos(i)], pos, (xStep/10), 'ByRows', true);
    bottomRightIndex = i;
    if hasTopLeft && hasTopRight && hasBottomLeft
        triangles = [triangles ; topLeftIndex, topRightIndex, bottomLeftIndex];
    end
    if hasTopRight && hasBottomLeft
        triangles = [triangles ; topRightIndex, bottomRightIndex, bottomLeftIndex];
    end
end

hold on
triplot(triangles, xPos, yPos);
axis image
set(gca,'Ydir','reverse')

writeToOff('shape2.off', xPos, yPos, triangles, 1, 1)