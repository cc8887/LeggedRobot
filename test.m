clc
clear figure
%数据容器
VV = [];
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

for t = 1:0.01:4
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
T1 = trotx(45*sawtooth(t*(2*pi)/2,0.5));
T2 = troty(45*sawtooth((t-0.4)*(2*pi)/2,0.5));    
    
    T = T2*T1*T0;
    
    %末关节坐标系下的单位向量在基坐标系下的表示
    tamp_ex4 = T2 * T1 * ex4;
    tamp_ez4 = T2 * T1 * ez4;
    ex3 = tamp_ex4(1:3);
    ez3 = tamp_ez4(1:3);
     a1 = T * a1;
%     a2 = T * a2;
    %末关节角速度向量
    w2 = T2 * (w2*omega/180*pi);
    figure(1)
    scatter3(a1(1),a1(2),a1(3));
    hold on
    
    w = 0*w2 + [0;1;0;1]*omega/180*pi;
    %scatter3(w(1),w(2),w(3));
%     B1 = a1(1:3);
%     B2 = a2(1:3);
    %合角速度
    w = w(1:3);
    
    
    %合速度
    %v = cross(B1,W);
    
   %U = sqrt((dot(v,ex4)).^2+(dot(v,ey4)).^2);
    for y = 0 : dy : ymax
    %for y = 0 : dy : dy
        
        x = shape(y);
        %每个微元体在翼坐标系下的向量
        a1 = [0;y;0;1];
        %求微元体在基坐标系下的表示
        a1 = T * a1;
        %取出前三个元素
        a1 = a1(1:3);
        %微元合速度
        v = cross(w, a1);
        %VV = [VV,v];
%         figure(4)
%         plot(t,norm(v))
        hold on
        %合速度在纵惯面垂直面的投影
        U = sqrt((dot(v,ex3)).^2+(dot(v,ez3)).^2);
        %求垂直面内的夹角
        phi = atan( dot(v,ez3)/ dot(v,ex3) );
        [dFz,dFx] = BEfunction(2*x, phi, U, dy );
        Fz = Fz + dFz;
        Fx = Fx + dFx;     
    end
     tampFz =  Fz*ez3(3);
     tampFx =  Fx*ex3(3);
     figure(2)
%     plot(t,tampFz,'o')
%     hold on
%     figure(3)
    plot(t,tampFx,'o')
    hold on


end
