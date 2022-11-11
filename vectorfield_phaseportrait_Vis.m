close all
clear all
clc

%% System Dynamics
%=====simple example 1
% X1dot = X2;
% X2dot = -10*sin(X1)-X2;

%=====Van der Pol eq
syms epsilon
epsilon = 0.2;
%X1dot = X2;
%X2dot = -X1+ epsilon*(1-X1*X1)*X2;

% make a function based on the system dynamics above
%f = @(t,X) [X(2); -10*sin(X(1))-X(2)];
f = @(t,X) [X(2); -X(1)+ epsilon*(1-X(1)*X(1))*X(2)];

%% Grid setup
Xaxis = linspace(-5,5,50);
Yaxis = linspace(-5,5,50);
[X1,X2] = meshgrid(Xaxis,Yaxis);

X1dot = zeros(size(X1));
X2dot = zeros(size(X2));

% we can use a single loop over each element to compute the derivatives at each point (X1, X2)
t=0; % we want the derivatives at each point at t=0, i.e. the starting time
for i = 1:numel(X1)
    Xdot = f(t,[X1(i); X2(i)]);
    X1dot(i) = Xdot(1);
    X2dot(i) = Xdot(2);
end


%% Plot
%%vector field
q=quiver(X1,X2,X1dot,X2dot)
hold on

%%Phase portrait with different X2inits
for X2init = [0 1.0 2.0 3.0 4.0 5.0]
    [ts,ys] = ode45(f,[0,50],[0;X2init]);
    plot(ys(:,1),ys(:,2))
    plot(ys(1,1),ys(1,2),'bo') % starting point
    plot(ys(end,1),ys(end,2),'ks') % ending point
end
hold on

%%Phase portrait with different X1inits
% for X1init = [0 1.0 2.0 3.0 4.0 5.0]
%     [ts,ys] = ode45(f,[0,50],[X1init;0]);
%     plot(ys(:,1),ys(:,2))
%     plot(ys(1,1),ys(1,2),'bo') % starting point
%     plot(ys(end,1),ys(end,2),'ks') % ending point
% end
% hold on