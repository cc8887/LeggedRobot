function fluRe(block)
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
  block.NumInputPorts  = 2;
  block.NumOutputPorts = 2;
  
  % Set up the port properties to be inherited or dynamic.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;

  % Override the input port properties.
  block.InputPort(1).DatatypeID  = 0;  % double
  block.InputPort(1).Complexity  = 'Real';
  block.InputPort(1).Dimensions = [3 1];
    block.InputPort(2).DatatypeID  = 0;  % double
  block.InputPort(2).Complexity  = 'Real';
  block.InputPort(2).Dimensions = [3 1];
  
%   block.InputPort(2).DatatypeID  = 0;  % double
%   block.InputPort(2).Complexity  = 'Real';
%   block.InputPort(2).Dimensions = [4 1];
%   
%   block.InputPort(3).DatatypeID  = 0;  % double
%   block.InputPort(3).Complexity  = 'Real';
%   block.InputPort(3).Dimensions = [4 1];
%   
%   block.InputPort(4).DatatypeID  = 0;  % double
%   block.InputPort(4).Complexity  = 'Real';
%   block.InputPort(4).Dimensions = [3 1];
  
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
  
%   block.OutputPort(2).DatatypeID  = 0; % double
%   block.OutputPort(2).Complexity  = 'Real';
%   block.OutputPort(2).Dimensions = [3,1];
%   block.OutputPort(2).SamplingMode = 'Sample';
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
  block.SampleTimes = [0.01 0];

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
  % block.OutputPort(2).SamplingMode = 'Sample';


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
    C_Dx = 1;
    C_Dy = 1;
    C_Dz = 1;
    pho = 1000;
    S_x = 0.03;
    S_y = 0.02;
    S_z = 0.07;
    K_x = 0.001;
   %K_x = 0.1;
    K_y = 0.0003;
    %K_y = 0.3;
    K_z = 0.0007;
    %K_z = 0.7;
    v = block.InputPort(1).Data;
    w = block.InputPort(2).Data;
    F = -0.5.*pho.*[C_Dx*S_x*v(1)*abs(v(1));C_Dy*S_y*v(2)*abs(v(2));C_Dz*S_z*v(3)*abs(v(3))];
    M = -[K_x;K_y;K_z].*abs(w).*w;
    block.OutputPort(1).Data = F;
    block.OutputPort(2).Data = M;
function Update(block)
  
%block.Dwork(2).Data
%   block.Dwork(1).Data = block.InputPort(1).Data;
  
