function [thetax,thetay] = evolve(u0,a0,tsig,tnot,dt,tdim)

% charge
q = -1;

% initial position
r = [0,0,0];
u0 = [u0,0,0];

% push velocity half step backwards
[~,un12] = pusher(r,u0,0,-dt/2,q,a0,tsig,tnot);

% initial momentum n-1/2
u = un12;

countphotons = 1;
nphotons = 5;
thetax = zeros(nphotons,1)-1;
thetay = zeros(nphotons,1)-1;

% time evolve
t=0;
for n=1:tdim
    
    % Boris
    [r,u] = pusher(r,u,t,dt,q,a0,tsig,tnot);
    rlst(n,:) = r;
    ulst(n,:) = u;
    
    %% QED
    % Values from the NIST reference on Constants, Units and Uncertainty
    % http://physics.nist.gov/cuu/Constants/index.html
    omega_p0 = 1.88e15; % laser frequency rad s-1
    hbar  = 1.054571800e-34; % Planck constant over 2 pi
    cl    = 299792458.0e0; % speed of light in vacuum [m/s]
    me    = 9.10938356e-31; % electron rest mass [kg]
    alpha = 7.2973525664e-3; % fine-structure constant
    %e = 1.602176634e-19; % electric charge
    % Schwinger field
    % me^2 * cl^3 / (hbar*e) = 1.3233e+18
    % get fields
    [Evec,Bvec] = getFields(r(1),t,a0,tsig,tnot);
    Ex=Evec(1);Ey=Evec(2);Ez=Evec(3);
    Bx=Bvec(1);By=Bvec(2);Bz=Bvec(3);
    ux=u(1);uy=u(2);uz=u(3);
    % calculate the quantum coefficient
    norm_schw = hbar*omega_p0/(me*cl^2);
    coef_QED = sqrt(3.e0)*alpha/(2.e0*pi*norm_schw);
    % compute lorentz factor
    p2 = norm(u)^2;
    gl = sqrt(1.0e0+p2);
    % compute eta parameter terms
    % (p · E)^2
    pdotE2 = dot(u,Evec)^2;
    % \gamma E + p x B
    gamE_plus_pcrossB2 = (-gl*Ex-Bz*uy+By*uz)^2 ...
                       + (-gl*Ey+Bz*ux-Bx*uz)^2 ...
                       + (-gl*Ez-By*ux+Bx*uy)^2 ;
    % compute the quantum parameter eta
    eta = sqrt(abs(gamE_plus_pcrossB2-pdotE2))*norm_schw;
    % emit photon?
    Wrad = 0;
    if ( (eta > 1.0e-4) && (eta < 5.0e4) )
        if (eta > 300.e0)
            Wrad = (1.46e0*alpha/norm_schw)*(eta^(2/3))/gl;
        else
            interp = interp_spec_qed(eta);
            Wrad = interp*coef_QED*eta/gl;
        end
        varand = rand;
        % emit photon?
        if ( varand < Wrad * dt && countphotons < nphotons)
            % emit photon
            
            % sample from 2D distribution
            [W3smpl_w,theta,W3smpl_W3] = getW3smpl(eta,gl);
            phi = 2*pi*rand;
            
            % to impose collinear emission, set theta=0
            %theta=0;
            
            thetax(countphotons) = atan(uz/ux) + theta*cos(phi);
            thetay(countphotons) = atan(uy/ux) + theta*sin(phi);
            countphotons = countphotons+1;
            
            
        end
    end
    
    t = t+dt;
end