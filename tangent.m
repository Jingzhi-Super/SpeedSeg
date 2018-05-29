function [t] = tangent(x,y,arc,n)
% Find tangent angle by fitting a line or circle
t=zeros(size(x));
f=floor(n/2);
for i=1+f:size(x,1)-f
    laterpart1=0;laterpart2=0;laterpart3=0;laterpart4=0;
    error_line=0;
    for j=i-f:i+f
        laterpart1=x(j)*y(j)+laterpart1;
        laterpart2=-(x(j)^2+y(j)^2)*x(j)+laterpart2;
        laterpart3=-(x(j)^2+y(j)^2)*y(j)+laterpart3;
        laterpart4=-(x(j)^2+y(j)^2)+laterpart4;
    end
    if abs(x(i+f)-x(i-f)) >= abs(y(i+f)-y(i-f))
        beforey=[n,sum(x(i-f:i+f));sum(x(i-f:i+f)),sum(x(i-f:i+f).^2)];
        latery=[sum(y(i-f:i+f));laterpart1];
        ky=beforey\latery;
        for k=1:n
            error_line=error_line+abs(ky(2)*x(i-f-1+k)+ky(1)-y(i-f-1+k));
        end
        k_line=ky(2);
    else
        beforex=[n,sum(y(i-f:i+f));sum(y(i-f:i+f)),sum(y(i-f:i+f).^2)];
        laterx=[sum(x(i-f:i+f));laterpart1];
        kx=beforex\laterx;
        for k=1:n
            error_line=error_line+abs(kx(2)*y(i-f-1+k)+kx(1)-x(i-f-1+k));
        end  
        k_line=1/kx(2);
    end
    error_line=error_line/n;
    if i==f+1
        arclength=arc(n-1);
    else
        arclength=arc(i+f-1)-arc(i-f-1);
    end
    if error_line < 0.1*arclength;
        t(i)=atand(k_line);% fit the tangent with a line
        
        
    else
        beforec=[2*sum(x(i-f:i+f).^2),2*laterpart1,sum(x(i-f:i+f));
                 2*laterpart1,2*sum(y(i-f:i+f).^2),sum(y(i-f:i+f));
                 2*sum(x(i-f:i+f)),2*sum(y(i-f:i+f)),n];
        laterc=[laterpart2;laterpart3;laterpart4];
        kc=beforec\laterc;
        if sqrt(kc(1)^2+kc(2)^2-kc(3)) < .8
            t(i)=atand(-(kc(1)+x(i))/(y(i)+kc(2)));% fit the tangent with a circle
            
            
        else
            t(i)=atand(k_line);
           
            
        end
    end
end

t(1:f)=t(f+1);
t(end-f+1:end)=t(end-f);

end
    
    




