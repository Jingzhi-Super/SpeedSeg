function [seg,error3,t3] = adjacenttypemerge(seg,t,error,x,y,arc,C)
% merge two adjacent segments which are the same type and has little error
pmet=1;
if size(t,1)<2
    error3=error;
    t3=t;
    return
end
for i=1:size(t,1)
    if t(i,4)==2;
        t(i,4)=1;
    end
end
number=[];
j=1;
for i=1:size(t,1)-1
    tseg=seg;
    if t(i,4)==t(i+1,4)
        if t(i,4)==1
            if dot([1;t(i,1)+t(i,2)],[1;t(i+1,1)+t(i+1,2)])>0.75
                tseg(i+1)=[];
                [~,error2] = fitting(x,y,arc,tseg,C);
                if error2(i) < (error(i)+error(i+1))*pmet
                    number(j)=i+1;
                    j=j+1;
                end
            end
        else
            tseg(i+1)=[];
            [~,error2] = fitting(x,y,arc,tseg,C);
            if error2(i) < (error(i)+error(i+1))*pmet
                number(j)=i+1;
                j=j+1;
            end
        end
    end
end


if size(number,1) ~= 0
    number=sort(number);
    seg(number)=[];
    [t3,error3] = fitting(x,y,arc,seg,C);
    cla
    hold on
    plot(x,y,'go');
    xlim([0 1]); ylim([0 1]);
    box on
    plot(x(seg),y(seg),'r*');
    drawing(seg,arc,t3,x,y);
else
    error3=error;
    t3=t;
end

end

    
    

        
        




