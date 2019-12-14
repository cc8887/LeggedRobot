%�������������ư�һ���Ĺؽڿ����ź�

function p = po(t,dt1,dt2,dt3,dt4,finP1,finP2)
tampT = mod(t*1000,(dt1+dt2+dt3+dt4));
%�������ǰ������úʹ�����һ����������д�Ķ��Ǻ��룬����������ǵ�����Ҳ��
dt1 = dt1/1000;
dt2 = dt2/1000;
dt3 = dt3/1000;
dt4 = dt4/1000;
tampT = tampT/1000;
if( tampT<=dt1)
    p = (finP1-finP2)/dt1 * tampT + finP2;
elseif (dt1<tampT<=dt2+dt1)
    p = finP1;
elseif ((dt2+dt1)<tampT<=(dt2+dt1+dt3))
    p = (finP2-finP1)/dt3 * (tampT-dt1-dt2) + finP1;
else
    p = finP2;
end

end