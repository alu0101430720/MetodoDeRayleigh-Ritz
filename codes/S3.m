%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Carlos Yanes Pérez.
% Asignatura de MNEDP.
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function s=S3(n, a, b, coordx, RelTol, AbsTol)
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
        di = zeros(n+1,1);
        up1 =zeros(n+1,1);
        up2 =zeros(n+1,1);
        up3 =zeros(n+1,1);
        v = zeros(n+1,1);
        for i = 1:n+1
            di(i) = integral(@(x)masa(x,i,i,n,h,a),...
                max(a,xs(i) - 2*h),min(b,xs(i) + 2*h),'RelTol', RelTol, 'AbsTol', AbsTol);
            if i <= n
                up1(i+1) = integral(@(x)masa(x,i,i+1,n,h,a),...
                max(a,xs(i) - h),min(b,xs(i) + 2*h),'RelTol', RelTol, 'AbsTol', AbsTol);
            end
            if i <= n-1
                up2(i+2) = integral(@(x)masa(x,i,i+2,n,h,a),...
                max(a,xs(i)),min(b,xs(i) + 2*h),'RelTol', RelTol, 'AbsTol', AbsTol);
            end
            if i <= n-2
                up3(i+3) = integral(@(x)masa(x,i,i+3,n,h,a),...
                max(a,xs(i) + h),min(b,xs(i) + 2*h),'RelTol', RelTol, 'AbsTol', AbsTol);
            end
            % Vector v
            v(i) = integral(@(x)rhs(x,i,n,h,a),...
                max(a,xs(i)-2*h),min(b,xs(i) + 2*h),'RelTol', RelTol, 'AbsTol', AbsTol);
        end
        
        lo1 = [up1(2:n+1);0];
        lo2 = [up2(3:n+1);0;0];
        lo3 = [up3(4:n+1);0;0;0];
        
        M = spdiags([lo3,lo2,lo1,di,up1,up2,up3],-3:3,n+1,n+1);

        d = M\v;
        
        B = bspline3(n,h,a,coordx);
        s = d'*B;
end


function b=patronB3(t)
    
    b = zeros(size(t));
    
    rama1 = abs(t)< 1;
    rama2 = abs(t) >= 1 & abs(t) <=2;
    t1 = t(rama1);
    t2 = t(rama2);
    b(rama1) = 2/3 - abs(t1).^2 + abs(t1) .^3 / 2;
    b(rama2) = (2-abs(t2)).^3 / 6;
end

function B = bspline3(n,h,a,x)
    
    B = zeros(n+1,length(x));
    t = (x-a)/h;
    Bm = patronB3(t+1);
    Bp = patronB3(t-n-1);
    for i=1:n+1
        B(i,:) = patronB3(t-i+1);
    end
    B(2,:) = B(1,:) - 4*B(2,:); 
    B(1,:) = -4*Bm + B(1,:);
    B(n,:) = -4*B(n,:) + B(n+1,:);
    B(n+1,:) = B(n+1,:) - 4*Bp;
end

function b=patrondB3(t)
    
    b = zeros(size(t));
    
    rama1 = t >= -2 & t <= -1;
    rama2 = t > -1 & t < 0;
    rama3 = t >= 0 & t < 1;
    rama4 = t >= 1 & t <= 2;
    t1 = t(rama1);
    t2 = t(rama2);
    t3 = t(rama3);
    t4 = t(rama4);
    b(rama1) = (2+t1).^2/2;
    b(rama2) =  - 2* t2 - 3* t2.^2 / 2;
    b(rama3) =  - 2* t3 + 3* t3.^2 / 2;
    b(rama4) = - (2-t4).^2/2;
end

function B = dBspline3(n,h,a,x)
    
    B = zeros(n+1,length(x));
    t = (x-a)/h;
    Bm = 1/h*patrondB3(t+1);
    Bp = 1/h*patrondB3(t-n-1);
    for i=1:n+1
        B(i,:) = 1/h*patrondB3(t-i+1);
    end
    B(2,:) = B(1,:) - 4*B(2,:); 
    B(1,:) = -4*Bm + B(1,:);
    B(n,:) = -4*B(n,:) + B(n+1,:);
    B(n+1,:) = B(n+1,:) - 4*Bp;
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
    B = bspline3(n,h,a,x);
    dB = dBspline3(n,h,a,x);
    y = p(x) .*dB(i,:) .*dB(j,:) + q(x) .*B(i,:) .*B(j,:);
end

function y = rhs(x,i,n,h,a)
    B = bspline3(n,h,a,x);
    y = f(x) .*B(i,:);
end

