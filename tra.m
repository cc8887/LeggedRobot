%�ú�����Ҫ�Ǹ������ǹؽڵ�λ�á��ٶȡ����ٶȵ�
%���˶���ʽ�����ı�ʱ������ֻҪ�滻[r1,r2,r3,r4]����ĺ�������
%����t��ʱ�䣬A�Ƿ�ֵ,T������
function [r,v,a] = tra(A,t,T)
    ddt = 0.001;
    tList = 0:3;
%     rList = A*sawtooth(2*pi/T*(ddt.*tList+t),0.5);
    
    rList = A*sin(2*pi/T*(ddt.*tList+t));
    r = rList(1);
    v = (rList(2)-rList(1))/ddt;
    a = ((rList(4)-rList(3))/ddt-(rList(2)-rList(1))/ddt)/ddt;
end