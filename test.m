[X, Y, TRI] = readOff('shape2.off')
TRI = TRI+1;
subplot(1,2,1)
hold on
triplot(TRI, X, Y);
axis image

[X_trans, Y_trans, ~] = readOff('shape2_omt.off')

subplot(1,2,2)
triplot(TRI, X_trans, Y_trans);
axis image

subplot(1,2,1)
inputs = ginput(2)
p1_input = inputs(1,:);
p2_input = inputs(2,:);
plot(p1_input(1),p1_input(2),'g*');
plot(p2_input(1),p2_input(2),'r*');

p1_tri_id = getTriangleIndex(p1_input,X,Y,TRI);
start = getPathAlongCentroids(p1_tri_id, X_trans,Y_trans,TRI);
p2_tri_id = getTriangleIndex(p2_input,X,Y,TRI);
goal = getPathAlongCentroids(p2_tri_id, X_trans,Y_trans,TRI);

subplot(1,2,2)
hold on
plot(start(1),start(2),'g*');
plot(goal(1),goal(2),'r*');
% 
indices = getPath(start, goal, X_trans, Y_trans,TRI, 0.01);
path = getPathAlongCentroids(indices, X,Y,TRI);

path = [p1_input; path; p2_input];

subplot(1,2,1)
plot(path(:,1),path(:,2), 'r', 'linewidth', 2)