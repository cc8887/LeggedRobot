function x2 = shape(y)
    
    b = 0.05;
    a = 0.2;
    e = 0;
    persistent x;
    if isempty(x)
    syms x1
    eqn = x1.^2 / b.^2 + (y-e).^2 / a.^2 == 1;
    x = solve(eqn,x1);
    end
    x = eval([x]);
    %��Ϊ����˫�⣬����ȡ�����ֵ
    x2 = x(x > 0);
    
    %y = solve((x.^2 / b.^2 + (y-e).^2 / a.^2 = 1),x = x1 ,y);

end