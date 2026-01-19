
% x=[delta1 delta2 w1 w2 absEqp1 absEqp2 EF1 EF2] 
% y=[theta1 theta2 U1 U2]
%xdot=f(x,y)
%   0=g(x,y)

nx_avr=  ;  %number of state variables with AVR
ny=   ;     %number of algebraic variables
fx=zeros(nx_avr,nx_avr);
fy=zeros(nx_avr,ny);
gx=zeros(ny,nx_avr);

fx(1,3)=1;
fx(2,4)=1;
fx(3,1)=-bdpt1*absEqp1*absU1*cos(delta1-theta1)/M1;
fx(3,3)=-D1/M1;
fx(3,5)=-bdpt1*absU1*sin(delta1-theta1)/M1;
fx(4,2)=-bdpt2*absEqp2*absU2*cos(delta2-theta2)/M2;
fx(4,4)=-D2/M2;
fx(4,6)=-bdpt2*absU2*sin(delta2-theta2)/M2;
% Write the other non-zero elements of the submatrix fx (see appendix B and the lecture slides)


fy(3,1)=bdpt1*absEqp1*absU1*cos(delta1-theta1)/M1;
fy(3,3)=-bdpt1*absEqp1*sin(delta1-theta1)/M1;
% Write the other non-zero elements of the submatrix fy (see appendix B and the lecture slides)

gx(1,1)=-bdpt1*absEqp1*absU1*cos(theta1-delta1);
gx(1,5)=bdpt1*absU1*sin(theta1-delta1);
% Write the other non-zero elements of the submatrix gx (see appendix B and the lecture slides)

gy(1,1)=bdpt1*absEqp1*absU1*cos(theta1-delta1)+b12*absU1*absU2*cos(theta1-theta2);
gy(1,2)=-b12*absU1*absU2*cos(theta1-theta2);
gy(1,3)=bdpt1*absEqp1*sin(theta1-delta1)+b12*absU2*sin(theta1-theta2)+2*PL01/absU1;
gy(1,4)=b12*absU1*sin(theta1-theta2);
% Write the other non-zero elements of the submatrix gy (see appendix B and the lecture slides)

AA=    ; % the state matrix A