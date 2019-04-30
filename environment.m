classdef environment
    properties
        rentAve
        returnAve
    end
    methods
        function rentN = rentN(aveN)
        function returnN = returnN(aveNReturn)
        function reward = reward(state)
    end
end

%%
function rentN = rentN(aveN)
    rentN = random('Poisson',aveN,1);
end

%%
function returnN = returnN(aveNReturn)
    returnN = random('Poisson',aveNReturn,1);
end 
%%%
function reward = reward(state)

end