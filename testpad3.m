clc;clear;clf;
%ˮ�ܶ�
pho = 1000;
%�ؽڽ��ٶ�
w = [0,0,0,pi/2];
%�ؽڽǼ��ٶ�
a = [0,0,0,0];
%pos = random('norm',90,180,[1,5]);
%��ʾ��Ϊ������
pos2Ini = pi/2+pi/18; 
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
%����ͨ��D-H������ʾ������ʾ
%ͨ������alpha��ֵ�����ùؽ��Ƿ�ֱ
%r��ֵ��ʾ��link���ܵ�������ֵ
%��һ�ؽ����Դ������ϵZ��Ϊת���
L(1) = Link('revolute','d',0.01,'a', 0, 'alpha', pi/2,'m',0);
%�ڶ��ؽ��Դ������ϵYΪת��(��ֵΪ0ʱָ��X����)
L(2) = Link('revolute','d',0.01,'a',0.06, 'alpha', 0,'m',0.25,'r',cog1,'I',ra1);
L(3) = Link('revolute', 'd', 0.01, 'a', 0.1, 'alpha', pi,'m',0.18,'r',cog2,'I',ra2);
L(4) = Link('revolute', 'd', 0.01, 'a', 0.3, 'alpha', pi,'m',0.13,'r',cog3,'I',ra3);
%L(5) = Link('revolute', 'd', 1, 'a', 0, 'alpha', pi,'m',1,'r',ra,'I',raI);
% L(6) = Link('revolute', 'd', 12, 'a', 60, 'alpha', pi,'m',1,'r',ra,'I',raI);
% L(7) = Link('revolute', 'd', 12, 'a', 60, 'alpha', pi,'m',1,'r',ra,'I',raI);
robot=SerialLink(L,'name','robot');

robot2 = SerialLink(L,'name','robot2');
robot2.base = transl([0 0.2 0]);

for t = 1:0.1:10
    %���Ķ�Ӧ�ؽ��ٶȡ��Ƕȡ����ٶ�
    [pos(1),w(1),a(1)] = tra(pi/4,t,2);
    %pos(1) = pos(1) + pi/2;
    [pos(4),w(4),a(4)] = tra(pi/4,t-0.5,2);
    %�ſɱȾ��󣨽��ٶȵ��ؽ�ĩ���ٶȵı任����
    J4 = robot.jacob0(pos);
    J42 = robot2.jacob0(pos);
    %ĩ�˵��ٶ�
    endVel = J4*w';
    endVel2 = J42*w';
    
    [endPoint,SEList] = robot.fkine(pos/pi*180,'deg');
    [endPoint2,SEList2] = robot2.fkine(pos/pi*180,'deg');
    wolPoint = SEList(4)*[0; 0; 0];
    wolPoint2 = SEList2(4)*[0; 0; 0];
    figure(1)
    robot.plot(pos)
    hold on
    robot2.plot(pos)
    plot3(wolPoint(1),wolPoint(2),wolPoint(3),'*');
    hold on
    plot3(wolPoint2(1),wolPoint2(2),wolPoint2(3),'o');
    hold on
    figure(2)
    plot(t,norm(endVel),'*')
    hold on;
    plot(t,norm(endVel2),'o')
    
end