%-------------------------------------------------------------------------------
%  function estimates the integral based on improved polynomial expansion; Marija
%             The output is normalized to the integral from 0 to eta/2
%-------------------------------------------------------------------------------
function [int] = integral_alpha_QED(eta, chi)

total = interp_spec_qed(eta);
% this is the chi for which y = 1
chi_y1 = 3.0 * eta * eta / ( 2.0*(1 + 3.0 * eta) );
if ( chi > chi_y1 )
    int = 1.0;
else
    delta = poly_sync_QED(eta, chi_y1) - total;
    int = ( poly_sync_QED(eta, chi) - (chi * delta / chi_y1) ) / total;
end