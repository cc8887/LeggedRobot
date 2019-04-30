% clear;clc;
% dhparams = [0   	pi/2	0   	0;
%             0.4318	0       0       0
%             0.0203	-pi/2	0.15005	0;
%             0   	pi/2	0.4318	0;
%             0       -pi/2	0   	0;
%             0       0       0       0];
% 
% body1 = robotics.RigidBody('body1');
% jnt1 = robotics.Joint('jnt1','revolute');
% 
% setFixedTransform(jnt1,dhparams(1,:),'dh');
% body1.Joint = jnt1;
% 
% addBody(robot,body1,'base')
% body2 = robotics.RigidBody('body2');
% jnt2 = robotics.Joint('jnt2','revolute');
% body3 = robotics.RigidBody('body3');
% jnt3 = robotics.Joint('jnt3','revolute');
% body4 = robotics.RigidBody('body4');
% jnt4 = robotics.Joint('jnt4','revolute');
% body5 = robotics.RigidBody('body5');
% jnt5 = robotics.Joint('jnt5','revolute');
% body6 = robotics.RigidBody('body6');
% jnt6 = robotics.Joint('jnt6','revolute');
% 
% setFixedTransform(jnt2,dhparams(2,:),'dh');
% setFixedTransform(jnt3,dhparams(3,:),'dh');
% setFixedTransform(jnt4,dhparams(4,:),'dh');
% setFixedTransform(jnt5,dhparams(5,:),'dh');
% setFixedTransform(jnt6,dhparams(6,:),'dh');
% 
% body2.Joint = jnt2;
% body3.Joint = jnt3;
% body4.Joint = jnt4;
% body5.Joint = jnt5;
% body6.Joint = jnt6;
% 
% addBody(robot,body2,'body1')
% addBody(robot,body3,'body2')
% addBody(robot,body4,'body3')
% addBody(robot,body5,'body4')
% addBody(robot,body6,'body5')
% show(robot);
% axis([-0.5,0.5,-0.5,0.5,-0.5,0.5])
% axis off




clear;clc;
close all;
x1=-pi/2; a1=121.16; d1=191.99; 
x2=0; a2=850.94; th2=82.19*pi/180;
x3=0; a3=482.6; 
x4=pi/2; a4=133.35;
x5=-pi/2; a5=0; th5=pi/2;
x6=0; d6=380.9; 
ra = random('norm',5,1,[3,1]);
raI = random('norm',5,1,[3,1]);
L(1)= Link('revolute', 'd', 1.2, 'a', 0.3, 'alpha', pi/2,'m',1,'r',ra,'I',raI);
L(2)=Link('revolute', 'd', 1.2, 'a', 0.3, 'alpha', pi/2,'m',1,'r',ra,'I',raI);
L(3)=Link('revolute', 'd', 1.2, 'a', 0.3, 'alpha', pi/2,'m',1,'r',ra,'I',raI);
L(4)=Link('revolute', 'd', 1.2, 'a', 0.3, 'alpha', pi/2,'m',1,'r',ra,'I',raI);
L(5)=Link('revolute', 'd', 1.2, 'a', 0.3, 'alpha', pi/2,'m',1,'r',ra,'I',raI);
L(6)=Link('revolute', 'd', 1.2, 'a', 0.3, 'alpha', pi/2,'m',1,'r',ra,'I',raI);
robot6=SerialLink(L,'name','robot6');
%% ¹ì¼£¹æ»®-Ô²
Th=0:pi/60:2*pi;R=4; 
for I=1:length(Th)
j=1:length(Th);
x(1,j)=1500;
y(1,j)=R*sin(Th);
z(1,j)=0+R*cos(Th);
end
for ko=1:length(Th)
TTr=[x(ko),y(ko),z(ko)];
TO(:,:,ko)=transl(TTr)*trotz(-90)*troty(0)*trotx(-90);
end
qz=ikine(robot6,TO,'pinv');
plot3(x,y,z,'r','LineWidth',2);
hold on;
plot(robot6,qz,'loop');
hold off;