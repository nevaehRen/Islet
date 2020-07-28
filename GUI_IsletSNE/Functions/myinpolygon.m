function flag = myinpolygon(X,Y,xv,yv)
% decide if the points are inside or outside the polygon
% Input:
% 	X: x-coordinations of the points to be detected
% 	Y: y-coordinations of the points to be detected
%	xv: x-coordinations of the vertex define the polygon
%	yv: y-coordinations of the vertex define the polygon
% Output:
%	flag=1: inside the polygon
%	flag=0: outside the polygon

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2012-05-07: Complete
% 2012-05-18: Modify the comments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vertex(:,1) = xv;
vertex(:,2) = yv;
% generate the Delaunay Triangle
dt = DelaunayTri(vertex);
% calculate the volumn of the body
k = convexHull(dt);

xv2 = dt.X(k(1:(end-1)),1);
yv2 = dt.X(k(1:(end-1)),2);

flag = inpolygon(X,Y,xv2,yv2);