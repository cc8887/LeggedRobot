function testSF(block)
%MSFUNTMPL A Template for a MATLAB S-Function
%   The MATLAB S-function is written as a MATLAB function with the
%   same name as the S-function. Replace 'msfuntmpl' with the name
%   of your S-function.  
%
%   It should be noted that the MATLAB S-function is very similar
%   to Level-2 C-Mex S-functions. You should be able to get more 
%   information for each of the block methods by referring to the
%   documentation for C-Mex S-functions.
%  
%   Copyright 2003-2010 The MathWorks, Inc.
  
%
% The setup method is used to setup the basic attributes of the
% S-function such as ports, parameters, etc. Do not add any other
% calls to the main body of the function.  
%   
setup(block);
  
%endfunction

% Function: setup ===================================================
% Abstract:
%   Set up the S-function block's basic characteristics such as:
%   - Input ports
%   - Output ports
%   - Dialog parameters
%   - Options
% 
%   Required         : Yes
%   C-Mex counterpart: mdlInitializeSizes
%
function setup(block)

  % Register the number of ports.
  block.NumInputPorts  = 4;
  block.NumOutputPorts = 2;
  
  % Set up the port properties to be inherited or dynamic.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;

  % Override the input port properties.
  block.InputPort(1).DatatypeID  = 0;  % double
  block.InputPort(1).Complexity  = 'Real';
  block.InputPort(1).Dimensions = [4 1];
  
  block.InputPort(2).DatatypeID  = 0;  % double
  block.InputPort(2).Complexity  = 'Real';
  block.InputPort(2).Dimensions = [4 1];
  
  block.InputPort(3).DatatypeID  = 0;  % double
  block.InputPort(3).Complexity  = 'Real';
  block.InputPort(3).Dimensions = [4 1];
  
  block.InputPort(4).DatatypeID  = 0;  % double
  block.InputPort(4).Complexity  = 'Real';
  block.InputPort(4).Dimensions = [3 1];
  
%   block.InputPort(2).DatatypeID  = 0;  % double
%   block.InputPort(2).Complexity  = 'Real';
%   block.InputPort(2).Dimensions = [3 1];
 % block.InputPort(2).Dimensions = 1;
%   block.InputPort(2).DatatypeID  = 0;  % double
%   block.InputPort(2).Complexity  = 'Real'; 
  % Override the output port properties.
  block.OutputPort(1).DatatypeID  = 0; % double
  block.OutputPort(1).Complexity  = 'Real';
  block.OutputPort(1).Dimensions = [3,1];
  block.OutputPort(1).SamplingMode = 'Sample';
  
  block.OutputPort(2).DatatypeID  = 0; % double
  block.OutputPort(2).Complexity  = 'Real';
  block.OutputPort(2).Dimensions = [3,1];
  block.OutputPort(2).SamplingMode = 'Sample';
%   block.OutputPort(2).DatatypeID  = 1; % double
%   block.OutputPort(2).Complexity  = 'Real';

  % Register the parameters.
  block.NumDialogPrms     = 1;
  block.DialogPrmsTunable = {'Tunable'};
  
  % Set up the continuous states.
 % block.NumContStates = 1;

  % Register the sample times.
  %  [0 offset]            : Continuous sample time
  %  [positive_num offset] : Discrete sample time
  %
  %  [-1, 0]               : Inherited sample time
  %  [-2, 0]               : Variable sample time
  block.SampleTimes = [0.001 0];

  block.RegBlockMethod('CheckParameters', @CheckPrms);

  block.RegBlockMethod('PostPropagationSetup', @DoPostPropSetup);

  block.RegBlockMethod('InitializeConditions', @InitializeConditions);

  block.RegBlockMethod('Start', @Start);

  block.RegBlockMethod('Outputs', @Outputs);

  block.RegBlockMethod('Update', @Update);
  
 % block.RegBlockMethod('SetInputPortDimensions',  @SetInpPortDims);
  
  block.RegBlockMethod('SetInputPortSamplingMode', @SetInpPortFrameData);
  
  %block.RegBlockMethod('SetInPortSamplingMode',  @SetInputPortSamplingMode);

