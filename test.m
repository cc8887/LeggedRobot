clc
clear figure
%��������
VV = [];
a1 = [1;0;0;1];
a2 = [0;1;0;1];
w2 = [1;0;0;1];
T0 = transl(0,0.2,0);
%���ؽ�ת�����ٶ�
omega = 90;

ex4 = [1;0;0;1];
ez4 = [0;0;1;1];
%������ʼ��
Fz = 0;
Fx = 0;
%blade΢Ԫ����
dy = 0.03;
%����ܳ�
ymax = 0.2;

for t = 1:0.01:4
    t
    a1 = [1;0;0;1];
    Fz = 0;
    Fx = 0;
    w2 = [1;0;0;1];
%     %���������ת
%     T1 = trotx(omega/2*(t-pi/2));
%     T2 = troty(omega*(t));
%     
    
%     T1 = trotx(po(t,800,500,800,500,135,45));
%     T2 = troty(po(t-0.3,800,500,800,500,135,45));
T1 = trotx(45*sawtooth(t*(2*pi)/2,0.5));
T2 = troty(45*sawtooth((t-0.4)*(2*pi)/2,0.5));    
    
    T = T2*T1*T0;
    
    %ĩ�ؽ�����ϵ�µĵ�λ�����ڻ�����ϵ�µı�ʾ
    tamp_ex4 = T2 * T1 * ex4;
    tamp_ez4 = T2 * T1 * ez4;
    ex3 = tamp_ex4(1:3);
    ez3 = tamp_ez4(1:3);
     a1 = T * a1;
%     a2 = T * a2;
    %ĩ�ؽڽ��ٶ�����
    w2 = T2 * (w2*omega/180*pi);
    figure(1)
    scatter3(a1(1),a1(2),a1(3));
    hold on
    
    w = 0*w2 + [0;1;0;1]*omega/180*pi;
    %scatter3(w(1),w(2),w(3));
%     B1 = a1(1:3);
%     B2 = a2(1:3);
    %�Ͻ��ٶ�
    w = w(1:3);
    
    
    %���ٶ�
    %v = cross(B1,W);
    
   %U = sqrt((dot(v,ex4)).^2+(dot(v,ey4)).^2);
    for y = 0 : dy : ymax
    %for y = 0 : dy : dy
        
        x = shape(y);
        %ÿ��΢Ԫ����������ϵ�µ�����
        a1 = [0;y;0;1];
        %��΢Ԫ���ڻ�����ϵ�µı�ʾ
        a1 = T * a1;
        %ȡ��ǰ����Ԫ��
        a1 = a1(1:3);
        %΢Ԫ���ٶ�
        v = cross(w, a1);
        %VV = [VV,v];
%         figure(4)
%         plot(t,norm(v))
        hold on
        %���ٶ����ݹ��洹ֱ���ͶӰ
        U = sqrt((dot(v,ex3)).^2+(dot(v,ez3)).^2);
        %��ֱ���ڵļн�
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
