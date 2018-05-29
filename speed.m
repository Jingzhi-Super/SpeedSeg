function [arc,S,d] = speed(x,y,t)
% calculate the arc length and the speed. Then smooth the speed.
d=sqrt((x(2:end)-x(1:end-1)).^2+(y(2:end)-y(1:end-1)).^2);
arc=zeros(size(d,1),1);
s=zeros(size(x));
for i=1:size(d,1)
    arc(i)=sum(d(1:i));% arc length
end
s(2:end-1)=abs(diff(arc)./diff(t(1:end-1)));
% smoothing filter
s(1)=s(2);s(end)=s(end-1);
S=zeros(size(s));
for i=3:size(s,1)-2
   S(i)=sum(s(i-1:i+1))/3;
end
S(1)=S(3);S(2)=S(3);S(end)=S(end-2);S(end-1)=S(end-2);
% deal with the potential infinite speed
for i=1:max(size(S))
    if S(i)==Inf
        S(i)=0;
    end
end
s_ave=mean(S);
for i=1:max(size(S))
    if S(i)==0
        S(i)=s_ave*3;
    end
end
end

