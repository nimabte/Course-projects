% 1. Create a radial basis network with zero error:
P = 0:3;
T = [0.0 2.0 4.1 5.9];
net = newrbe(P, T);
% 2. Perform structural diagram of the constructed network
gensim(net);
% 3. Review the parameters of the computational network model:net
net.layers{1}.size 
net.layers{2}.size 
net.layers{1}.initFcn
net.layers{1}.netInputFcn
net.layers{1}.transferFcn
net.layers{2}.initFcn
net.layers{2}. transferFcn
net.layers{2}.netInputFcn
net.inputWeights{1, 1}.initFcn
net.inputWeights{1, 1}.weightFcn
% net.inputWeights{2, 1}.initFcn
% net.inputWeights{2, 1}.weightFcn
net.inputWeights{1, 1}.learnFcn
net.IW{1, 1}, net.b{1}
net.LW{2, 1}, net.b{2}
net.inputWeights{1, 1}, net.biases{1}
net.inputWeights{2, 1}, net.biases{2}

% 4. Simulate the network and plot:
plot(P, T, '*r', 'MarkerSize', 2, 'LineWidth', 2);
pause;
hold on
V=sim(net, P);
plot(P, V, '*b', 'MarkerSize', 9, 'LineWidth', 2);
pause;
P1=0.5:2.5;
Y=sim(net, P1);
plot(P1, Y, '*k', 'MarkerSize', 10, 'LineWidth', 2);