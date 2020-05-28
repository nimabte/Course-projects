% 1. Let’s create a linear network with a given architecture parameter speed settings 0.01:
net = newlin([-1 1], 1, [0 1 2], 0.01);
gensim(net);
pause;
% 2. Let’s form two training sequences:
P1 = {0 -1 1 1 0 -1 1 0 0 1};
T1 = {0 -1 0 2 1 -1 0 1 0 1};
P2 = {1 0 -1 -1 1 1 1 0 -1};
T2 = {2 1 -1 -2 0 2 2 1 0};
% 3. Let’s perform the training sequences P1 and T1:
net = train(net, P1, T1);
net.IW{1, 1}, net.b{1};
Y1 = sim(net, [P1 P2]);
pause;
% 4. Let’s perform network training on the entire volume of the training data:
net = init(net);
P3 = [P1 P2];
T3 = [T1 T2];
net.trainParam.epochs = 200;
net.trainParam. goal = 0.01;
net = train(net, P3, T3);
net.IW{1, 1}, net.b{1}; % - [0.9242] [0.9869] [0.0339] [0.0602]
Y3 = sim(net, P3); % - discrete model
pause;
% 5. Let’s plot the response of T3 and approximations of Y1 and Y3:
TT3=cell2mat(T3);
YY1=cell2mat(Y1);
YY3=cell2mat(Y3);
plot(1:19, TT3, 'G'), hold on % - green;
plot(1:19, YY1, 'B'), hold on % - blue;
plot(1:19, YY3, 'R'), hold off % - red.