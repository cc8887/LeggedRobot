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
%ra3 = 10^-6.*[];
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
L(4) = Link('revolute', 'd', 0.01, 'a', 0.3, 'alpha', pi,'m',0.13,'r',cog3,'I',ra3);
%L(5) = Link('revolute', 'd', 1, 'a', 0, 'alpha', pi,'m',1,'r',ra,'I',raI);
% L(6) = Link('revolute', 'd', 12, 'a', 60, 'alpha', pi,'m',1,'r',ra,'I',raI);
% L(7) = Link('revolute', 'd', 12, 'a', 60, 'alpha', pi,'m',1,'r',ra,'I',raI);
robot=SerialLink(L,'name','robot');


%沿机械臂是x轴，垂直于旋转轴是z轴，
zi = [0;0;1];
xi = [1;0;0];
yi = [0;1;0];
T = 2;
ddt = 0.1;
ddphi = 0.01;
F_av = [];
L_av = [];
%输入功率
P_in = 0;
%输出功率
P_out = 0;
% figList1 = zeros(T/ddt+1,1/ddphi+1);
% figList2 = zeros(T/ddt+1,1/ddphi+1);
% figList3 = zeros(T/ddt+1,1/ddphi+1);

figList1 = zeros(1/ddphi+1,T/ddt+1);
figList2 = zeros(1/ddphi+1,T/ddt+1);
figList3 = zeros(1/ddphi+1,T/ddt+1);
figList4 = zeros(1/ddphi+1,1);
figList5 = zeros(1/ddphi+1,1);
for ii = 0:ddphi:1
    P_in = 0;
    P_out = 0;
    for t = 0:ddt:T
       [pos(1),w(1),a(1)] = tra(pi/4,t,T);
        %pos(1) = pos(1) + pi/2;
       [pos(4),w(4),a(4)] = tra(pi/4,t-ii*T,T);

      % [pos(4),w(4),a(4)] = tra(pi/4,t-0.5,1);
    %     [pos(2),w(2),a(2)] = tra(pi/10,t,2);
      %  pos(2) = pos(2) + pos2Ini;
    %     w = 0*w;
    %     a = 0*a;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %     %获取每个关节的SE3矩阵（转移矩阵）
    %     [endPoint,SEList] = robot.fkine(pos/pi*180,'deg');
    %     %末关节原点在师姐坐标系下的表示
    %     endPoint = SEList(4)*[0,0,0]';
    %     %雅各比矩阵
    %     J4 = robot.jacob0(pos);
    %     
    %     %v = J4*w';
    %     %本地坐标系下重心的位置
    %     %计算每速度的累加和
    %     %用来存储每个单元的速度的和
    %     U = 0;
    %     %水流流速
    %     vWater = [0;0;0];
    %     %vWater = [0;0*sin(t);0*cos(t)];
    %     %用来存储每个单元产生的力矩
    %     M_tol = 0;
    %     F_tol = 0;
    %     loc_M = 0;
    %     loc_F = 0;
    %     %每个微元的长度
    %     dx = 0.01;
    %     %通过雅各比矩阵计算参考系的速度
    %     endVel = J4*w';
    %     %翼离转动关节的距离
    %     bais = 0.09;
    %     locvWater = [dot(vWater,SEList(4)*xi);dot(vWater,SEList(4)*yi);dot(vWater,SEList(4)*zi)];
    %     
    %     for k = 0:dx:0.12
    %     %计算每个点在本地坐标系中的值
    %         %翼的方向在末关节坐标系中是沿着x方向的
    %         %y轴垂直于翼的表面
    %         locPoint_x = k + bais;
    %         
    %         locV = endVel(1:3);
    %         locPoint = [locPoint_x;0;0];
    %         wolPoint = SEList(4)*locPoint;
    %         %到了这一步速度时以本地坐标系表示的
    %         %locV = [dot(locV,SEList(4)*xi-endPoint);dot(locV,SEList(4)*yi-endPoint);dot(locV,SEList(4)*zi-endPoint)];
    %         locV = [0;dot(locV,SEList(4)*yi-endPoint);dot(locV,SEList(4)*zi-endPoint)];
    %         %locV = [0;dot(locV,SEList(4)*yi);dot(locV,SEList(4)*zi)];
    %         locV_tamp = [w(4)*locPoint_x*yi;1];
    %         
    %       % T1 = trotz(pos(4)/pi*180);
    %        %locV_tamp = T1 * locV_tamp;
    %         %得到当前微元的速度
    %         locV_tamp = locV_tamp(1:3) + locV + locvWater;
    %         %locV_tamp = locV_tamp(1:3) + locV
    %         %求得速率
    %         U = norm(locV_tamp);
    %         %求得攻角alpha
    %         %cosA = dot(locV_tamp,zi)/norm(U);
    %         %alpha = acos(cosA)
    %         alpha = atan(locV_tamp(3)/locV_tamp(2));
    %         
    %         
    %         %！！！！！！！！！！！攻角该如何就是那这部分在好好查一查！！！！！！！！！！！！！！
    %          alpha = abs(alpha);
    %         
    %         %wolPoint = SEList(4)*locPoint;
    %         %relw = w(4)*zi;
    %         %vtamp = cross(locPoint,relw') + v(1:3) + cross(wolPoint',v(4:6));
    %         %U = (dot(vtamp',SEList(4)*yi))^2+(dot(vtamp',SEList(4)*zi))^2;
    %         %计算两个方向的合力
    %         %计算升力并向量化
    %         L = 0.5.*pho*U^2.*zi*sin(2*alpha)*0.08*dx*CL(alpha);
    % %          L = 0.5.*pho*U^2.*zi*sin(2*alpha)*0.08*dx;
    %         %计算阻力
    %         F = 0.5*pho*yi*U^2*cos(1-cos(2*alpha))*0.08*dx*CD(alpha);
    % %         F = 0.5*pho*yi*U^2*cos(1-cos(2*alpha))*0.08*dx;
    %         %附加质量力
    %         F_m = pi*pho*locV_tamp*0.08*0.08/4*dx;
    %         %计算力在大地坐标系下的表示
    %         wol_F = SEList(4) * (F+L+F_m)-endPoint;
    %         %计算合力矩
    %         M_tol = M_tol + cross(wolPoint,wol_F);
    %         %计算合力
    %         F_tol = F_tol + wol_F;
    %         %计算合速度
    %         wolV = SEList(4)*locV_tamp-endPoint;
    %     end
    %     [tau,wbase]=robot.rne(pos,w,a,'gravity',[0;0;0]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%


        gravity = [0,0,0];
         vWater = [1;0;0];
       [wolPoint,wolV,F_tol,M_tol,alpha] = legDy(robot,pos,w,a,gravity,vWater);
       [tau,wbase]=robot.rne(pos,w,a,'gravity',[0;0;0],'fext',[F_tol',M_tol']);
        %记得重新处理重力的影响
    %     F_tol = F_tol + wbase(1:3);
    %     M_tol = M_tol + wbase(4:6);
       figList1(round(ii/ddphi)+1,round(t/ddt)+1) = F_tol(1);
    %      figList1(round(t/ddt)+1) = norm(L);
       figList2(round(ii/ddphi)+1,round(t/ddt)+1) = alpha/pi*180;

      % figList2(round(t/ddt)+1) = U;
    %      figList3(round(t/ddt)+1) = norm(F);
        figList3(round(ii/ddphi)+1,round(t/ddt)+1) = F_tol(2);
        
        P_in = tau*w' * ddt + P_in;
        P_out = wolV' * F_tol*ddt + P_out;
     %   figList3(round(t/ddt)+1) = F_tol(3);
    %      figure(1);
    %      plot(t,F_tol(1),'o');
    %      hold on;

    %    figure(4)
      %  robot.plot(pos)
      %  SEList(4).plot
    %    endVel;
       % quiver3(wolPoint(1),wolPoint(2),wolPoint(3),wolV(1),wolV(2),wolV(3),0.2,'b');
       % plot3(wolPoint(1),wolPoint(2),wolPoint(3),'o')
      %  hold on;
    %     figure(3)
    %     plot(t,alpha,'o')
    %     hold on;
    end
    plotStart = 1;
    F_av = [F_av;mean(figList1(round(ii/ddphi)+1,plotStart:end))];
    L_av = [L_av;mean(figList3(round(ii/ddphi)+1,plotStart:end))];
    figList4(round(ii/ddphi)+1) = (mean(figList1(round(ii/ddphi)+1,plotStart:end)))./(P_in/T);
    figList5(round(ii/ddphi)+1) = P_out/P_in/T;
    
    %     for tList = 0:ddt:T;
%         figure(1);
%         plot3(ii,tList,figList1(round(tList/ddt)+1));
%         hold on;
%     %     figure(2);
%     %     plot(tList(plotStart:end)-0.5,figList2(plotStart:end));
%        % hold on;
%         figure(3);
%         plot3(ii,tList,figList3(round(tList/ddt)+1));
%         hold on;
%     end
 %   tamp_av = [tamp_av;mean(figList1(plotStart:end))];
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
plot(iii,F_av);
xlabel('推力');
subplot(2,1,2)
plot(iii,L_av);
xlabel('升力');
figure(5);
subplot(2,1,1)
plot(iii,figList4);
subplot(2,1,2)
plot(iii,figList5);
