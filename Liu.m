%����ͼƬ�Ѿ�����ȡ��������Image2���������
%�����ͼƬ��������һ����ֵ����ԣ��
level = graythresh(Image2);
%���������������ֵ����ͼƬ���кڰ׻�����
 BW = im2bw(Image2,level);
 %��bwlable������ͼƬ������ͨ������ͼƬ����һ��һ����������ɫ
 BW = bwlabel(BW);
 %��ͼƬ��ͨ������б�ǣ�����Ļ�����������ǵ����࣬��һ��boundingbox����С����
 %��ǣ��ڶ�����ͼ�ĵ��ǣ�����ڶ��������Ҫ��Ϊ�˻�ͼ���㣩�Ӱ����ĵ�����Կ�����
 %��������Ӳ�ͬ�Ķ���������ȡ����ͬ��Ԫ������������СԲ����ʲô��
bb = regionprops(BW,{'BoundingBox','Centroid'});
centroids = cat(1, bb.Centroid);
%��Ϊ����ͨ��reginprops�����õ�����һ�����Ľṹ�壨struct�����Բ�����������Ĳ���
%Ҳ�����㻭ͼ��������Ҫ��cat��������һ�£��������������ȡ����ת��Ϊһ������
boundingboxes = cat(1, bb.BoundingBox);
%���濪ʼ�ֲ�滭���Ȼ�ԭͼ
imshow(BW)
hold on
%����ÿ�����ε����ĵ�
%plot(centroids(:,1), centroids(:,2), 'r+')
%����ѭ����ÿ��С���ζ�������
for k = 1:size(boundingboxes,1)
    rectangle('position',boundingboxes(k,:),'Edgecolor','g')
end
hold off

