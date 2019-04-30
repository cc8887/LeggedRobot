% clc;
% clear;
C = 1; 
% exper1 = xlsread('G:\桌面\仿生机器人\实验数据\012.xls','A3592:D4124');
% exper2 = xlsread('G:\桌面\仿生机器人\实验数据\013.xls','A134:D267');
% exper3 = xlsread('G:\桌面\仿生机器人\实验数据\015.xls','A1:D1585');
% exper4 = xlsread('G:\桌面\仿生机器人\实验数据\015.xls','A1:D2209');
exper5 = xlsread('G:\桌面\仿生机器人\实验数据\016.xls','A2497:D3265');
% bais = mean(exper2(1:100,:));
% bais2 = mean(exper3(1:100,:));
% 
% bais3 = mean(exper4(1:100,:));

bais5 = mean(exper5(size(exper5)-100:size(exper5),:));
%bais = -4677'
for i = 2:1:4
%     exper1(:,i) = (exper1(:,i)-bais(i))/200*C;
%     exper3(:,i) = (exper3(:,i)-bais2(i))/200*C;
%     exper4(:,i) = (exper4(:,i)-bais3(i))/200*C;
    
    exper5(:,i) = (exper5(:,i)-bais5(i))/200*C;
    %exper2(:,i) = (exper2(:,i)-bais(i))/200*C;
end
exper5(:,1) = exper5(:,1)-exper5(1,1);
%exper1(:,1) = exper1(:,1)-exper1(1,1);
%exper2(:,1) = exper2(:,1)-exper2(1,1);
% figure(5);
% plot(exper5(:,1),exper5(:,2));
% figure(6);
% plot(exper5(:,1),exper5(:,3));
% figure(7);
% plot(exper5(:,1),exper5(:,4));

begin = 209;
figure(5);

plot(exper5(begin:end,1)-exper5(begin,1),exper5(begin:end,2)/2);
figure(6);
%对应仿真中的x轴
plot(exper5(begin:end,1)-exper5(begin,1),exper5(begin:end,3)/2);
figure(7);
%对应仿真中的y轴
plot(exper5(begin:end,1)-exper5(begin,1),exper5(begin:end,4)/2);

%exper1(:,2) = exper1(:,2)-bais;
%exper = exper(1500:end,:);
%plot(exper(1:40,1),exper(1:40,2),'o')