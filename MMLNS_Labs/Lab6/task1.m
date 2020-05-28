% Build a recurrent neural network of Elman:
P = round(rand(1,20));
T = [ 0 (P(1:end-1)+P(2:end)==2) ]; 
Pseq = con2seq(P); 
Tseq = con2seq(T); 
net = newelm ([0 1], [10, 1], {'tansig', 'logsig'});

gensim(net)
net.trainParam.goal = 0.001;
net.trainParam.epochs = 1000;
net = train(net, Pseq, Tseq);
Y = sim(net, Pseq);
Y1 = seq2con(Y);
E1=T-Y1{1};
plot(1:length(E1), E1), grid, pause;
E=round(T-Y1{1}) % – zero error.