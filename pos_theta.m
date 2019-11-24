%传入robot 是机器人工具箱中的机器函数
function [mov,theta] = pos_theta(robot,pos)

    %水密度
    
    zi = [0;0;1];
    xi = [1;0;0];
    yi = [0;1;0];
    %获取每个关节的SE3矩阵（转移矩阵）
    [temp,SEList] = robot.fkine(pos/pi*180,'deg');
    %末关节原点在世界坐标系下的表示
    endPoint = SEList(4)*[0,0,0]';
    %翼的方向在末关节坐标系中是沿着x方向的
    %y轴垂直于翼的表面
    t = double(SEList(4));
    theta = tr2rpy(t);
    mov = SEList(4)*[1,0,0]';
    
 
end