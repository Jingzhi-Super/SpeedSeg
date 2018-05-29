function [] = split(error,C,seg,x,y,arc)
% split a questionable segment
psset=.65;
c=zeros(max(size(C))+10,1);
c(6:end-5)=C;tseg=[];
c2=abs(c);
for i=1:max(size(error))
    if error(i) > 0.015
        j=find(c2==(max(c2(seg(i)+1:seg(i+1)-1))));
        if (c(j)>1000 && min(c(j-1),c(j-2))<-1000) || (c(j)<-1000 && max(c(j-1),c(j-2))>1000)
%         for j=seg(i)+3:seg(i+1)-3
%             if min(c(j),c(j+1))<-1000 && max(c(j),c(j+1))>1000
%                 break
%             end
            tseg=[seg,j];
            tseg=sort(tseg);
            [t,error2] = fitting(x,y,arc,tseg,C);
            if error2(i)+error2(i+1) < error(i)*psset
                cla
                hold on
                plot(x,y,'go');
                plot(x(tseg),y(tseg),'r*');
                drawing(tseg,arc,t,x,y);
            end
        end
    end 
end

end

