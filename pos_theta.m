%����robot �ǻ����˹������еĻ�������
function [mov,theta] = pos_theta(robot,pos)

    %ˮ�ܶ�
    
    zi = [0;0;1];
    xi = [1;0;0];
    yi = [0;1;0];
    %��ȡÿ���ؽڵ�SE3����ת�ƾ���
    [temp,SEList] = robot.fkine(pos/pi*180,'deg');
    %ĩ�ؽ�ԭ������������ϵ�µı�ʾ
    endPoint = SEList(4)*[0,0,0]';
    %��ķ�����ĩ�ؽ�����ϵ��������x�����
    %y�ᴹֱ����ı���
    t = double(SEList(4));
    theta = tr2rpy(t);
    mov = SEList(4)*[1,0,0]';
    
 
end