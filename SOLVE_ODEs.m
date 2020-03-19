clear all; 
close all;

% Model parameters
G_dc=0.001;     R=0.001;        G=0.005;
C_dc=0.008;     L=200*10^-6;    C=300*10^-6;
% Control parameters and reference values
eta=0.01;
kappa=500; % choose in combination with the i_dc_r such that Vdc_ss=Vdc_r
gamma=10000;

omega_s=2*pi*50;    %[Rad/Sec]

Vll_rms=1000;   %LL-rms
V_m=sqrt(2/3)*Vll_rms;  % peak per phase
Vdc_r=2.44*10^3;
bar_mu=2*V_m/Vdc_r;
mu=bar_mu/2;
i_dc_r=5; % choose in combination with the kappa such that Vdc_ss=Vdc_r
theta_r=0;      %[Rad]

% Solving the closed-loop ODEs
for i=1:10 % setting the number of initial conditions and iterations

x_ini=[4*pi*(0.5-rand(1)) ; (10000)*rand(7,1)];     %Initial condition

% SCIB1 includes the closed-loop dynamics with the continous feedback u
% Change ''SCIB1'' to ''SCIB2'' for considering the switching feedback u_sw
[t,y] = ode23(@(t,y)SCIB2(t , y , omega_s , theta_r , gamma , eta, Vdc_r , i_dc_r , kappa , G_dc , mu , C_dc , R , L , G , C , V_m),[0,1],x_ini);

theta=y(:,1); theta_ss=theta(end);
Vdc=y(:,2); Vdc_ss=Vdc(end);
id=y(:,3); id_ss=id(end);
iq=y(:,4); iq_ss=iq(end);
vd=y(:,5); vd_ss=vd(end);
vq=y(:,6); vq_ss=vq(end);
igd=y(:,7); igd_ss=igd(end);
igq=y(:,8); igq_ss=igq(end);

figure(1)
subplot(4,2,1)
plot(t,theta) 
title('relative angle')
xlim([0,0.002])
ylim([-8,8])
grid on
hold on

subplot(4,2,2)
plot(t,Vdc) 
title('dc voltage')
grid on
hold on

subplot(4,2,3)
plot(t,id)
title('d-axis filter current')
grid on
hold on

subplot(4,2,4)
plot(t,iq)
title('q-axis filter current')
grid on
hold on

subplot(4,2,5)
plot(t,vd)
title('d-axis filter voltage')
grid on
hold on

subplot(4,2,6)
plot(t,vq)
title('q-axis filter voltage')
grid on
hold on

subplot(4,2,7)
plot(t,igd)
title('d-axis grid current')
grid on
hold on

subplot(4,2,8)
plot(t,igq)
title('q-axis filter current')
grid on
hold on
end