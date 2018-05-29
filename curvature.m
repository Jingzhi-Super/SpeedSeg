function [C] =curvature(theta,arc)
% find the curvature and modify it
C=centerdiff(theta)./diff(arc); % curvature
C(1:4)=[];C(end-3:end)=[];
if C(1)==Inf
    C(1)=C(2)+10000;
end
if C(1)==-Inf
    C(1)=C(2)-10000;
end
if C(end)==Inf
    C(end)=C(end-1)+10000;
end
if C(end)==-Inf
    C(end)=C(end-1)-10000;
end
for i=2:max(size(C))-1
    if C(i)==Inf
       C(i)=max(C(i-1),C(i+1))+10000;
    else if C(i)==-Inf
            C(i)=min(C(i-1),C(i+1))-10000;
        end
    end
end



end

