% 1. ?reate samples of two sinusoids with amplitudes 1.0 and 2.0:
p1=sin(1:20);
p2=sin(1:20)*2;
% 2. Generate target vectors:
t1=ones(1,20);
t2=ones(1,20)*2;
% 3. Form a set of vectors of entrance and objectives:
p=[p1 p2 p1 p2];
t=[t1 t2 t1 t2];
% 4. Form the training sequence:
Pseq=con2seq(p); % – the array of cells;
Tseq=con2seq(t); % – the array of cells;
% 5. Create Elman network:
net=newelm( [-2 2], [10, 1],...
{'tansig','purelin'},'traingdx' );
net.layers{1}; net.IW{1,1}; net.LW{1,1};
net.layers{2}; net.LW{2,1}; pause;
% 6. Train the network:
net.trainParam.epochs = 1000;
net.trainParam.show = 25;
net.trainParam.goal = 0.01;
[net,tr] = train(net, Pseq, Tseq);
net.IW{1,1}, net.LW{1,1}, net.LW{2,1}, pause;
% 7. Test the network on the training sequence:
figure(1);
a=sim(net,Pseq);
time=1:length(p);
plot(time, t, '--', time, cat(2,a{:}));
axis([1 80 0.8 2.2]), pause;
% 8. Check the network in random order:
p3=sin(1:20)*1.6;
t3=ones(1,20)*1.6;
p4=sin(1:20)*1.2;
t4=ones(1,20)*1.2;
p9=[p3 p4 p3 p4];
t9=[t3 t4 t3 t4];
pgseq=con2seq(p9);
figure(2);
a=sim(net,pgseq);
time=1:length(p9);
plot( time, t9, '--', time, cat(2,a{:}) );
axis([1 80 0.8 2.2]);