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
% [f,n,v]=stlread('G:\����\����������\���.stl');
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
% %�����ݿ���һ�·���246��ǰ������ݿ�����
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
% %����������ģ��
% %       theta    d        a        alpha     offset
% %��һ�ؽ����Դ������ϵZ��Ϊת���
% L3(1) = Link('revolute','d',0.01,'a', 0, 'alpha', pi/2,'m',0,'r',ra,'I',raI);
% %�ڶ��ؽ��Դ������ϵYΪת��(��ֵΪ0ʱָ��X����)
% L3(2) = Link('revolute','d',0.01,'a',0.06, 'alpha', 0,'m',0.1,'r',ra,'I',raI);
% L3(3) = Link('revolute', 'd', 0.01, 'a', 0.056, 'alpha', pi,'m',0.2,'r',ra,'I',raI);
% L3(4) = Link('revolute', 'd', 0.01, 'a',0.1725, 'alpha', pi,'m',0,'r',ra,'I',raI);
% %L(5) = Link('revolute', 'd', 1, 'a', 0, 'alpha', pi,'m',1,'r',ra,'I',raI);
% % L(6) = Link('revolute', 'd', 12, 'a', 60, 'alpha', pi,'m',1,'r',ra,'I',raI);
% % L(7) = Link('revolute', 'd', 12, 'a', 60, 'alpha', pi,'m',1,'r',ra,'I',raI);
% robot=SerialLink(L3,'name','robot');
% 
% %��һ�ؽ����Դ������ϵZ��Ϊת���
% L2(1) = Link('revolute','d',0.01,'a', 0, 'alpha', pi/2,'m',0,'r',ra,'I',raI);
% %�ڶ��ؽ��Դ������ϵYΪת��(��ֵΪ0ʱָ��X����)
% L2(2) = Link('revolute','d',0.01,'a',0.06, 'alpha', 0,'m',0.1,'r',ra,'I',raI);
% L2(3) = Link('revolute', 'd', 0.01, 'a', 0.056, 'alpha', pi,'m',0.2,'r',ra,'I',raI);
% L2(4) = Link('revolute', 'd', 0.01, 'a', 0.1725, 'alpha', pi,'m',0,'r',ra,'I',raI);
% robot2=SerialLink(L2,'name','robot');
% robot2.base=transl(0,0.25,0);
% A=unifrnd(-pi/2,pi/2,[1,PoNum]);%��һ�ؽڱ�����λ
% %B=unifrnd(pi/2,pi/2,[1,PoNum]);%�ڶ��ؽڱ�����λ
% C=unifrnd(-pi/2,pi/2,[1,PoNum]);%�ڶ��ؽڱ�����λ
% D=unifrnd(-pi/2,pi/2,[1,PoNum]);%�ڶ��ؽڱ�����λ
% G= cell(PoNum, 4);%����Ԫ������
% for n = 1:PoNum
%     G{n} =[A(n) pi/2 C(n) D(n)];
% end                                         %����3000�������
% H1=cell2mat(G);                       %��Ԫ������ת��Ϊ����
% T=double(robot.fkine(H1));       %��е������
% T2=double(robot2.fkine(H1));
% figure(1)
% scatter3(squeeze(T(1,4,:)),squeeze(T(2,4,:)),squeeze(T(3,4,:)),'+')%�����ͼ
% hold on
% scatter3(squeeze(T2(1,4,:)),squeeze(T2(2,4,:)),squeeze(T2(3,4,:)))
% robot.plot([pi 0 0,0],'workspace',[-2 2 -2 2 -2 2 ],'tilesize',2)%��е��ͼ
% hold on
% robot2.plot([pi 0 0,0],'workspace',[-2 2 -2 2 -2 2 ],'tilesize',2)%��е��ͼ
% 



% figure(10)
% plot(tList,figList1(end-374:end));
% hold on;
% plot(exper5(166:740,1)-exper5(166,1),exper5(166:740,1));
% figure(11)
% N = 200; %ԭʼ�źų���
% Fs = 400; %����Ƶ��HZ ����Ƶ��Ҫ���ٴ���ԭʼ�ź�Ƶ�ʶ���
% dt = 1/Fs; %�������S
% t = [0:N-1]*dt; %ʱ������
% FN = N; % ִ��100��FFT
% FY = fft(smooth(exper5(:,2),10)); % ����������жԳ���
% f0 = 1/(dt*FN); %��Ƶ
% f = [0:ceil((FN-1)/2)]*f0; %Ƶ������
% A = abs(FY); %��ֵ����
% stem(f, 2*A(1:ceil((FN-1)/2)+1)); %����Ƶ��
% 
% tt = -40:20:120;
% Cl = [1.16 0.595 0.58 0.53 1.07 1.14 1.17 1.28 1.08];
% Cd = [-1.24 -1.3 0.7 1.3 1.14 0.8 0.2 -0.11 -0.97];
%  plot(tt,Cl)
%   plot(tt,Cd)


L(1) = Link('revolute','d',0.01,'a', 10, 'alpha', pi/2,'m',10);
robot=SerialLink(L,'name','robot');
robot.plot([0])
