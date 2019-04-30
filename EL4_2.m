function main()
%return矩阵和rent矩阵做初始化
rentInit = randi(20,5,5);
returnInit = randi(20,5,5);
rentM = rentN(rentInit);
returnM = returnN(returnInit)


end


function rentM = rentN(init)
    rentM = random('Poisson',init,size(init));
end

function returnM = returnN(init)
    returnM = random('Poisson',init,size(init));
end