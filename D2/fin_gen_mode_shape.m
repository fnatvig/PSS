
%%%%%%%%%%%%%%%%%
%Right eigenvector
[eig_vec_r , eig_value]=eig(AA);
%Left eigenvector
eig_vec_l=       ;

%Participation matrix 
PART_mat=eig_vec_r.*(eig_vec_l.');

absPART=abs(PART_mat); % absolute values
which_gen=input('Which gen?');

%% The shape of each mode
abs_shape=abs(PART_mat(1:ng,which_mode)); % only rotor angles
ang_shape=angle(eig_vec_r(1:ng,which_mode));
[max_shape]=max(abs_shape);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Normalization and compass plot
abs_shape_norm=abs_shape/max_shape;
Mode_shape=abs_shape_norm.*exp(j.*ang_shape);
[mm nn]=sort(abs_shape_norm,'descend');

compass(real(Mode_shape(nn(1))),imag(Mode_shape(nn(1))),'k'),hold on
compass(real(Mode_shape(1)),imag(Mode_shape(1)),'b'),hold on
compass(real(Mode_shape(2)),imag(Mode_shape(2)),'r'),hold off
