% 1. Create function description:
P = -3:0.1:3;
a1 = radbas(P);
a2 = radbas(P-1.5);
a3 = radbas(P+2);
a = a1 + a2 + 0.5*a3;
plot(P, a1, P, a2, P, 0.5*a3, P, a);
pause;
% 2. Create a network and determine the number of neurons in the layers:
net = newrb(P, a, 12);
net.layers{1}.size
net.layers{2}.size
gensim(net);

% 3. Simulate the network and plot the resulting model:
V = sim(net, P);
plot(P, a, 'r', P, V, 'b'); grid;