%  Create perceptron:
net=newp([-2 2; -2 2],1);
%  Perform manual initialization:
net.IW{1,1} = [-1 1] ;
net.b{1} = [1];
%  Check perceptron:
p = [1;1];
a = sim(net, p); % a = 1;
p = [1;-1];
a = sim(net, p); % a = 0;
%  Define classes of vector values:
p = {[-2;-2] [-2;-1] [-2;0] [-2;1] [-2;2]...
[-1;-2] [-1;-1] [-1;0] [-1;1] [-1;2]...
[0;-2] [0;-1] [0;0] [0;1] [0;2]...
[1;-2] [1;-1] [1;0] [1;1] [1;2]...
[2;-2] [2;-1] [2;0] [2;1] [2;2]};
a = sim(net, p); % [0]-the 0-th class; [1]-1 st class.