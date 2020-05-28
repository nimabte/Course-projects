%activation functions with severe restrictions satlins
n=-5:0.1:5;
a=satlins(n);
da=dsatlins(n,a);
figure(1)
plot(n,a,'r'), grid; % - graph of the activation function - red;
hold on
plot(n,da,'c'); % - the graph of the derivative - blue;

  
%Calculating the output vectors of A and the derivative dA
N=[-0.7; 0.1; 0.8];
A=satlins(N); % - the output vector of the activation function;
dA=dsatlins(N,A); % - the output vector of derivatives.
figure(2)
plot(N,A,'r'), grid; % - graph of the activation function - red;
hold on
plot(N,dA,'c'); % - the graph of the derivative - blue;


