clear
clc
load ('InkData.txt');
x=InkData(:,1);
y=InkData(:,2);
time=InkData(:,3);
plot(x,y,'go');
hold on
xlim([0 1]); ylim([0 1]);
box on
if size(x,1)<12
    disp('draw more points please');
    error;
end
[arc,s,d] = speed(x,y,time);
[theta] = tangent(x,y,arc,11);
[C]=curvature(theta,arc);
[seg,k] = segment(s,C,d);
plot(x(seg),y(seg),'r*');
[t,error] = fitting(x,y,arc,seg,C);
drawing(seg,arc,t,x,y);
if k==0
    [seg,error,t] = adjacentdistancemerge(seg,arc,C,x,y,error,t);
    [seg,error,t] = adjacenttypemerge(seg,t,error,x,y,arc,C);
    split(error,C,seg,x,y,arc);
else
    return
end



    










