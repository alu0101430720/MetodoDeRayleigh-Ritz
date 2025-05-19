%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function s=S1(n, a, b, coordx, RelTol, AbsTol)
   if nargin < 3
        n=5;
        a = 1;
        b = 2;
        coordx = linspace(a, b, 100);
        RelTol = 0;
        AbsTol = 1e-8;
   end
        
        h = (b-a)/n;
        xs = linspace(a,b,n+1);
        
        %Matriz masa
        di = zeros(n-1,1);
        up1 =zeros(n-1,1);
        v = zeros(n-1,1);

        for i = 1:n-1
            di(i) = integral(@(x)masa(x,i,i,n,h,a),...
                xs(i),xs(i)+2*h,'RelTol', RelTol, 'AbsTol', AbsTol);
            if i <= n-2
                up1(i+1) = integral(@(x)masa(x,i,i+1,n,h,a),...
                xs(i)+h,xs(i)+2*h,'RelTol', RelTol, 'AbsTol', AbsTol);
            end
            % Vector v
            v(i) = integral(@(x)rhs(x,i,n,h,a),...
                xs(i),xs(i) + 2*h,'RelTol', RelTol, 'AbsTol', AbsTol);
        end
        
        lo1 = [up1(2:n-1);0];
        
        M = spdiags([lo1,di,up1],-1:1,n-1,n-1);

        d = M\v;

        B = bspline1(n,h,a,coordx);
        s = d'*B;
end


function b=patronB1(t)
    
    b = zeros(size(t));
    
    rango1 = abs(t) < 1;
    t1 = t(rango1);
    b(rango1) = 1 - abs(t1);
end

function B = bspline1(n,h,a,x)
    
    B = zeros(n-1,length(x));
    t = (x-a)/h;
    for i=1:n-1
        B(i,:) = patronB1(t-i);
    end
end

function b=patrondB1(t)
    
    b = zeros(size(t));
    
    rango1 = t >= -1 & t < 0;
    rango2 = t > 0 & t < 1;
    b(rango1) = 1;
    b(rango2) =  -1;
end

function B = dBspline1(n,h,a,x)
    
    B = zeros(n-1,length(x));
    t = (x-a)/h;
    for i=1:n-1
        B(i,:) = 1/h*patrondB1(t-i);
    end
end


function y=p(x)
    y = x.^2;
end
function y=q(x)
    y = 6;
end
function y=f(x)
    y = 6 * x.^3;
end

function y = masa(x,i,j,n,h,a)
    B = bspline1(n,h,a,x);
    dB = dBspline1(n,h,a,x);
    y = p(x) .*dB(i,:) .*dB(j,:) + q(x) .*B(i,:) .*B(j,:);
end

function y = rhs(x,i,n,h,a)
    B = bspline1(n,h,a,x);
    y = f(x) .*B(i,:);
end
