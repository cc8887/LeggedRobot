%clc;
clear;clf;
%水密度
% pho = 1000;
%关节角速度
% w = [0,0,0,pi/2];
%关节角加速度
% a = [0,0,0,0];
%pos = random('norm',90,180,[1,5]);
%表示都为弧度制
% pos2Ini = pi/2+pi/18; 
%pos2Ini = 0;
% pos = [0,pos2Ini,0,0];
% ra =10*random('norm',1,1,[3,1]);
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
% raI = 100*random('norm',5,1,[3,1]);
%可以通过D-H参数表示法来表示
%通过设置alpha的值来设置关节是否垂直
%r的值表示该link所受的重力的值 
%第一关节是以大地坐标系Z轴为转轴的
L(1) = Link('revolute','d',0.0,'a', 0, 'alpha', pi/2,'m',0);
%第二关节以大地坐标系Y为转轴(赋值为0时指向X正向)
L(2) = Link('revolute','d',0.0,'a',0.06, 'alpha', 0,'m',0.25,'r',cog1,'I',ra1);
L(3) = Link('revolute', 'd', 0.0, 'a', 0.1, 'alpha', pi,'m',0.18,'r',cog2,'I',ra2);
L(4) = Link('revolute', 'd', 0.0, 'a', 0, 'alpha', pi,'m',0.13,'r',cog3,'I',ra3);
robot=SerialLink(L,'name','robot');


%沿机械臂是x轴，垂直于旋转轴是z轴，
zi = [0;0;1];
xi = [1;0;0];
yi = [0;1;0];
inipos = [0,pi/2,0,0];
tT = 10;
w = [   pi,      0,          0,          pi];
omega = [0,0,0,0];
A = [   pi/4,   pi/2,       pi/2,       pi/4];
phi = [0,0,0,pi/2];
pos = [0,0,0,0];
ddt = 0.01;
output=[];

    for t = 0:ddt:2*tT
        for i = 1:1:4
            pos(i) = A(i)*sin(w(i)*t+phi(i))+inipos(i);
            omega(i) =w(i)* A(i)*cos(w(i)*t+phi(i));
        end
        %[mov,theta] = pos_theta(robot,pos);
       % robot.plot(pos)
        j = robot.jacob0(omega,'rot');
        omegaOut = j*omega';
       % output = [output;t,mov',theta];
       output = [output;t,omegaOut'];
    end
    csvwrite('G:\\fluent.csv',output);

