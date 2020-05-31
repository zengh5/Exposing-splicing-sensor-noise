
function [u re]=KMeans(data,N)   
    m = length(data);   %
    u=zeros(N,1);       %
    %%%%%%%
     Sdata = sort(data);
    u(1) =mean(Sdata(end-round(m/4):end));   
    u(2) =mean(Sdata(1:round(m/4)));    
    umax = median(Sdata(end-round(m/100):end));
    data(data>umax)= umax;
    %%%%%%%%%%%%%
  
   iter = 0;
    while iter < 200         
   iter = iter+1;
        pre_u=u;            
        for i=1:N
                tmp(i,:)=data-u(i); 
        end
        tmp = abs(tmp);
        [junk index]=min(tmp);
        quan=zeros(m,N);
        for i=1:m        
            quan(i,index(i))=junk(i);           
        end
        
        for i=1:N             
            if (sum(quan(:,i))>0.01)
                u(i)= sum(quan(:,i).*data)/sum(quan(:,i));  
            end 
        end
        
        if norm(pre_u-u)<0.02  
            break;
        end
    end
    
    re=[];
    for i=1:m
        tmp=[];
        for j=1:N
            tmp=[tmp norm(data(i)-u(j))];
        end
        [junk index]=min(tmp);
        re=[re;data(i) index];
    end
    % we assume the spliced region is smaller than the full image
    label = re(:,2);
    if length(find(label==1))<m/2
        re(:,2)=3-label;
    end
end