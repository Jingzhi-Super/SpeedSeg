function [seg,k] = segment(s,C,d)
%find all the # of segment points
pst=.25;
pct=10000;
pcst=.9;
s_ave=mean(s);
% the first point is a segment point
seg(1)=1;seg(2)=size(s,1); 
% using the speed minima rule
j=3;k=0;
for i=2:size(s,1)-1
    if (s(i)<s(i-1)) && (s(i)<s(i+1)) && (s(i)<(pst*s_ave)) 
        seg(j)=i;
        j=j+1;
    end
end
% using the curvatue and speed rule
for i=2:size(C,1)-1
    if (abs(C(i))>abs(C(i-1))) && (abs(C(i))>abs(C(i+1))) && (abs(C(i))>pct) && (s(i+5)<pcst*s_ave)
        seg(j)=i+5;
        j=j+1;
    end
end
seg=sort(seg);temp=[];
temp(1)=seg(1);temp(2)=seg(end);
j=3;
for i=2:max(size(seg))-1
    if seg(i+1)-seg(i) > 7
        temp(j)=seg(i);
        j=j+1;
    end
end
seg=temp;seg=sort(seg);
j=max(size(seg))+1;
for i=2:size(d,1)
    if d(i) > 5*mean(d)
        seg(j)=i;
        j=j+1;
        k=k+1;
    end
end
seg=sort(seg);temp=[];j=1;
for i=1:max(size(seg))-1
    if seg(i) ~= seg(i+1)
        temp(j)=seg(i);
        j=j+1;
    end
end
temp(j)=seg(end);
seg=temp;temp=[];
% temp(1)=seg(1);temp(2)=seg(end);j=3;
% for i=2:max(size(seg))-1
%     if seg(i+1)-seg(i) > 3
%         temp(j)=seg(i);
%         j=j+1;
%     end
% end
% % temp(j)=seg(end-1);
% seg=temp;
% seg=sort(seg);
    
end

