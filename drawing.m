function [] = drawing(seg,arc,t,x,y)
% do the plot
for i=1:max(size(seg))-1     
    if t(i,4)==1
        plot(x(seg(i)+1:seg(i+1)-1),t(i,1).*x(seg(i)+1:seg(i+1)-1)+t(i,2),'r');
    else if t(i,4)==2
            plot(t(i,1).*y(seg(i)+1:seg(i+1)-1)+t(i,2),y(seg(i)+1:seg(i+1)-1),'r');
         else
            plotcircle(x(seg(i)+1:seg(i+1)-1),y(seg(i)+1:seg(i+1)-1),-t(i,1),-t(i,2),t(i,3),...
                arc(seg(i)+1:seg(i+1)-2));
         end
    end
end  

end

