
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
            %������д�������һ�����⣺valueList��explore��ʱ��û�б����£�����ֵ
            %tʱ��ʱû�б�����Ϊt-1ʱ��            
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

%��������
function reward = envir(num,t)
%�����˹������reward
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
    %����ļ�1����Ϊ��Ҫ����ô�ѵ����ʼʱ�ǵ�value
        count = sum(chooArray) + 1;
    
        timeArray = 1:1:length(choose);
        reward = arrayfun(@(x) envir(i,x),timeArray);
    %������dotǰ��һ������һ��ѧϰ�õ���N��ѡ���value,��һ�����е�ʱ���Ҹ�������һ��
    %Ԥ��ֵ,����ÿ�ε������Ǹ�������һ��ѵ���ó��ĸ���ѡ���һ��value
        value = (initial(i)+dot(reward,chooArray))./count;
    end
end
%���ߺ���,����֮ǰ�����о���,���ص���ѵ����ɺ�ó��ľ���list������֮ǰ�ģ��͵���ѵ��
%��ɺ�õ�������ѡ���valueֵ��list
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


