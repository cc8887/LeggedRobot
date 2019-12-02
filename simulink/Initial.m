
RPM = 0;         %Rev / Min

alpha = 30;          %Deg

BChar.Cla = 1;   %Slope of the Cl v Alpha linear approximation 
                    %for the airfoil being used (eg NACA 0012)
BChar.Cd = 1;     %Cd for the airfoil for given Alpha
BChar.Nb = 1;       %Number of blades
BChar.c = 0.08;    %Blade Chord Length (Note can't accept variable chord)
BChar.Rmax = 0.2;   %Max Radius (m)
BChar.Rmin = 0.01;  %Root cutout length (Accounts for housing interupting
                    %airflow at root)
                    
n = 2;            %Number of radial stations to calculate

[out1,out2] = BEMTsingle(alpha, RPM, BChar, n)
out1
%out2
