clear
dim = 10;
a = rand(dim);
for k = 1:dim 
    for kk = k:dim
        if(max(abs(a(k,:)))<max(abs(a(kk,:))))
            tamp = a(k,:);
            a(k,:) = a(kk,:);
            a(kk,:) = tamp;
            %%
            % 
            % $$e^{\pi i} + 1 = 0$$
            % 
        end
    end
    if(a(k,k)!=0)
        
end