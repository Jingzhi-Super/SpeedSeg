function [dx] =centerdiff(x)
% perform the center difference
n=max(size(x));
dx=zeros(n-2,1);
for i = 2 : n-1
    dx(i-1)=x(i+1)-x(i-1);
end

end

