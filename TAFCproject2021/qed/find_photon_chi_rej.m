function [chi] = find_photon_chi(eta)

a = 0.921;
b = 0.307;
total = interp_spec_qed(eta);
varand = rand;

% inverse from the non-improved polynomial expansion
first_guess =0.5*(eta^2) * ( varand * total /( 0.764540211031963 * (a + b) *6.0 ))^3;
int = integral_alpha_QED(eta, first_guess);
delta_y = varand - int;

% this is the chi for which y = 1
chi_y1 = 3.0 * eta * eta / ( 2.0*(1 + 3.0 * eta) );

% if chi << chi_y1, then we can use this expansion; otherwise, we use interpolation
if (first_guess < 0.001 * chi_y1)
    d = 2.0 * first_guess / eta;
    derivative = 0.764540211031963*(a+b)* (eta^(-4.0/3.0))* 2.0*(2.0* (d^(-2.0/3.0))-(4.0/3.0)*(d^(1.0/3.0))) /total;
    % this derivative is calculated by = (2/pi) * 3^(1/6) * (a+b) * 2 * eta^(-4/3)* (2 d^(-2/3)- (4/3)d^(1/3) )
    chi = first_guess + delta_y / derivative;
else
    if (eta > 3.3)
        chi_new = interpolate_photon_high(eta, varand);
    elseif (eta > 0.01)
        chi_new = interpolate_photon_midrange(eta, varand);
    else
        chi_new = interpolate_photon_low(eta, varand);
    end
    chi = chi_new;
end
