%clc;
clear;clf;
%ˮ�ܶ�
pho = 1000;
%�ؽڽ��ٶ�
w = [0,0,0,pi/2];
%�ؽڽǼ��ٶ�
a = [0,0,0,0];
%pos = random('norm',90,180,[1,5]);
%��ʾ��Ϊ������
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
%����ͨ��D-H������ʾ������ʾ
%ͨ������alpha��ֵ�����ùؽ��Ƿ�ֱ
%r��ֵ��ʾ��link���ܵ�������ֵ 
%��һ�ؽ����Դ������ϵZ��Ϊת���
L(1) = Link('revolute','d',0.01,'a', 0, 'alpha', pi/2,'m',0);
%�ڶ��ؽ��Դ������ϵYΪת��(��ֵΪ0ʱָ��X����)
L(2) = Link('revolute','d',0.01,'a',0.06, 'alpha', 0,'m',0.25,'r',cog1,'I',ra1);
L(3) = Link('revolute', 'd', 0.01, 'a', 0.1, 'alpha', pi,'m',0.18,'r',cog2,'I',ra2);
L(4) = Link('revolute', 'd', 0.01, 'a', 0, 'alpha', pi,'m',0.13,'r',cog3,'I',ra3);
robot=SerialLink(L,'name','robot');


%�ػ�е����x�ᣬ��ֱ����ת����z�ᣬ
zi = [0;0;1];
xi = [1;0;0];
yi = [0;1;0];
T = 2;
ddt = 0.1;
ddphi = 0.01;
F_av = zeros(1/ddphi+1,1/ddphi+1);
L_av = zeros(1/ddphi+1,1/ddphi+1);
%���빦��
P_in = 0;
%�������
P_out = 0;
%figList4 = zeros(1/ddphi+1,1);
figList5 = zeros(1/ddphi+1,1/ddphi+1);

for iiii = 0.01:ddphi:1
for ii = 0:ddphi:1

     A = iiii*pi/2;
     phi = ii*pi;
     out = sim('powerCult');
        %�ǵ����´���������Ӱ��


      figList5(round(ii/ddphi)+1,round(iiii/ddphi)+1) = out.eff(2);
end
end

    %���ĸ��㿪ʼ��
% plotStart = 1;
 tList = 0:ddt:T;
 iii = 0:ddphi:1;
 mesh(iii*T,iii*pi/2,figList5);
% axis([0 T 0 pi/2 0 1])
% subplot(2,1,1)
% plot(iii,figList4);
%axis([0 1 0 0.5])
% subplot(2,1,2)
% plot(iii,figList5);
%axis([0 1 0 0.5])
