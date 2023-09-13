%-------------------------------------------------------------------------------
% generates a random number distributed according to the QED spectrum
%-------------------------------------------------------------------------------
function [chi] = syncQED(eta)

chi0 = 0.214d0 * eta^2 / (1 + eta^4) + (0.5d0*eta - 1.d-6) / (1 / (eta^3) + 1);
chimax = 0.5d0*eta - 1.d-6;
logchimin = log10(chi0)-12.d0;
logchimax = log10(chimax);
x = 1.0d0;
P = 0.0d0;
	
while (x > P)
	logchi = logchimin + (logchimax - logchimin)*rand();
    chi = exp(log(10.d0)*logchi);
	x = rand()*peak_QED(eta);
	P = F_QED(eta,chi);  
end