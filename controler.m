clear
a = 1;
num = [25];
den = [1 a 25];
bb = {'a=1'}
for a = 2:1:6
    bb = cat(2,bb,string('a=')+string(a));
end
t = 0:0.1:12;

for a =1:1:6

step([4],[1,a,4])

hold on 
%legend(bb);
end
text(1,3,'\leftarrow a=1')