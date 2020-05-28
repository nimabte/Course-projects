%activation functions with severe restrictions tribas
n=-5:0.1:5;
a=tribas(n);
da=dtribas(n,a);
figure(1)
plot(n,a,'r'), grid; % - graph of the activation function - red;
hold on
plot(n,da,'c'); % - the graph of the derivative - blue;

  
%Calculating the output vectors of A and the derivative dA
N=[-0.7; 0.1; 0.8];
A=tribas(N); % - the output vector of the activation function;
dA=dtribas(N,A); % - the output vector of derivatives.
figure(2)
plot(N,A,'r'), grid; % - graph of the activation function - red;
hold on
plot(N,dA,'c'); % - the graph of the derivative - blue;
