function main()
    A = reward([1,2],[3,4])
end
%%
function rentN = rentN(aveN)
    rentN = random('Poisson',aveN,1);
end

%%
function [returnN,newState] = returnN(aveNReturn)
    
end 
%%%
function [reward,newState] = reward(state,init)
%%这里假设我们这是计算A的车的净出入量
    rentNumber = rentN(init(1));
    returnNumber = returnN(init(2));
    %consume = rentNumber-returnNumber;
    %租车单价是10￥
    if((state(1)-rentNumber<0)&&(state(2)-returnNumber<0))
        reward = sum(state)*10;
        newState = [state(2),state(1)];
        return
    elseif (state(1)-rentNumber>0)&&(state(2)-returnNumber>0)
        reward = (rentNumber+returnNumber)*10;
        newState = [state(1)-(rentNumber-returnNumber),state(2)+(rentNumber-returnNumber)];
        return
    elseif (state(1)-rentNumber<0)&&(state(2)-returnNumber>0)
        reward = (state(1)+returnNumber)*10;
        newState = [returnNumber,state(2)-returnNumber+state(1)];
        return
    elseif (state(1)-rentNumber>0)&&(state(2)+returnNumber<0)
        reward = (state(2)+rentNumber)*10;
        newState = [state(1)-rentNumber+state(2),rentNumber];
        return
    end
end