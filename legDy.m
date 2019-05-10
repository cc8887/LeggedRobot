%����robot �ǻ����˹������еĻ�������
function [wolPoint,wolV,F_tol,M_tol,alpha] = legDy(robot,pos,w,a,gravity,vWater)

    %ˮ�ܶ�
    pho = 1000;
    
    zi = [0;0;1];
    xi = [1;0;0];
    yi = [0;1;0];
    %��ȡÿ���ؽڵ�SE3����ת�ƾ���
    [endPoint,SEList] = robot.fkine(pos/pi*180,'deg');
    %ĩ�ؽ�ԭ����ʦ������ϵ�µı�ʾ
    endPoint = SEList(4)*[0,0,0]';
    %�Ÿ��Ⱦ���
    J4 = robot.jacob0(pos);
    
    %v = J4*w';
    %��������ϵ�����ĵ�λ��
    %����ÿ�ٶȵ��ۼӺ�
    %�����洢ÿ����Ԫ���ٶȵĺ�
    U = 0;
    %ˮ������
   % vWater = [0;0;0];
    %vWater = [0;0*sin(t);0*cos(t)];
    %�����洢ÿ����Ԫ����������
    M_tol = 0;
    F_tol = 0;
    loc_M = 0;
    loc_F = 0;
    %ÿ��΢Ԫ�ĳ���
    dx = 0.01;
    %ͨ���Ÿ��Ⱦ������ο�ϵ���ٶ�
    endVel = J4*w';
    %����ת���ؽڵľ���
    bais = 0.09;
    locvWater = [dot(vWater,SEList(4)*xi);dot(vWater,SEList(4)*yi);dot(vWater,SEList(4)*zi)];
    
    for k = 0:dx:0.12
    %����ÿ�����ڱ�������ϵ�е�ֵ
        %��ķ�����ĩ�ؽ�����ϵ��������x�����
        %y�ᴹֱ����ı���
        locPoint_x = k + bais;
        
        locV = endVel(1:3);
        locPoint = [locPoint_x;0;0];
        wolPoint = SEList(4)*locPoint;
        %������һ���ٶ�ʱ�Ա�������ϵ��ʾ��
        %locV = [dot(locV,SEList(4)*xi-endPoint);dot(locV,SEList(4)*yi-endPoint);dot(locV,SEList(4)*zi-endPoint)];
        locV = [0;dot(locV,SEList(4)*yi-endPoint);dot(locV,SEList(4)*zi-endPoint)];
        %locV = [0;dot(locV,SEList(4)*yi);dot(locV,SEList(4)*zi)];
        locV_tamp = [w(4)*locPoint_x*yi;1];
        
      % T1 = trotz(pos(4)/pi*180);
       %locV_tamp = T1 * locV_tamp;
        %�õ���ǰ΢Ԫ���ٶ�
        locV_tamp = locV_tamp(1:3) + locV + locvWater;
        %locV_tamp = locV_tamp(1:3) + locV
        %�������
        U = norm(locV_tamp);
        %��ù���alpha
        %cosA = dot(locV_tamp,zi)/norm(U);
        %alpha = acos(cosA)
        alpha = atan(locV_tamp(3)/locV_tamp(2));
        %alpha = atan(locV_tamp(3)/abs(locV_tamp(2)));
        
        
        %�������������������������Ǹ���ξ������ⲿ���ںúò�һ�飡��������������������������
        % alpha = abs(alpha);
        
        %wolPoint = SEList(4)*locPoint;
        %relw = w(4)*zi;
        %vtamp = cross(locPoint,relw') + v(1:3) + cross(wolPoint',v(4:6));
        %U = (dot(vtamp',SEList(4)*yi))^2+(dot(vtamp',SEList(4)*zi))^2;
        %������������ĺ���
        %����������������
        L = 0.5.*pho*U^2.*zi*sin(2*alpha)*0.08*dx*CL(alpha);
%          L = 0.5.*pho*U^2.*zi*sin(2*alpha)*0.08*dx;
        %��������
        F = 0.5*pho*yi*U^2*cos(1-cos(2*alpha))*0.08*dx*CD(alpha);
%         F = 0.5*pho*yi*U^2*cos(1-cos(2*alpha))*0.08*dx;
        %����������
        F_m = pi*pho*locV_tamp*0.08*0.08/4*dx;
        %�������ڴ������ϵ�µı�ʾ
        wol_F = SEList(4) * (F+L+F_m)-endPoint;
        %���������
        M_tol = M_tol + cross(wolPoint,wol_F);
        %�������
        F_tol = F_tol + wol_F;
        %������ٶ�
        wolV = SEList(4)*locV_tamp-endPoint;
    end
    [tau,wbase]=robot.rne(pos,w,a,'gravity',gravity);
    %�ǵ����´���������Ӱ��
    F_tol = F_tol + wbase(1:3);
    M_tol = M_tol + wbase(4:6);    
end