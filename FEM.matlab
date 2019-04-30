clear all
elementNodes = [1 2;2 3;2 4];
%这一步的主要工作时通过我们已经定义的结点的
%连接方式来获得有几个element（也就是有几行）
numberElements = sizes(elementNodes,1)；
numberNodes = 4；
%定义了一个numbernode行，1列的零向量，
%作为位移（displacement）的容器
displacements = zeros(numberNodes,1)；
force = zeros(numberNodes,1);
%这里只有一个参数了，就是建立了一个维数为numNodes的一个矩阵
%这里为什么矩阵是numberNodes维的很好理解，因为我们的刚度是
%两个点之间的性质，也就是邻接矩阵，因此我们肯定就用了结点数
stiffness = zeros(numberNodes);

%合并刚度矩阵，因为我们的合并是对每一个element的刚度矩阵进
%行合并， 所以我们肯定要对numberelement进行遍历
for e = 1:numberElements
	elementDof = elementNodes(e;:);
	stiffness(elementDof,elementDof) = stiffness(elementDof,elementDof) + [1 -1;-1 1];
end



%在这个系统中加入负载，force由于是个向量，所以一下代表force
%向量的第二行
force(2) = 10.0；


%设置边界条件（在这里就是设置哪些结点被固定）
prescribedDof = [1;3;4];
%求出没有被约束的结点,setdiff是求两串数组不一样的数
activeDof = setdiff([1:4]',prescribedDof);
displacements(activeDof) = stiffness(activeDof,activeDof)\...
force(activeDof);

outputDisplacementsRections(displacements,stiffness,numberNodes,prescribedDof)