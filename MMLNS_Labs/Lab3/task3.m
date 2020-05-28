% 1. Create a perceptron:
net = newp([0 1;0 1], 1);

% 2. Prepare the training sequences
p={[0;0] [0;1] [1;0] [1;1]};
p1=cat(2, p{:});
T1=num2cell(p1(1,:) & p1(2,:)) % – function AND;
T2=num2cell(p1(1,:) | p1(2,:)) % – functin OR.
% pause;

% 3. Adjust the settings of the perceptron to perform logical function AND, using the learning procedure:
net.trainParam.epochs=20; % – cycle number;
net = init(net); % – initialization;
net = train(net,p,T1); % – set function OR;
net.IW{1,1},net.b{1}; % – hardlim(1p1 + 1p2 –2);
Y1 = sim(net,p); % – modeling function OR.
pause;

% 4. Adjust the settings of the perceptron to perform logical function OR, using the learning procedure:
net.trainParam.epochs=20; % – cycle number;
net = init(net); % – initialization;
net = train(net,p,T2); % – set function OR;
net.IW{1,1},net.b{1}; % – hardlim(2p1 + 2p2 –1);
Y2 = sim(net,p); % – modeling function OR.