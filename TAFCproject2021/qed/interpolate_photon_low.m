%-------------------------------------------------------------------------------
%  Find chi for low photons  eta < 0.01 ; Marija
%-------------------------------------------------------------------------------
function [chi] = interpolate_photon_low(eta, ratio)

p1_array = [ 0.000263811201959,     0.000553145340450,     0.000095369097674,     -0.000411875299010,     -0.001853132487289,  ...
    -0.034968036509529,     -0.048613728699486,     -0.027108238057496,     -0.007689397564446,     -0.002662591941810,  ...
    -0.471389071640141,     -0.366882206365127,     -0.112218758479580,     -0.017612011812319,     -0.003089636664014,  ...
    -0.000026474752394,     -0.000220282443738,     -0.000682523450780,     0.000433200917317,     -0.001573728870609,   ...
    -0.000005530223021,     -0.000071572557034,     -0.000306087538604,     0.000833871524539,     -0.001422824476591,   ...
    -0.000000140633974,     -0.000004012965775,     0.000014133707467,     0.001516930650954,     -0.000868627294210 ];
p2_array = [ 0.001759803729180,     0.002219230270537,     -0.003710995832019,     -0.007443369492250,     -0.025954464715172,   ...
    -0.481290048732986,     -0.671043559591993,     -0.375418889566618,     -0.106850616220667,     -0.037061410137816,   ...
    -7.275620737513042,     -5.506669738559794,     -1.643778940803329,     -0.252565594681990,     -0.043269949679557,   ...
    -0.000356276154489,     -0.003002703096092,     -0.009471182536737,     0.006046013708690,     -0.021917477241251,    ...
    -0.000082444971341,     -0.001046577943293,     -0.004492265877667,     0.011365874881429,     -0.019913641794140,   ...
    -0.000002547037527,     -0.000068162145320,     0.000053060484331,     0.020896093063842,     -0.012292213053433 ];
p3_array = [ 0.006986723640187,     0.009997910101316,     -0.014612961168528,     -0.034208021629582,     -0.135324497875304,   ...
    -2.503213435436670,     -3.500587251076293,     -1.964980868889572,     -0.561163702345697,     -0.194881296072327,  ...
    -42.093636131306923,     -31.107872464612527,     -9.085101831836093,     -1.368415148610610,     -0.228959888084581,  ...
    -0.001824697740166,     -0.015564332548708,     -0.049964958271390,     0.031574604130121,     -0.115395098457585,    ...
    -0.000456844928734,     -0.005715449721112,     -0.024696987365157,     0.058773043081745,     -0.105091818810049,    ...
    -0.000016740343327,     -0.000428850551023,     -0.000563308599435,     0.108577421492149,     -0.065824907236507 ];
p4_array = [ 0.005335131360358,     -0.022501648387618,     -0.110725979737021,     -0.136216820923786,     1.666869897886332,   ...
    -5.855109866397301,     -8.212834724838951,     -4.625499915752781,     -1.325329840321259,     1.539440714165051,   ...
    -108.585158882810205,     -78.638367024033329,     -22.526356253671199,     -3.331216319051826,     1.455465999810217,  ...
    -0.004237355165717,     -0.036525658976146,     -0.119237916752667,     0.073381346509617,     1.726770340767212,   ...
    -0.001122548215616,     -0.013891027040214,     -0.060598648484234,     0.137146528360352,     1.751177760085899,  ...
    -0.000048009457794,     -0.001192614380272,     -0.003528934286669,     0.253157886207936,     1.841329935045384 ];
p5_array = [ 0.012440512264447,     0.058208450503953,     0.135433713807426,     3.159377819076660,     -0.576999863431748,  ...
    5.328981984837045,     8.165820883577529,     5.169630202193487,     4.713848412633423,     -0.375348777377691,  ...
    109.908794069604866,     75.340162347559087,     21.372576915740748,     6.468554084565493,     -0.302616117826916,  ...
    -0.034560041731897,     -0.326548751981733,     -1.219198942872906,     -2.148249186408203,     -1.782748307370904,  ...
    -0.009402387169714,     -0.115966993497007,     -0.573762433354587,     -1.290381599174277,     -1.365467788910251,  ...
    -0.000418029920662,     -0.010630206487499,     -0.103007290874155,     -0.336591670303331,     -0.624414723674595 ];

lt_eta = log10(eta);

% Here we look for the right section of interpolation coefficients to use;
% Please note that second half of the coefficients (above n=16) is done for log10(1-ratio)
% due to the numerical precision when ratio => 1.0

if ( ratio < 0.4 )
    n=1;
    ltr = log10(ratio);
elseif ( ratio < 0.7 )
    n = 6;
    ltr = log10(ratio);
elseif ( ratio < 0.88 )
    n = 11;
    ltr = log10(ratio);
elseif (ratio < 0.975)
    n = 16;
    ltr = log10(1.0-ratio);
elseif (ratio < 0.9993)
    n = 21;
    ltr = log10(1.0-ratio);
else
    n = 26;
    ltr = log10(1.0-ratio);
end

pc1 = p1_array(n) * ( lt_eta^4.0 ) + p2_array(n) * ( lt_eta^3.0 ) + p3_array(n) * ( lt_eta^2.0 ) + p4_array(n) * lt_eta + p5_array(n);
pc2 = p1_array(n+1) * ( lt_eta^4.0 ) + p2_array(n+1) * ( lt_eta^3.0 ) + p3_array(n+1) * ( lt_eta^2.0 ) + p4_array(n+1) * lt_eta + p5_array(n+1);
pc3 = p1_array(n+2) * ( lt_eta^4.0 ) + p2_array(n+2) * ( lt_eta^3.0 ) + p3_array(n+2) * ( lt_eta^2.0 ) + p4_array(n+2) * lt_eta + p5_array(n+2);
pc4 = p1_array(n+3) * ( lt_eta^4.0 ) + p2_array(n+3) * ( lt_eta^3.0 ) + p3_array(n+3) * ( lt_eta^2.0 ) + p4_array(n+3) * lt_eta + p5_array(n+3);
pc5 = p1_array(n+4) * ( lt_eta^4.0 ) + p2_array(n+4) * ( lt_eta^3.0 ) + p3_array(n+4) * ( lt_eta^2.0 ) + p4_array(n+4) * lt_eta + p5_array(n+4);
pc = pc1 * ( ltr^4.0 ) + pc2 * ( ltr^3.0 ) + pc3 * ( ltr^2.0 ) + pc4 * ltr + pc5;
chi = 10^pc;