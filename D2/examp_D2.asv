clear all
format short,
%%%%%%%%%%%%%%%%%%%%%%
tole=1e-6;
maxiter=10;
deg=180/pi; 
rad=1/deg ;
fs=50;
ws=2*pi*fs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% System data (see the single-line diagram of the system in fig_examp_D2.jpg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slack bus (bus 1)
absU1=1; theta1=0;

% PV buses (bus 2 and 3) voltage magnitudes are specified
absU2=1; theta2=0;
absU3=1; theta3=0;

% PQ buses (bus 4 and 5): U and angle unknown, start with flat start
absU4=1; theta4=0;
absU5=1; theta5=0;

Z14=j*0.1; y14=1/Z14; b14=abs(y14);
Z24=j*0.2; y24=1/Z24; b24=abs(y24);
Z35=j*0.5; y35=1/Z35; b35=abs(y35);
Z45=j*0.5; y45=1/Z45; b45=abs(y45);
PL01=0;QL01=0;
PL02=0;QL02=0;
PL03=0;QL03=0;
PL04=0.7;QL04=0.08;
PL05=0.2;QL05=0.02;

ng=2;   % number of generators
nbus=5; 

Ybus=zeros(nbus,nbus);
Ybus(1,1)=y14;                 Ybus(1,4)=-y14;  Ybus(4,1)=-y14;
Ybus(2,2)=y24;                 Ybus(2,4)=-y24;  Ybus(4,2)=-y24;
Ybus(3,3)=y35;                 Ybus(3,5)=-y35;  Ybus(5,3)=-y35;
Ybus(4,4)=y14+y24+y45;         Ybus(4,5)=-y45;  Ybus(5,4)=-y45;
Ybus(5,5)=y35+y45;

G = real(Ybus);
B = imag(Ybus);
Pg2_spec = 0.2;
Pg3_spec = 0.5;


%%%%%%%%%%%%
% Run LFC
%%%%%%%%%%%%

% Run powerflow.py to obtain the following values:
% Bus 1: p=-0.19999999999999798 q=-0.10672904262343863 vm_pu=1.00000000, va_deg=0.00000000
% Bus 2: p=-0.20000000000000004 q=-0.05639779567718506 vm_pu=1.00000000, va_deg=1.15859354
% Bus 3: p=-0.5 q=-0.13289189338684082 vm_pu=1.00000000, va_deg=22.85766429
% Bus 4: p=0.7 q=0.08 vm_pu=0.98952923, va_deg=-1.15812003
% Bus 5: p=0.19999999999999996 q=0.020000000000000004 vm_pu=0.96644875, va_deg=7.86597087

x = [
    0.200, 0.107, 1, 0;     % Bus 1: P, Q, Vm, Va
    0.2, 0.056, 1, 1.16;    % Bus 2: P, Q, Vm, Va
    0.5, 0.133, 1, 22.86;   % Bus 3: P, Q, Vm, Va
    0, 0, 0.990, -1.16;     % Bus 4: P=0, Q=0, Vm, Va <-- PQ-bus -> P and Q neglected
    0, 0, 0.967, 7.87       % Bus 5: P=0, Q=0, Vm, Va <-- PQ-bus -> P and Q neglected
    ]

theta2 = x(2,4);
theta3 = x(3,4);
theta4 = x(4,4);
theta5 = x(5,4);
absU2  = x(2,3);
absU3  = x(3,3);
absU4  = x(4,3);
absU5  = x(5,3);
theta2deg=theta2*deg;
theta3deg=theta3*deg;
theta4deg=theta4*deg;
theta5deg=theta5*deg;
U1=absU1*exp(j*theta1);
U2=absU2*exp(j*theta2);
U3=absU3*exp(j*theta3);
U4=absU4*exp(j*theta4);
U5=absU5*exp(j*theta5);
Pg1=x(1,1); Qg1=x(1,2); Sg1=Pg1+j*Qg1;
Pg2=x(2,1); Qg2=x(2,2); Sg2=Pg2+j*Qg2;
Pg3=x(3,1); Qg3=x(3,2); Sg3=Pg3+j*Qg3;

Pm1=Pg1;
Pm2=Pg2;
Pm3=Pg3;
%%%%%%%%%%%%%%%%%%
%% Generator data
%%%%%%%%%%%%%%%%%%
xt1=0.1; xdp1=0.1; xd1=0.8; H1=4; D1=0; Tdop1=6; Te1=0.01; KA1=100;
xt2=0.1; xdp2=0.1; xd2=0.7; H2=3; D2=0; Tdop2=6; Te2=0.01; KA2=100;
xt3=0.1; xdp3=0.1; xd3=0.6; H3=2; D3=0; Tdop3=6; Te3=0.01; KA3=100;

xdpt1=xt1+xdp1; xdt1=xt1+xd1; bdpt1=1/xdpt1;
xdpt2=xt2+xdp2; xdt2=xt2+xd2; bdpt2=1/xdpt2;
xdpt3=xt3+xdp3; xdt3=xt3+xd3; bdpt3=1/xdpt3;
M1=2*H1/ws;    M2=2*H2/ws;  M3=2*H3/ws;

%PSS
Tw=10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e.p calculations
% x0=[delta1 delta2 w1 w2 absEqp1 absEqp2 EF1 EF2] 
% y0=[theta1 theta2 U1 U2]
Ig1 = (U1-U4)/Z14;
Ig2 = (U2-U4)/Z24;
Ig3 = (U3-U5)/Z35;
Eqp1= Ig1*j(xd1+xt1)+U1; absEqp1=abs(Eqp1); delta1=angle(Eqp1);
Eqp2= Ig2*j(xd2+xt2)+U2; absEqp2=abs(Eqp2); delta2=angle(Eqp2);
Eqp3= Ig3*j(xd3+xt3)+U3; absEqp3=abs(Eqp3); delta3=angle(Eqp3);

EF1=Eqp1-(xd1-xdp1)*Ig1;
EF2=;
EF3=;

Uref1=U1;
Uref2=U2;
Uref3=U3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Modal Analysis
%% with SPM and mp=mq=2
run_lin_one_avr, % based on SPM, linearize the system with AVR and with mp=mq=2  

A_AVR=AA;
EIG_AVR=eig(A_AVR);
FREQ=            ; % in (Hz) of order nx_avr x 1
Damp_ratio=      ; % of order nx_avr x 1
EIG_AVR_FREQ_RATIO_AVR=[[1:nx_avr]' FREQ Damp_ratio];

which_mode=input('Which mode?');

find_gen_mode_shape % Find in which generator the PSS should be installed and plot mode shape

%%%%%%%%%%%%%%%%%%%%
% Find B and C
%%%%%%%%%%%%%%%%%%%%
B_AVR=    ;
C_AVR=    ;

A_=A_AVR;
B_=B_AVR;
C_=C_AVR;
EIG_=EIG_AVR;
K_PSS_min=0; %see the file tune_pss
K_PSS_max=2; %see the file tune_pss
step_kpss=0.01; %see the file tune_pss

tune_pss  %Tune PSS parameters

plot(K_PSS,Min_damp,'b',[gain gain],[ min(Min_damp) max_damp],'r-.',...
    [gain],[max_damp],'ro','LineWidth',1.5),
   if sgnK==1,
       axis([0 K_PSS(ii) min(Min_damp) max_damp+0.001]),
   else
       axis([K_PSS(ii) 0 min(Min_damp) max_damp+0.001]),
   end,

AA=sys_pss.a;
A_PSS1=AA;
EIG_PSS1=eig(A_PSS1);
nx_pss1=length(EIG_PSS1);
FREQ=            ; % in (Hz) of order nx_pss1 x 1
Damp_ratio=      ; % of order nx_pss1 x 1

EIG_PSS_FREQ_RATIO_PSS1=[[1:nx_pss1]' FREQ Damp_ratio];

%return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run simulation based on RNM for the system with PSS
% disturbance: A three-phase fault at bus 1

make_y_rnm % make Y_rnm matrix 


% to run run_D2_simul_rnm, you need to revise this file and also
% the file f_dyn_rnm to include PSS

run_D2_simul_rnm


