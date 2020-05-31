% Equation (3) of the paper
% We experimentally set t_1 = 20 and t_2 = 110. 
function y = model(x)
    low =20;
    high =110;
    C = 2*low* high^2/(high-low)^2; 
%     x = 0 :255;
    y(x>low)=(2*high^2-(x(x>low)-high).^2)/(2*high^2);
    y(x<=low)=1-x(x<=low)/C;
%     y  = max(y,1/3);  % (3) of the paper
    y  = max(y,1/2);    % A more conservative setting than (3) of the paper.
    y  = 1./y;
    y = reshape(y,size(x));
end
% figure,plot(x,y,'r-','linewidth',2)
% axis([0 255 0 1])
