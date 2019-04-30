
function [dFz,dFx] = BEfunction(c, phi, U, dy )

%流体密度
rho = 1000;
%U为相对于流体的速度在纵惯面垂面的投影
%U = 1;
%c:弦长

%升力系数、阻力系数（按说这俩都应该是攻角alpha的函数）
Cl = 1;
Cd = 1;

dL = 1/2 * rho * U.^2 * c * Cd * dy;
dD = 1/2 * rho * U.^2 * c * Cl * dy;


dFx = dL * sin( phi ) - dD * cos( phi );
dFz = dL * cos( phi ) + dD * sin( phi );
end
