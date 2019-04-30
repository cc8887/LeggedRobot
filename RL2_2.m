
function main()
dbstop if error
%choose = [randperm(8,1)];
maxTime = 20;
figure(1);
initList = 1:1:8;
initList = arrayfun(@(x) envir(x,0),initList)
for i = 1:1:maxTime
    choose = [];
    for t = 1:1:20
        %choose = [choose,3]
        if rand(1)>=0.5
            %这样的写法会出现一个问题：valueList在explore的时候没有被更新，它的值
            %t时刻时没有被更新为t-1时刻            
            [choose,tampList] = decsion(choose,initList);
        else
            choose = [choose,randperm(8,1)];
        end
    end
    initList = tampList;
    subplot(maxTime/4,4,i) 
    plot([1:1:length(choose)],choose,'LineStyle','none','Marker','o','MarkerSize',10,...
    'MarkerFace','y','MarkerEdge',[rand(1),rand(1),rand(1)],'LineWidth',2)
    
    if i==maxTime
        figure(2)
        plot([1:1:length(choose)],choose,'LineStyle','none','Marker','o','MarkerSize',10,...
        'MarkerFace','y','MarkerEdge',[1,0,0],'LineWidth',2)
    end
    
    %choose = choose(end);
end

end

%环境函数
function reward = envir(num,t)
%加入高斯噪声的reward
    %reward = (num*10-t)^2+2*normrnd(0,1);
    %reward = (t-t)+(10-num)^2
    %reward = (t-t)+(num==5)
    reward = sin(0.8*2*pi/8*num)+1*normrnd(0,1);
end


function value = valueFun(i,choose,initial)
    if isempty(choose)
        value = initial(i);
    else
        chooArray = (choose==i);
    %后面的加1是因为需要算入该次训练初始时记的value
        count = sum(chooArray) + 1;
    
        timeArray = 1:1:length(choose);
        reward = arrayfun(@(x) envir(i,x),timeArray);
    %这里是dot前的一项是上一次学习得到的N种选择的value,第一次运行的时候我给出的是一个
    %预设值,后面每次迭代都是给出的上一次训练得出的各种选择的一个value
        value = (initial(i)+dot(reward,chooArray))./count;
    end
end
%决策函数,输入之前的所有决策,返回当次训练完成后得出的决策list（包含之前的）和当次训练
%完成后得到的所有选择的value值的list
function [choose,value] = decsion(preChoose,initial)
    valueArray = [];
    for i = 1:1:8
        valueArray=[valueArray,valueFun(i,preChoose,initial)];
    end
    [tamp,num]=max(valueArray);
    choose = [preChoose,num];
    value = valueArray;
    %choose = num
end


