% 1. Let's form the training set and calculate the maximum value of the learning parameter maxlr:
P = [1 -1.2];
T = [0.5 1];
maxlr = 0.40*maxlinlr(P,'bias')
% pause;
% 2. Let’s create linear network:
net = newlin([-2 2], 1, [0], maxlr);
gensim(net);
% pause;
% 3. Let’s calculate the function of a quality criterion:
w_rangle = -1: 0.2: 1; b_rangle = -1: 0.2: 1;
ES = errsurf(P, T, w_rangle, b_rangle, 'purelin');
% pause;
% 4. Let’s construct the surface of the quality criterion function
surfc(w_rangle, b_rangle, ES);
pause;
% 5. Let’s calculate the trajectory of the study:
X = zeros(1, 50); Y = zeros(1, 50);
net.IW{1,1} = 1; net.b{1} = -1; % – initial value;
X(1) = net.IW{1}; Y(1) = net.b{1};
net.trainParam.goal = 0.001;
net.trainParam.epochs = 1;
% pause;
% 6. Let’s calculate the weights and biases:
for I=2:50
[net, tr] = train(net, P, T);
X(I) = net.IW{1, 1};
Y(I) = net.b{1};
end
% 7. Let’s build line-level and trajectory of learning:
clc; % clear screen
contour(w_rangle, b_rangle, ES, 20); % 20 lines
hold on
plot(X,Y,'- *'); % – build of trajectory
hold off
% pause;
% 8. Let’s estimate the values of configuration options for two values of the goal goal:
net.IW{1, 1} = 1; net.b{1} = -1;
net.trainParam.epochs = 50;
net.trainParam.goal = 0.001; % – the first value;
[net, tr] = train(net, P, T); net.IW{1, 1}, net.b{1} % - [-0.22893] [0.70519];
pause;
net.trainParam.goal = 0.00001; % – the second value
[net, tr] = train(net, P, T);
net.IW{1, 1}, net.b{1}; % – [-0.22785] [0.72495]
