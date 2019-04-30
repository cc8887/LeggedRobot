%假设图片已经被读取，储存在Image2这个变量中
%这里对图片计算合理的一个二值化的裕度
level = graythresh(Image2);
%用上面算出来的阈值来对图片进行黑白化处理
 BW = im2bw(Image2,level);
 %用bwlable函数对图片进行联通处理，是图片都是一块一块连续的颜色
 BW = bwlabel(BW);
 %对图片连通区域进行标记（下面的花括号里代表标记的种类，第一个boundingbox是最小矩形
 %标记，第二个是图心点标记，引入第二个标记主要是为了绘图方便）从帮助文档里可以看，在
 %花括号里加不同的东西可以提取出不同的元素来，比如最小圆包络什么的
bb = regionprops(BW,{'BoundingBox','Centroid'});
centroids = cat(1, bb.Centroid);
%因为我们通过reginprops函数得到的是一个个的结构体（struct）所以不方便用数组的操作
%也不方便画图，所以需要用cat函数处理一下，吧它里面的数据取出来转化为一个矩阵
boundingboxes = cat(1, bb.BoundingBox);
%下面开始分层绘画，先画原图
imshow(BW)
hold on
%画出每个矩形的中心点
%plot(centroids(:,1), centroids(:,2), 'r+')
%利用循环吧每个小矩形都画出来
for k = 1:size(boundingboxes,1)
    rectangle('position',boundingboxes(k,:),'Edgecolor','g')
end
hold off

