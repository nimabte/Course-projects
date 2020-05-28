%activation functions with severe restrictions softmax
N = [0; 1; -0.5; 0.5];
A = softmax(N);
subplot(2,1,1), % - subwindows 2x1; the output of the 1-th subwindow;
bar(N), % - bar chart;
ylabel('N') % the y-axis label;
subplot(2,1,2), bar(A), ylabel('A') % - in the 2-nd subwindow.