function CheckPrms(block)
  
  a = block.DialogPrm(1).Data;
  if ~strcmp(class(a), 'double')
    me = MSLException(block.BlockHandle, message('Simulink:blocks:invalidParameter'));
    throw(me);
  end
 
function SetInpPortFrameData(block, idx, fd)
  
  block.InputPort(idx).SamplingMode = fd;
     block.OutputPort(1).SamplingMode = 'Sample';
   block.OutputPort(2).SamplingMode = 'Sample';


% function SetInpPortDims(block, idx, di)
%   % Set the port dimensions for forward propagation of the dimensions.
%   block.InputPort(idx).Dimensions = di;
%   %block.OutputPort(1).Dimensions  = di;
  
%function SetInPortSamplingMode()
        
    
function DoPostPropSetup(block)
  block.NumDworks = 2;
  
  block.Dwork(1).Name            = 'aaa';
  block.Dwork(1).Dimensions      = 1;
  block.Dwork(1).DatatypeID      = 0;      % double
  block.Dwork(1).Complexity      = 'Real'; % real
  block.Dwork(1).UsedAsDiscState = true;
  
  block.Dwork(2).Name            = 'bbb';
  block.Dwork(2).Dimensions      = 1;
  block.Dwork(2).DatatypeID      = 0;      % uint32
  block.Dwork(2).Complexity      = 'Real'; % real
  block.Dwork(2).UsedAsDiscState = true;
  
  % Register all tunable parameters as runtime parameters.
  block.AutoRegRuntimePrms;

%endfunction

function InitializeConditions(block)
% aaa = 1;
% bbb = 0;
block.Dwork(1).Data = 1;

block.Dwork(2).Data = 1;
%block.ContStates.Data = 1;
%     L(1) = Link('revolute','d',0.01,'a', 0, 'alpha', pi/2);
%     %第二关节以大地坐标系Y为转轴(赋值为0时指向X正向)
%     L(2) = Link('revolute','d',0.01,'a',0.06, 'alpha', 0);
%     L(3) = Link('revolute', 'd', 0.01, 'a', 0.1, 'alpha', pi);
%     L(4) = Link('revolute', 'd', 0.01, 'a', 0.3, 'alpha', pi);

%endfunction

function Start(block)


function Outputs(block)


%     persistent robot;
%     robot = SerialLink(L,'name','robot');
    %pos = [block.InputPort(1).Data;1];
    %速度
    pos =   block.InputPort(1).Data;
    pos = pos';
    %w = [block.InputPort(1).Data;1];
    %角速度
    w = block.InputPort(2).Data;
    w = w';
    %a = [block.InputPort(1).Data;1]; 
    %加速度
    a = block.InputPort(3).Data;
    a = a';
    %机器人速度
    vWater = block.InputPort(4).Data;
   
    %水密度
    pho = 1000;    
    zi = [0;0;1];
    xi = [1;0;0];
    yi = [0;1;0];

    %获取每个关节的SE3矩阵（转移矩阵）
   % [endPointtamp,SEList] = robot.fkine(pos/pi*180,'deg');
   robot  = ini(pos);
   [endPointtamp,SEList] = robot.fkine(pos/pi*180,'deg');
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
    %locvWater = [dot(vWater,SEList(4)*xi-endPoint);dot(vWater,SEList(4)*yi-endPoint);dot(vWater,SEList(4)*zi-endPoint)];
    locvWater = SEList(4).t2r\vWater;
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
        
    end
    %[tau,wbase]=robot.rne(pos,w,a,'gravity',gravity);
    %记得重新处理重力的影响
   %F_tol = F_tol + wbase(1:3);
    %M_tol = M_tol + wbase(4:6);  
    F_tol(3) = 0;
    M_tol(3) = 0;
    block.OutputPort(1).Data = F_tol;
    block.OutputPort(2).Data = M_tol;
function Update(block)
  
%block.Dwork(2).Data
%   block.Dwork(1).Data = block.InputPort(1).Data;
  
