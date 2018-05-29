function [tseg2,error3,t3] = adjacentdistancemerge(seg,arc,C,x,y,error,t)
% merge the adjacent segments which are too close to each other
psmlr=.2;
pmet=1.2;
% tseg2=seg;
% error3=
if max(size(seg)) < 3
    tseg2=seg;
    error3=error;
    t3=t;
    return
end
if max(size(seg))==3
    if min(arc(seg(3)-1)-arc(seg(2)+1),arc(seg(2)-1))/max(arc(seg(3)-1)-arc(seg(2)+1),arc(seg(2)-1))<psmlr
        tseg=[seg(1),seg(3)];
        [t,error2] = fitting(x,y,arc,tseg,C);
        if error2<sum(error)*pmet
            cla
            plot(x,y,'go');
            plot(x(tseg),y(tseg),'r*');
            drawing(tseg,arc,t,x,y);
        end
    end
end
tseg2=seg;
if max(size(seg))>3
    for i=1:max(size(seg))-2
        tseg=seg;
        arc1=arc(seg(i+1)-1)-arc(seg(i)+1);
        arc2=arc(seg(i+2)-1)-arc(seg(i+1)+1);
        if min(arc1,arc2)/max(arc1,arc2) < psmlr
            tseg(i+1)=[];
            [~,error2] = fitting(x,y,arc,tseg,C);
            if error2(i) < (error(i)+error(i+1))*pmet
                tseg2(i+1)=[];
            end
        end
    end
end
[t3,error3] = fitting(x,y,arc,tseg2,C);
cla
hold on
plot(x,y,'go');
xlim([0 1]); ylim([0 1]);
box on
plot(x(tseg2),y(tseg2),'r*');
drawing(tseg2,arc,t3,x,y);
end
                
            
            
            
% j=1;number=[];
% if max(size(seg))>3
%     tseg1=seg;tseg2=seg;j=1;
%     for i=2:max(size(seg))-2
%         if (arc(seg(i+1)-1)-arc(seg(i)+1))/(arc(seg(i)-1)-arc(seg(i-1)+1)) < psmlr
%             tseg1(i)=[];
%             [~,error2] = fitting(x,y,arc,tseg1,C);
%             if error2(i-1) < (error(i)+error(i-1))*pmet
%                 error2=error2;
%             else
%                 error2=[];
%             end
%         else
%             error2=[];
%         end      
%         if (arc(seg(i+1)-1)-arc(seg(i)+1))/(arc(seg(i+2)-1)-arc(seg(i+1)+1)) < psmlr
%             tseg2(i+1)=[];
%             [~,error3] = fitting(x,y,arc,tseg2,C);
%             if error3(i) < (error(i+1)+error(i+2))*pmet
%                 error3=error;
%             else
%                 error3=[];
%             end
%         else
%             error3=[];
%         end
%         if size(error2,1)>0 && size(error3,1)>0
%             if error2(i-1)<error3(i)
%                 number(j)=i;
%                 j=j+1;
%             else
%                 number(j)=i+1;
%                 j=j+1;
%             end
%         end
%     end
% end
% if size(number,1) ~= 0
%     number=sort(number);
%     seg(number)=[];
%     [t4,error4] = fitting(x,y,arc,seg,C);
%     cla
%     hold on
%     plot(x,y,'go');
%     xlim([0 1]); ylim([0 1]);
%     box on
%     plot(x(seg),y(seg),'r*');
%     drawing(seg,arc,t4,x,y);
% else
%     error4=error;
% end
% end

        
        
        
        
     
                
                


        
        

           


            




