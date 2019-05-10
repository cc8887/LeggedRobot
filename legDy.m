%传入robot 是机器人工具箱中的机器函数
function [wolPoint,wolV,F_tol,M_tol,alpha] = legDy(robot,pos,w,a,gravity,vWater)

    %水密度
    pho = 1000;
    
    zi = [0;0;1];
    xi = [1;0;0];
    yi = [0;1;0];
    %获取每个关节的SE3矩阵（转移矩阵）
    [endPoint,SEList] = robot.fkine(pos/pi*180,'deg');
    %末关节原点在师姐坐标系下的表示
    endPoint = SEList(4)*[0,0,0]';
    %雅各比矩阵
    J4 = robot.jacob0(pos);
    
    %v = J4*w';
    %本地坐标系下重心的位置
    %计算每速度的累加和
    %用来存储每个单元的速度的和
    U = 0;
    %水流流速
   % vWater = [0;0;0];
    %vWater = [0;0*sin(t);0*cos(t)];
    %用来存储每个单元产生的力矩
    M_tol = 0;
    F_tol = 0;
    loc_M = 0;
    loc_F = 0;
    %每个微元的长度
    dx = 0.01;
    %通过雅各比矩阵计算参考系的速度
    endVel = J4*w';
    %翼离转动关节的距离
    bais = 0.09;
    locvWater = [dot(vWater,SEList(4)*xi);dot(vWater,SEList(4)*yi);dot(vWater,SEList(4)*zi)];
    
    for k = 0:dx:0.12
    %计算每个点在本地坐标系中的值
        %翼的方向在末关节坐标系中是沿着x方向的
        %y轴垂直于翼的表面
        locPoint_x = k + bais;
        
        locV = endVel(1:3);
        locPoint = [locPoint_x;0;0];
        wolPoint = SEList(4)*locPoint;
        %到了这一步速度时以本地坐标系表示的
        %locV = [dot(locV,SEList(4)*xi-endPoint);dot(locV,SEList(4)*yi-endPoint);dot(locV,SEList(4)*zi-endPoint)];
        locV = [0;dot(locV,SEList(4)*yi-endPoint);dot(locV,SEList(4)*zi-endPoint)];
        %locV = [0;dot(locV,SEList(4)*yi);dot(locV,SEList(4)*zi)];
        locV_tamp = [w(4)*locPoint_x*yi;1];
        
      % T1 = trotz(pos(4)/pi*180);
       %locV_tamp = T1 * locV_tamp;
        %得到当前微元的速度
        locV_tamp = locV_tamp(1:3) + locV + locvWater;
        %locV_tamp = locV_tamp(1:3) + locV
        %求得速率
        U = norm(locV_tamp);
        %求得攻角alpha
        %cosA = dot(locV_tamp,zi)/norm(U);
        %alpha = acos(cosA)
        alpha = atan(locV_tamp(3)/locV_tamp(2));
        %alpha = atan(locV_tamp(3)/abs(locV_tamp(2)));
        
        
        %！！！！！！！！！！！攻角该如何就是那这部分在好好查一查！！！！！！！！！！！！！！
        % alpha = abs(alpha);
        
        %wolPoint = SEList(4)*locPoint;
        %relw = w(4)*zi;
        %vtamp = cross(locPoint,relw') + v(1:3) + cross(wolPoint',v(4:6));
        %U = (dot(vtamp',SEList(4)*yi))^2+(dot(vtamp',SEList(4)*zi))^2;
        %计算两个方向的合力
        %计算升力并向量化
        L = 0.5.*pho*U^2.*zi*sin(2*alpha)*0.08*dx*CL(alpha);
%          L = 0.5.*pho*U^2.*zi*sin(2*alpha)*0.08*dx;
        %计算阻力
        F = 0.5*pho*yi*U^2*cos(1-cos(2*alpha))*0.08*dx*CD(alpha);
%         F = 0.5*pho*yi*U^2*cos(1-cos(2*alpha))*0.08*dx;
        %附加质量力
        F_m = pi*pho*locV_tamp*0.08*0.08/4*dx;
        %计算力在大地坐标系下的表示
        wol_F = SEList(4) * (F+L+F_m)-endPoint;
        %计算合力矩
        M_tol = M_tol + cross(wolPoint,wol_F);
        %计算合力
        F_tol = F_tol + wol_F;
        %计算合速度
        wolV = SEList(4)*locV_tamp-endPoint;
    end
    [tau,wbase]=robot.rne(pos,w,a,'gravity',gravity);
    %记得重新处理重力的影响
    F_tol = F_tol + wbase(1:3);
    M_tol = M_tol + wbase(4:6);    
end