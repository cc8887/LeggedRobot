function [F_x,F_y] = BladeTheoryTest(v_x,v_y,w)
    pho = 1000;
    bais = 0.09;
    dz = 0.01;
    F_x = 0;
    F_y = 0;
    for k = 0:dz:0.12
    %����ÿ�����ڱ�������ϵ�е�ֵ     
        %����v_x��v_y��ֵ
        V_x = v_x;
        V_y = v_y;       
        V_y = w * (k+bais) + v_y;      
        alpha = atan(V_x/V_y);
        U = norm([V_x V_y]);
        F_y = 0.5*pho*U^2*sin(2*alpha)*0.08*dz*CL(alpha) + F_y;
        %��������
        F_x = 0.5*pho*U^2*cos(1-cos(2*alpha))*0.08*dz*CD(alpha) + F_x;
        %���������� 
    end
end