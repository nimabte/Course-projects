% Hopfield network with two stable points in three-dimensional space:
T=[-1 -1 1; 1 -1 1]'; % – target nodes;
net=newhop(T); % – the creation of a network;
net, gensim(net); % – the parameters and network structure;
Ai=T; % – the initial conditions for the delay lines;
Y=sim(net,2,[], Ai); % – network sustainable;
Y
pause;
Ai ={[-0.9; -0.8; 0.7]};
Y=sim(net,{1 5},{}, Ai);
Y{1}    % – the network provided the transition to steady stste [-1 -1 1]’