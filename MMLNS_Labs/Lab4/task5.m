P = [2 1 -2 -1; 2 -2 2 1];
T = [0 1 0 1];
net = newlin([-2 2; -2 2], 1);
net.trainParam.goal = 0.1;
[net, tr] = train(net, P, T);
net.IW{1, 1}, net.b{1};
A = sim(net, P);
err = T-A % –network errors are very significant.