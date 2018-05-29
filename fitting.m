function [t,error] = fitting(x,y,arc,seg,C)
% fit the data points to lines and circles
t=zeros(max(size(seg))-1,4);
c=zeros(max(size(C))+10,1);
c(6:end-5)=abs(C);
for i=1:max(size(seg))-1
    n=seg(i+1)-seg(i)-1;t1=seg(i)+1;t2=seg(i+1)-1;
    laterpart1=0;laterpart2=0;laterpart3=0;laterpart4=0;
    error_line=0;error_circle=0;
    for j=t1:t2
        laterpart1=x(j)*y(j)+laterpart1;
        laterpart2=-(x(j)^2+y(j)^2)*x(j)+laterpart2;
        laterpart3=-(x(j)^2+y(j)^2)*y(j)+laterpart3;
        laterpart4=-(x(j)^2+y(j)^2)+laterpart4;
    end
    if abs(x(t1)-x(t2)) >= abs(y(t1)-y(t2))
        beforey=[n,sum(x(t1:t2));sum(x(t1:t2)),sum(x(t1:t2).^2)];
        latery=[sum(y(t1:t2));laterpart1];
        ky=beforey\latery;
        for k=1:n
            error_line=error_line+abs(ky(2)*x(t1-1+k)+ky(1)-y(t1-1+k));
        end
        k_line=ky(2);b_line=ky(1);sign=1;
    else
        beforex=[n,sum(y(t1:t2));sum(y(t1:t2)),sum(y(t1:t2).^2)];
        laterx=[sum(x(t1:t2));laterpart1];
        kx=beforex\laterx;
        for k=1:n
            error_line=error_line+abs(kx(2)*y(t1-1+k)+kx(1)-x(t1-1+k));
        end  
        k_line=kx(2);b_line=kx(1);sign=2;
    end
    error_line=error_line/n;
    arclength=arc(t2-1)-arc(t1);
    if error_line < 0.1*arclength && mean(c(t1:t2))<1000
        t(i,1)=k_line;% fit the tangent with a line
        t(i,2)=b_line;
        t(i,3)=0;
        t(i,4)=sign;
        error(i)=error_line;
    else
        beforec=[2*sum(x(t1:t2).^2),2*laterpart1,sum(x(t1:t2));
                 2*laterpart1,2*sum(y(t1:t2).^2),sum(y(t1:t2));
                 2*sum(x(t1:t2)),2*sum(y(t1:t2)),n];
        laterc=[laterpart2;laterpart3;laterpart4];
        kc=beforec\laterc;
        angle=sqrt(x(t1)-x(t1+ceil(n/2)-1)^2+(y(t1)-y(t1+ceil(n/2)-1))^2);
        if sqrt(kc(1)^2+kc(2)^2-kc(3))*sind(18) <= angle*cosd(9)
            t(i,1)=kc(1);% fit the tangent with a circle
            t(i,2)=kc(2);
            t(i,3)=sqrt(kc(1)^2+kc(2)^2-kc(3));
            t(i,4)=3;
            for k=1:n
                error_circle=error_circle+abs(sqrt((y(t1-1+k)+kc(2))^2+(x(t1-1+k)+kc(1))^2)-...
                sqrt(kc(1)^2+kc(2)^2-kc(3)));
            end
            error(i)=error_circle/n;
        else
            t(i,1)=k_line;
            t(i,2)=b_line;
            t(i,3)=0;
            t(i,4)=sign;
            error(i)=error_line;
        end
    end
end

end


