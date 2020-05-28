P = [1 -1.2];
T = [0.5 1];
net = newlind(P,T);
Y = sim(net, P) % – 0.5 ? 1; range of weights;
net.IW{1,1}; % – -0.22727;
net.b{1}; % – 0.72727;
w_rangle = -1: 0.1: 0; % – range of weights;
b_rangle = 0.5: 0.1: 1; % – range of biases;
ES = errsurf(P, T, w_rangle, b_rangle, 'purelin');
contour(w_rangle, b_rangle, ES, 20); % – 20 levels;
hold on
plot(-2.2727e-001, 7.2727e-001, 'x') % – point
hold off % – the sign 'x' are marked
% - the optimal values of weights and biases