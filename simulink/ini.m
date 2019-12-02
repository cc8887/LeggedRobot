function  robot = ini(pos)
%global robot
    persistent robot1
    if isempty(robot1)
        L(1) = Link('revolute','d',0.01,'a', 0, 'alpha', pi/2);
        %第二关节以大地坐标系Y为转轴(赋值为0时指向X正向)
        L(2) = Link('revolute','d',0.01,'a',0.06, 'alpha', 0);
        L(3) = Link('revolute', 'd', 0.01, 'a', 0.1, 'alpha', pi);
        L(4) = Link('revolute', 'd', 0.01, 'a', 0.3, 'alpha', pi);
        robot1 = SerialLink(L,'name','robot');
    end
    robot = robot1;
% [endPointtamp,SEList] = robot.fkine(pos/pi*180,'deg');
end