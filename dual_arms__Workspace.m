function dual_arms__Workspace
clc,clear
%GridCut
%L=Link([theta d a alpha]);
L(1)=Link([0 0 0.093 pi/2]);             %theta1[-60,60]
L(2)=Link([0 0 0.95  0]);                %theta2[-30,90]
L(3)=Link([0 0 0.127 pi/2]);             %theta3[-90,30]
L(4)=Link([0 0.522 0 -pi/2]);            %theta4[-90,90]
L(5)=Link([0 0 0 pi/2]);                 %theta5[-30,90] 
L(6)=Link([0 0.45 0 0]);              %theta6[360]
SIA7F=SerialLink(L,'name','SIA7F');
SIA7F.base=transl(0,-0.785,0);
% SIA7F.teach

R(1)=Link([0 0 0.121 pi/2]);             %theta1[-120,120]  
R(2)=Link([0 0 0.851 0]);                %theta2[-42,78]
R(3)=Link([0 0 0.483 0]);                %theta3[-164,106]
R(4)=Link([0 0 0.133 -pi/2]);            %theta4[-90,90]
R(5)=Link([0 0 0 -pi/2]);                %theta5[-90,90] 
R(6)=Link([0 0.336 0 0]);                %theta6[360]
TITAN4=SerialLink(R,'name','TITAN4');
TITAN4.base=transl(0,0.25,0);
% TITAN4.teach
SIA7F.plot([0 pi/2 -pi/6 0 0 0])
hold on
TITAN4.plot([0 pi/3 -pi/2 0 -pi/2 0])

%  syms theta1 theta2 theta3 theta4 theta5 theta6 theta7 theta8 theta9 theta10 theta11 theta12 

for i=1:100000
    theta1=-60+120*rand();
    theta1=theta1*pi/180;  
      theta2=-30+120*rand();
      theta2=theta2*pi/180;
           theta3=-90+120*rand();
           theta3=theta3*pi/180;
                theta4=-90+180*rand();
                theta4=theta4*pi/180;
                       theta5=-30+120*rand();
                       theta5=theta5*pi/180;
                              theta6=0;
%                                                                    
theta7=-120+240*rand();
   theta7=theta7*pi/180;
    theta8=-42+120*rand();
    theta8=theta8*pi/180;  
      theta9=-164+270*rand();
      theta9=theta9*pi/180;
           theta10=-90+180*rand();
           theta10=theta10*pi/180;
                theta11=-90+180*rand();
                theta11=theta11*pi/180;
                       theta12=0;
                       
                                     ql=[theta1,theta2,theta3,theta4,theta5,theta6];
                                     qr=[theta7,theta8,theta9,theta10,theta11,theta12];

                                     T=SIA7F.fkine(ql);
                                     T1=TITAN4.fkine(qr);
%                                       px=round(T(1,4));
                                      px=T(1,4);
                                      py=T(2,4);
                                      pz=T(3,4);
                                      px1=T1(1,4);
                                      py1=T1(2,4);
                                      pz1=T1(3,4);                                    
                                     
                                    
                                      plot3(px,py,pz,'r.')
                                    plot3(px1,py1,pz1,'g.')
                                      hold on
                                      grid on
                                      
end

%     view(3)
%     xlabel('X/mm')
%     ylabel('Y/mm')
%     zlabel('Z/mm')
% %       axis([-0.5 2 -2 2 -2 2])    ??????????????
%     view(0,90)
%     axis([-3 3 -4 4 -3 3])
% %     title('SIA7F-XY???????бу')
% %     title('TITAN4-XY???????бу')
%     xlabel('X/mm')
%     ylabel('Y/mm')
%     zlabel('Z/mm')
%    view(0,0)
% % axis([-3 3 -4 4 -3 3])
% set(gcf,'unit','normalized','position',[-2,-2,5,4])
% % %     title('SIA7F-XZ???????бу')
% %     title('TITAN4-XZ???????бу')
%     xlabel('X/mm')
%     ylabel('Y/mm')
%     zlabel('Z/mm')
    view(90,0)
    axis([-3 3 -3 3 -2 2])
%     title('SIA7F-YZ???????бу')
%     title('TITAN4-YZ???????бу')
    xlabel('X/mm')
    ylabel('Y/mm')
    zlabel('Z/mm')
end