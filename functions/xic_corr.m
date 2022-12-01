
function [r,p,t,n] = xic_corr(x,y)

    nan_id = isnan(x)+isnan(y);
    if sum(nan_id) >0
        x(nan_id>0) = [];
        y(nan_id>0) = [];
    end
    [r,p] = corr(x,y);
    n = size(x,1);
    t = xic_r2t(r,n);
    
%     r = r;
%     t = t;
%     p = p;
%     n = n;
end