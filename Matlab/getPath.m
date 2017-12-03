function [indices] = getPath(p1, p2, P, TRI, step_size)
  %GETPATH Given p1, p2 return the triangle indices on the straightline
  %   p1: start point [x,y]
  %   p2: end point [x,y]
  %   P: set of points in the map, m x 2 matrix in [x, y] format
  %   TRI: set of delaunay, k x 3 matrix in [ind1, ind2, ind3] format
  
  %   indices: indices within TRI that are on path of p1 to p2
   dir=atan2(p2(2)-p1(2),p2(1)-p1(1));
   step_size_x=step_size*cos(dir);
   step_size_y=step_size*sin(dir);
   indices=getTriangleIndex(p1, P, TRI);
   go=true;
   while go
       p1(1)=p1(1)+step_size_x;
       p1(2)=p1(2)+step_size_y;
       k=getTriangleIndex(p1, P, TRI);
       if k~=indices(end)
           indices=[indices k];
       end
       if sqrt(((p2(1)-p1(1))^2)+ ((p2(2)-p1(2))^2))<step_size
          p1(1)=p2(1); 
          p1(2)=p2(2);
          indices=[indices getTriangleIndex(p1, P, TRI)];
       end
       if p1(1)==p2(1) && p1(2)==p2(2)
           go=false;
       end
   end
end