function [XDOT]=f_dyn_RNM(T,X,FLAG,PAR1,PAR_G,PAR_avr,PAR_pss,Y_RNM);

XDOT=zeros(length(X),1);

ng=PAR1(1);
Ef_max=PAR1(2);
Ef_min=PAR1(3);

Pm1=PAR_G(1); Pm2=PAR_G(2);
xdpt1=PAR_G(3); xdpt2=PAR_G(4);
xdt1=PAR_G(5); xdt2=PAR_G(6);
M1=PAR_G(7); M2=PAR_G(8);
D1=PAR_G(9); D2=PAR_G(10);
Tdop1=PAR_G(11); Tdop2=PAR_G(12);
Te1=PAR_avr(1); Te2=PAR_avr(2);
KA1=PAR_avr(3); KA2=PAR_avr(4);
Uref1=PAR_avr(5); Uref2=PAR_avr(6);

delta1=X(1); delta2=X(2);
w1=X(3); w2=X(4);
absEqp1=X(5); absEqp2=X(6);
EF1=X(7); EF2=X(8);

G=real(Y_RNM);
B=imag(Y_RNM);
xq1=  ; xq2=  ;

Iq1=G(1,1)*absEqp1 + absEqp2*(G(1,2)*cos(delta1-delta2) + B(1,2)*sin(delta1-delta2));
Iq2=G(2,2)*absEqp2 + absEqp1*(G(2,1)*cos(delta2-delta1) + B(2,1)*sin(delta2-delta1));
Id1=   ;
Id2=   ;

Ud1=  ; 
Ud2=  ;
Uq1=  ; 
Uq2=  ;

absU1=   ; 
absU2=   ; 

Pe1=  ;
Pe2=  ;


f_dyn_RNM=[ w1
            w2
     (Pm1-Pe1-D1*w1)/M1
     (Pm2-Pe2-D2*w2)/M2
     (EF1-absEqp1+(xdt1-xdpt1)*Id1)/Tdop1
     (EF2-absEqp2+(xdt2-xdpt2)*Id2)/Tdop2
     dynamic of AVR 1
     dynamic of AVR 2];

 
 over_max =find(([EF1;EF2] >= Ef_max) & (f_dyn_RNM(3*ng+1:4*ng)>0));
 under_min=find(([EF1;EF2] <= Ef_min) & (f_dyn_RNM(3*ng+1:4*ng)<0));
 
 if any(over_max),
    f_dyn_RNM(3*ng+over_max)=0;
 end,
 
 if any(under_min),
    f_dyn_RNM(3*ng+under_min)=0;
 end,
      
XDOT=[f_dyn_RNM];      



