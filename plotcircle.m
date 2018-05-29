function [] = plotcircle(x,y,a,b,r,arc)
% use this function to plot a part or a whole circle
dx=[1;0];n=max(size(x));
d1=[x(1);y(1)]-[a;b];
arc2=abs(arc-(arc(1)+arc(end))/2);
m=find(arc2==min(arc2));
m=max(m);
x2=x(m);y2=y(m);
d2=[x2;y2]-[a;b];
d3=[x(end);y(end)]-[a;b];
angle(1)=acosd(dot(d1,dx)/(norm(d1)*norm(dx)));
angle(2)=acosd(dot(d2,dx)/(norm(d2)*norm(dx)));
angle(3)=acosd(dot(d3,dx)/(norm(d3)*norm(dx)));
if y(1)<b
    angle(1)=360-angle(1);
end
if y2<b
    angle(2)=360-angle(2);
end
if y(end)<b
    angle(3)=360-angle(3);
end
if abs(angle(2)-angle(1)) < 180;
    total_angle1=max(angle(1),angle(2))-min(angle(1),angle(2));
else
    total_angle1=min(angle(1),angle(2))+360-max(angle(1),angle(2));
end
if abs(angle(2)-angle(3)) < 180;
    total_angle2=max(angle(3),angle(2))-min(angle(3),angle(2));
else
    total_angle2=min(angle(3),angle(2))+360-max(angle(3),angle(2));
end
total_angle=total_angle1+total_angle2;

if total_angle > 340
    alpha=0:360;   
    c1=r*cosd(alpha)+a; 
    c2=r*sind(alpha)+b; 
    plot(c1,c2,'r');
end
if  abs(angle(2)-angle(1)) < 180;
    alpha=min(angle(1),angle(2)):.1:max(angle(1),angle(2))+1;   
    c1=r*cosd(alpha)+a; 
    c2=r*sind(alpha)+b; 
    plot(c1,c2,'r');
else
    alpha=max(angle(1),angle(2))-1:.1:min(angle(1),angle(2))+360;  
    c1=r*cosd(alpha)+a; 
    c2=r*sind(alpha)+b; 
    plot(c1,c2,'r');
end
if abs(angle(2)-angle(3)) < 180
    alpha=min(angle(3),angle(2)):.1:max(angle(3),angle(2));  
    c1=r*cosd(alpha)+a; 
    c2=r*sind(alpha)+b; 
    plot(c1,c2,'r');
else
    alpha=max(angle(3),angle(2)):.1:min(angle(3),angle(2))+360;  
    c1=r*cosd(alpha)+a; 
    c2=r*sind(alpha)+b; 
    plot(c1,c2,'r');
end




end

