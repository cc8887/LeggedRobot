for i =1:1515
    dis2(i)=(dis(i+1)-dis(i))/0.1;
    velerror1(i) = dis2(i)-vel(i);
    velerror2(i) = dis2(i)-vel(i+1);
end
