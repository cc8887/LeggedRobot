clc;clear;clf;
% for t = 0:0.1:10;
% [r,v,a]=tra(pi/4,t,2)
% figure(1);
% plot(t,r,'o');
% hold on;
% figure(2);
% plot(t,v,'o');
% hold on;
% figure(3);
% plot(t,a,'o');
% hold on;
% end
% [f,n,v]=stlread('G:\桌面\仿生机器人\足尖.stl');
% n(:,1) = n(:,1)-mean(n(:,1));
% n(:,2) = n(:,2)-max(n(:,2));
% n(:,3) = n(:,3)-mean(n(:,3));
% scatter3(n(:,1),n(:,2),n(:,3));
% k = boundary(n(:,2),n(:,3));
% b = [n(k,2),n(k,3)];
% k = find(b(:,2)>0);
% b = b(k,:);
% k = find(b(:,1)<0);
% b = b(k,:);
% %打开数据看了一下发现246行前面的数据可以用
% plot(b(1:246,1),b(1:246,2))
% 
% z = [0,0,0];
% a = [1,0,0,1];
% %a = trotx(45)*a;
% figure(2)
% quiver3(0,0,0,a(1),a(2),a(3))
% norm(a)
% hold on
% a = troty(45)*a';
% quiver3(0,0,0,a(1),a(2),a(3))
% norm(a)
% hold on
% a = troty(90)*a;
% quiver3(0,0,0,a(1),a(2),a(3))
% norm(a)
% hold on
% axis equal
% PoNum = 3000;
% 
% ra = 0.1*random('norm',5,1,[3,1]);           
% zero31 = zeros(3,1);
% raI = 0.1*random('norm',5,1,[3,1]);
% %建立机器人模型
% %       theta    d        a        alpha     offset
% %第一关节是以大地坐标系Z轴为转轴的
% L3(1) = Link('revolute','d',0.01,'a', 0, 'alpha', pi/2,'m',0,'r',ra,'I',raI);
% %第二关节以大地坐标系Y为转轴(赋值为0时指向X正向)
% L3(2) = Link('revolute','d',0.01,'a',0.06, 'alpha', 0,'m',0.1,'r',ra,'I',raI);
% L3(3) = Link('revolute', 'd', 0.01, 'a', 0.056, 'alpha', pi,'m',0.2,'r',ra,'I',raI);
% L3(4) = Link('revolute', 'd', 0.01, 'a',0.1725, 'alpha', pi,'m',0,'r',ra,'I',raI);
% %L(5) = Link('revolute', 'd', 1, 'a', 0, 'alpha', pi,'m',1,'r',ra,'I',raI);
% % L(6) = Link('revolute', 'd', 12, 'a', 60, 'alpha', pi,'m',1,'r',ra,'I',raI);
% % L(7) = Link('revolute', 'd', 12, 'a', 60, 'alpha', pi,'m',1,'r',ra,'I',raI);
% robot=SerialLink(L3,'name','robot');
% 
% %第一关节是以大地坐标系Z轴为转轴的
% L2(1) = Link('revolute','d',0.01,'a', 0, 'alpha', pi/2,'m',0,'r',ra,'I',raI);
% %第二关节以大地坐标系Y为转轴(赋值为0时指向X正向)
% L2(2) = Link('revolute','d',0.01,'a',0.06, 'alpha', 0,'m',0.1,'r',ra,'I',raI);
% L2(3) = Link('revolute', 'd', 0.01, 'a', 0.056, 'alpha', pi,'m',0.2,'r',ra,'I',raI);
% L2(4) = Link('revolute', 'd', 0.01, 'a', 0.1725, 'alpha', pi,'m',0,'r',ra,'I',raI);
% robot2=SerialLink(L2,'name','robot');
% robot2.base=transl(0,0.25,0);
% A=unifrnd(-pi/2,pi/2,[1,PoNum]);%第一关节变量限位
% %B=unifrnd(pi/2,pi/2,[1,PoNum]);%第二关节变量限位
% C=unifrnd(-pi/2,pi/2,[1,PoNum]);%第二关节变量限位
% D=unifrnd(-pi/2,pi/2,[1,PoNum]);%第二关节变量限位
% G= cell(PoNum, 4);%建立元胞数组
% for n = 1:PoNum
%     G{n} =[A(n) pi/2 C(n) D(n)];
% end                                         %产生3000组随机点
% H1=cell2mat(G);                       %将元胞数组转化为矩阵
% T=double(robot.fkine(H1));       %机械臂正解
% T2=double(robot2.fkine(H1));
% figure(1)
% scatter3(squeeze(T(1,4,:)),squeeze(T(2,4,:)),squeeze(T(3,4,:)),'+')%随机点图
% hold on
% scatter3(squeeze(T2(1,4,:)),squeeze(T2(2,4,:)),squeeze(T2(3,4,:)))
% robot.plot([pi 0 0,0],'workspace',[-2 2 -2 2 -2 2 ],'tilesize',2)%机械臂图
% hold on
% robot2.plot([pi 0 0,0],'workspace',[-2 2 -2 2 -2 2 ],'tilesize',2)%机械臂图
% 



% figure(10)
% plot(tList,figList1(end-374:end));
% hold on;
% plot(exper5(166:740,1)-exper5(166,1),exper5(166:740,1));
% figure(11)
% N = 200; %原始信号长度
% Fs = 400; %采样频率HZ 采样频率要至少大于原始信号频率二倍
% dt = 1/Fs; %采样间隔S
% t = [0:N-1]*dt; %时间序列
% FN = N; % 执行100点FFT
% FY = fft(smooth(exper5(:,2),10)); % 共轭复数，具有对称性
% f0 = 1/(dt*FN); %基频
% f = [0:ceil((FN-1)/2)]*f0; %频率序列
% A = abs(FY); %幅值序列
% stem(f, 2*A(1:ceil((FN-1)/2)+1)); %绘制频谱
% 
% tt = -40:20:120;
% Cl = [1.16 0.595 0.58 0.53 1.07 1.14 1.17 1.28 1.08];
% Cd = [-1.24 -1.3 0.7 1.3 1.14 0.8 0.2 -0.11 -0.97];
%  plot(tt,Cl)
%   plot(tt,Cd)

% 
% L(1) = Link('revolute','d',0.01,'a', 10, 'alpha', pi/2,'m',10);
% robot=SerialLink(L,'name','robot');
% robot.plot([0])
a = [1 1];
qq(1) = ones(2,1);
qq(2) = ones(2,1);
