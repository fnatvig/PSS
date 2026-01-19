
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% make Y_rnm

yL1=(PL01-j*QL01)/(absU1^2);
yL2=(PL02-j*QL02)/(absU2^2);
YA(1,1)=1/(j*xdpt1);
YA(2,2)=1/(j*xdpt2);
YB=-YA;
YC=YB;
YD=[y12+YA(1,1)+yL1        -y12      ;
          -y12       y12+YA(2,2)+yL2];

Y_RNM=  ;

G=real(YRNM);
B=imag(YRNM);
 
Iq1=    ;
Iq2=    ;
% 
Id1=    ;
Id2=    ;
% 
Pe1=    ; % generator electric power based on Iq1
Pe2=    ; % generator electric power based on Iq2

Check=[Pg1 Pg2; Pe1 Pe2], % pg1 must be equal to Pe1 and Pg2 equal to Pe2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%%Y_RNM During fault
%%%%%%%%%%%%%%%%%%%%%
fault_at_bus=1; 
YD_F=YD;
YD_F(fault_at_bus,fault_at_bus)=YD(fault_at_bus,fault_at_bus)+1E12*(1+j);
Y_RNM_F=   ;