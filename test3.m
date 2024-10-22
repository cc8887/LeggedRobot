%clc;
clear;clf;
%水密度
pho = 1000;
%关节角速度
w = [0,0,0,pi/2];
%关节角加速度
a = [0,0,0,0];
%pos = random('norm',90,180,[1,5]);
%表示都为弧度制
pos2Ini = pi/2+pi/18; 
%pos2Ini = 0;
pos = [0,pos2Ini,0,0];
ra =10*random('norm',1,1,[3,1]);
cog3 = 10^-3.*[4.46769e-06 0.828721 54.3558];
cog2 = 10^-3.*[3.99327  4.81377  56.8377];
cog1 = 10^-3.*[6.89442  1.30829  51.234];
ra1 = 10^-6.*[1.369E+05 8567.547    1.314E+04;
              8567.547  1.277E+05   -2.145E+04;
              1.314E+04 -2.145E+04   1.008E+05];
ra2 = 10^-6.*[1.451E+05 -837.619    -1.574E+04;
             -837.619   1.114E+05   1262.242;
             -1.574E+04 1262.242    8.437E+04] ;
	Ixx = 1.489E+05;
	Ixy = 0.033;
	Ixz = 0.028;
	Iyx = 0.033;
	Iyy = 1.884E+05;
	Iyz = -8239.499;
	Izx = 0.028;
	Izy = -8239.499;
	Izz = 5.517E+04;
ra3 = 10^-6.*[Ixx Ixy Ixz;
              Iyx Iyy Iyz;
              Izx Izy Izz];
zero31 = zeros(3,1);
raI = 100*random('norm',5,1,[3,1]);
%可以通过D-H参数表示法来表示
%通过设置alpha的值来设置关节是否垂直
%r的值表示该link所受的重力的值 
%第一关节是以大地坐标系Z轴为转轴的
L(1) = Link('revolute','d',0.01,'a', 0, 'alpha', pi/2,'m',0);
%第二关节以大地坐标系Y为转轴(赋值为0时指向X正向)
L(2) = Link('revolute','d',0.01,'a',0.06, 'alpha', 0,'m',0.25,'r',cog1,'I',ra1);
L(3) = Link('revolute', 'd', 0.01, 'a', 0.1, 'alpha', pi,'m',0.18,'r',cog2,'I',ra2);
L(4) = Link('revolute', 'd', 0.01, 'a', 0, 'alpha', pi,'m',0.13,'r',cog3,'I',ra3);
robot=SerialLink(L,'name','robot');


%沿机械臂是x轴，垂直于旋转轴是z轴，
zi = [0;0;1];
xi = [1;0;0];
yi = [0;1;0];
T = 2;
ddt = 0.1;
ddphi = 0.1;
F_av = zeros(1/ddphi+1,1/ddphi+1);
L_av = zeros(1/ddphi+1,1/ddphi+1);
%输入功率
P_in = 0;
%输出功率
P_out = 0;
figList1 = zeros(1/ddphi+1,T/ddt+1);
figList2 = zeros(1/ddphi+1,T/ddt+1);
figList3 = zeros(1/ddphi+1,T/ddt+1);
%figList4 = zeros(1/ddphi+1,1);
figList5 = zeros(1/ddphi+1,1/ddphi+1);

for iiii = 0:ddphi:1
for ii = 0:ddphi:1
    P_in = 0;
    P_out = 0;
    for t = 0:ddt:T
       [pos(1),w(1),a(1)] = tra(pi/4,t,T);

       [pos(4),w(4),a(4)] = tra(pi/2*ii,t-iiii*T,T);
       gravity = [0,0,0];
       vWater = [0;0;0];
       [wolPoint,wolV,F_tol,M_tol,alpha] = legDy(robot,pos,w,a,gravity,vWater);
       [tau,wbase]=robot.rne(pos,w,a,'gravity',[0;0;0],'fext',[F_tol',M_tol']);
        %记得重新处理重力的影响

       figList1(round(ii/ddphi)+1,round(t/ddt)+1) = F_tol(1);

       figList2(round(ii/ddphi)+1,round(t/ddt)+1) = alpha/pi*180;

       figList3(round(ii/ddphi)+1,round(t/ddt)+1) = F_tol(2);
        
       P_in = tau * w' * ddt + P_in;
       P_out = wolV' * F_tol * ddt + P_out;

    end
    plotStart = 1;
    F_av(round(ii/ddphi)+1,round(iiii/ddphi)+1) = mean(figList1(round(ii/ddphi)+1,plotStart:end));
    L_av(round(ii/ddphi)+1,round(iiii/ddphi)+1) = mean(figList3(round(ii/ddphi)+1,plotStart:end));
 %   figList4(round(ii/ddphi)+1) = abs((mean(figList1(round(ii/ddphi)+1,plotStart:end)))./(P_in/T));
    figList5(round(ii/ddphi)+1,round(iiii/ddphi)+1) = abs(P_out/P_in/T);

end
end

    %从哪个点开始画
% plotStart = 1;
 tList = 0:ddt:T;
 iii = 0:ddphi:1;
 figure(1)
 mesh(tList,iii,figList1);
 xlabel('推力')
 figure(3)
 mesh(tList,iii,figList3);
 xlabel('升力')
% figure(2);
% plot(tList(plotStart:end)-0.5,figList1(plotStart:end));
% hold on;

figure(2);
mesh(tList,iii,figList2);
xlabel('攻角')
% figure(3);
% plot(tList(plotStart:end)-0.5,figList3(plotStart:end));
% hold on
figure(4)
tt = 0:ddphi:1;
subplot(2,1,1)
mesh(iii*T,iii*pi/2,-F_av);
xlabel('推力');
subplot(2,1,2)
mesh(iii*T,iii*pi/2,-L_av);
xlabel('升力');
figure(5);
mesh(iii*T,iii*pi/2,figList5);
axis([0 T 0 pi/2 0 1])
% subplot(2,1,1)
% plot(iii,figList4);
%axis([0 1 0 0.5])
% subplot(2,1,2)
% plot(iii,figList5);
%axis([0 1 0 0.5])
