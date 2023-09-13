function [Wrad] = interp_spec_qed(eta)

eta_array = [1.0e-4, 1.0e-3, 1.0e-2, 1.0e-1, 0.5e0, 1.0e0, 2.0e0, 5.0e0, 1.0e1, 15.0e0, 20.0e0, ...
    30.0e0, 40.0e0, 60.0e0, 80.0e0, 100.0e0, 200.0e0, 300.0e0];
int_eval_array = [5.236e0, 5.231e0, 5.19e0, 4.87e0, 4.177e0, 3.75e0, 3.284e0, 2.659e0, 2.217e0, ...
    1.98e0, 1.82e0, 1.61e0, 1.48e0, 1.3e0, 1.19e0, 1.11e0, 0.89e0, 0.78e0];

if (eta <= 1.0e-4)
    Wrad = 5.236e0;
else
    loc = 17;
    for i=1:17
        if (eta <= eta_array(i+1) && eta >= eta_array(i))
            loc = i;
            break
        end
    end
    coef = (int_eval_array(loc+1)-int_eval_array(loc))/(eta_array(loc+1)-eta_array(loc));
    Wrad = int_eval_array(loc) + coef*(eta-eta_array(loc));
end