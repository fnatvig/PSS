
%%%%%%%%%%%%%%% Tune PSS %%%%%%%%%%%%%%%%%%%%
residu=    ; % find the residue of the selected mode

s=EIG_(which_mode);
sig=real(s);
wp=imag(s);
ang_R=angle(residu);
ang_phi=pi*sign(ang_R)-ang_R;

if abs(ang_phi) > pi/3 & abs(ang_phi) < 2*pi/3
    ang_phi=ang_phi/2;
    sgnK=1;
    nf= ;
elseif abs(ang_phi) >= 2*pi/3
    ang_phi=-ang_R;
    sgnK=-1;
    nf= ;
else
    sgnK=1;
    nf= ;
end

alph=(1+sin(ang_phi))/(1-sin(ang_phi));
TT=1/(wp*sqrt(alph));
T1= ;
T2= ;
T3= ;
T4= ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Including PSS as feedback control
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[NUM,DEN] = ss2tf(A_,B_,C_,0);
sys_open=tf(NUM,DEN);

if nf==1,
    zz=[0 -1/T1];
    pp=[-1/Tw -1/T2];
elseif nf==2, 
    zz=[0 -1/T1 -1/T1];
    pp=[-1/Tw -1/T2 -1/T2];
end,


K_PSS=sgnK*[K_PSS_min:step_kpss:K_PSS_max];
%clear Min_damp
for ii=1:length(K_PSS),
    gain=K_PSS(ii);
    sys_pss_gain=zpk(zz,pp,gain*((T1/T2)^nf));
    sys_fb=feedback(sys_open,sys_pss_gain,1);
    EIG_fb=eig(sys_fb);
    nn_fbf=find((imag(EIG_fb)/2/pi)>0.1);
    damp_ratio_fb=-real(EIG_fb(nn_fbf))./abs(EIG_fb(nn_fbf));
    Min_damp(ii)=min(damp_ratio_fb);
end,
    
[max_damp,m_Kpss]=max(Min_damp);
gain=K_PSS(m_Kpss);

sys_pss_gain=zpk(zz,pp,gain*((T1/T2)^nf));
sys_pss=feedback(ss(A_,B_,C_,0),sys_pss_gain,1);
KPSS=gain;
