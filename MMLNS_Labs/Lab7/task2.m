%create a Hopfield network with four stable points in two-dimensional space
T = [1 -1; -1 1; 1 1; -1 -1]';
plot(T(1, : ), T(2, : ), '*r'); % – the equilibrium points;
axis([-1.1 1.1 -1.1 1.1]);
title('Equilibrium points of the designed network');
xlabel('a(1)'), ylabel('a(2)');
net =newhop(T);
W=net.LW{1,1};
b=net.b{1,1}; pause;
Ai = T;
Y=sim(net, 4, [], Ai);
plot(T(1,:), T(2,:), '*r'), hold on
axis([-1.1 1.1 -1.1 1.1]);
xlabel('a(1)'); ylabel('a(2)'); pause;
new=newhop(T);
[Y, Pf, Af]=sim(net, 4, [], T);
for i=1:25
    a={rands(2,1)};
    [Y, Pf, Af]=sim(net, {1,20}, {}, a);
    record=[cell2mat(a), cell2mat(Y)];
    start=cell2mat(a);
    plot(start(1,1), start(2,1), 'kx', record(1,:), record(2,:)); pause;
end