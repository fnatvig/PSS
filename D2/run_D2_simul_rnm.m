
%%%%%%%%%%%%%% Non-linear system simulation %%%%%%%%%%%%%%%%%%
Ef_max=5;
Ef_min=-5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PAR1=[ng Ef_max Ef_min];
PAR_G=[Pm1;Pm2;xdpt1;xdpt2;xdt1;xdt2;M1;M2;D1;D2;Tdop1;Tdop2];
PAR_avr=[Te1;Te2;KA1;KA2;Uref1;Uref2];
PAR_pss=[    ];
nx=nx_avr; % only with AVR, i.e. no PSS. You need to update nx when PSS is used
options=odeset('relTol',tole,'AbsTol',tole*ones(1,nx));

t0=0; tf=0.5; tc=tf+0.10; tfin=5;

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Pre-fault ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
X0=[delta1 delta2 0 0 absEqp1 absEqp2 EF1 EF2]';
TSPAN=[t0 tf];
[TS,XS]=ode45('f_dyn_rnm',TSPAN,X0,options,PAR1,PAR_G,PAR_avr,PAR_pss,Y_RNM);
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Fault~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
X0=XS(end,:)';
TSPAN=[tf tc];
[TF,XF]=ode45('f_dyn_rnm',TSPAN,X0,options,PAR1,PAR_G,PAR_avr,PAR_pss,Y_RNM_F);
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Post-fault ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
X0=XF(end,:)';
TSPAN=[tc tfin];
[TC,XC]=ode45('f_dyn_rnm',TSPAN,X0,options,PAR1,PAR_G,PAR_avr,PAR_pss,Y_RNM);
%%%%%%%%%%%%%%%%%%%%%%%% Results %%%%%%%%%%%%%%%%%%%%%%%
TIME=[TS;TF;TC];
X_ALL=[XS;XF;XC];
DELTA_ALL=X_ALL(:,1:ng);
OMEGA_ALL=X_ALL(:,ng+1:2*ng);
EQP_ALL=X_ALL(:,2*ng+1:3*ng);
EF_ALL=X_ALL(:,3*ng+1:4*ng);

%% Each delta must be defined in COI reference frame.


