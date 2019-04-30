% for i = 0:0.01:50

%     plot(t,po(t,1000,0,1000,0,-45,45));
%     hold on;
% end


% function x = testPad (t)
% t
%     t1 = mod(t,2)
%     if 0<=t1&&t1<1
%         x = 90*t-45
%     elseif 1<=t1&&t1<2
%         x = 45-90*(t1-1)
%     end
% end
% x = 1:0.01:5
% y1 = sawtooth(x*(2*pi)*0.5,0.5);
% plot(x,y1)


clc
clear figure

a1 = [1;0;0;1];
a2 = [0;1;0;1];
w2 = [1;0;0;1];
T0 = transl(0,0.2,0);
%两关节转动角速度
omega = 90;

ex4 = [1;0;0;1];
ez4 = [0;0;1;1];
%参数初始化
Fz = 0;
Fx = 0;
%blade微元长度
dy = 0.03;
%足尖总长
ymax = 0.2;

for t = 1:0.5:40
    t
    a1 = [1;0;0;1];
    Fz = 0;
    Fx = 0;
    w2 = [1;0;0;1];
%     %两个轴的旋转
%     T1 = trotx(omega/2*(t-pi/2));
%     T2 = troty(omega*(t));
%     
    
%     T1 = trotx(po(t,800,500,800,500,135,45));
%     T2 = troty(po(t-0.3,800,500,800,500,135,45));
T1 = trotx(t);
T2 = troty(t);    
    
    T = T1;
    norm(T1)
    %末关节坐标系下的单位向量在基坐标系下的表示
%     tamp_ex4 = T2 * T1 * ex4;
%     tamp_ez4 = T2 * T1 * ez4;
%     ex3 = tamp_ex4(1:3);
%     ez3 = tamp_ez4(1:3);
     %a2 = T * a2
%     a2 = T * a2;
    %末关节角速度向量
     w2 = T2 * (w2*omega/180*pi);
    figure(1)

    w = w2 + [0;1;0;1]*omega/180*pi;
    scatter3(w(1),w(2),w(3))
%     plot(a2(1),a2(2))
    hold on
%     figure(2)
%     plot(a2(2),a2(3))
%     hold on;
%     w = w2 + [0;1;0;1]*omega/180*pi;
%     B1 = a1(1:3);
%     B2 = a2(1:3);
    %合角速度
%     w = w(1:3);
    
    
    %合速度
    %v = cross(B1,W);
    
   %U = sqrt((dot(v,ex4)).^2+(dot(v,ey4)).^2);
  
%     plot(t,tampFz,'o')
%     hold on
%     figure(3)
%     plot(t,tampFx,'o')
%     hold on


end
