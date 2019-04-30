P = [-0.6 -0.7 0.8 0.6;0.9 0 1 0.9];    % P is the input
T = [1 0 0 1];                    % T is the target

net = perceptron();               % The update way to build a preceptron.
                                % In some older book, they use the function
                                % newp to build a preceptron.
net.trainParam.epochs = 15;     % set the train times      
net = train(net,P,T);           % The first place for the function train is
                                % for a NN, and the second one is for the
                                % input, the next is for the target.
%he = plotpc(net.iw{1},net.b{1});
%view(net)
%y = net(P);  



%Q = [0.5 0.8 -0.2 -0.5 0;-0.2 -0.6 0.6 -0.2 0.2];
Y = sim(net,Q);                  %sim函数主要用于动态方程、动态系统的计算
figure;                         %如何更改激活函数？
up = 120;
for i=1:20:up
    net.trainParam.epochs = 15;     % set the train times      
    net = train(net,P,T); 
    subplot(up/20,1,i/20+1);
    plotpv(Q,Y);
    he = plotpc(net.iw{1},net.b{1});
    
end
%
%subplot(4,1,2);
%plotpv(P,T);

h%e = plotpc(net.iw{1},net.b{1});

