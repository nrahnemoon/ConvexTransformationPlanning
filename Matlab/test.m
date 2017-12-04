[P,TRI] = constrainedDelaunay('img.png');
p1 = [60.2, 43.3]
p2 = [79.5, 51.1]

tri_ids = getPath(p1, p2, P, TRI, 0.1);
path = getPathAlongCentroids( tri_ids, P, TRI )

plot(path(:,1),path(:,2), 'r', 'linewidth', 2)
axis image
set(gca,'Ydir','reverse')