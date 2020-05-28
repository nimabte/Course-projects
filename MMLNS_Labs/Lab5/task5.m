% 1. Create function description:
P = -3:0.1:3;
a1 = radbas(P);
a2 = radbas(P-1.5);
a3 = radbas(P+2);
a = a1 + a2 + 0.5*a3;
plot(P, a1, P, a2, P, 0.5*a3, P, a);