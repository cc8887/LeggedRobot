
function [dFz,dFx] = BEfunction(c, phi, U, dy )

%�����ܶ�
rho = 1000;
%UΪ�����������ٶ����ݹ��洹���ͶӰ
%U = 1;
%c:�ҳ�

%����ϵ��������ϵ������˵������Ӧ���ǹ���alpha�ĺ�����
Cl = 1;
Cd = 1;

dL = 1/2 * rho * U.^2 * c * Cd * dy;
dD = 1/2 * rho * U.^2 * c * Cl * dy;


dFx = dL * sin( phi ) - dD * cos( phi );
dFz = dL * cos( phi ) + dD * sin( phi );
end
