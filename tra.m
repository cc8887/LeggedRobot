%该函数主要是给出我们关节的位置、速度、加速度的
%当运动方式发生改变时，我们只要替换[r1,r2,r3,r4]后面的函数即可
%其中t是时间，A是幅值,T是周期
function [r,v,a] = tra(A,t,T)
    ddt = 0.001;
    tList = 0:3;
%     rList = A*sawtooth(2*pi/T*(ddt.*tList+t),0.5);
    
    rList = A*sin(2*pi/T*(ddt.*tList+t));
    r = rList(1);
    v = (rList(2)-rList(1))/ddt;
    a = ((rList(4)-rList(3))/ddt-(rList(2)-rList(1))/ddt)/ddt;
end