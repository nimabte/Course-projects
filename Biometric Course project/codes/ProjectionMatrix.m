function Vprj=ProjectionMatrix(Gmat,NumOfEig,Percent)
%% ProjectionMatrix calculates NumOfEig Projection Vectors  corresponding to G 
disp('Calculating Projection Vectors...')
Vprj=cell(1,length(Gmat));
for k=1:length(Gmat)
    G=Gmat{k};
[V,D]=eig(G);
D=diag(D);
%sort eigen vectors according to largest eigen value o smallest one
[DVal,Dind]=sort(D,'descend');
Vsort=V(:,Dind);
if (isempty(NumOfEig))&(~isempty(Percent))   
    %calculating cumulative D
    SumD=zeros(size(DVal));
for k=1:length(DVal);
    SumD(k)=sum(DVal(1:k))/sum(DVal);
end
figure;plot(SumD,'LineWidth',2);
grid on;hold on
[MinVal,MinInd]=min(abs(SumD-Percent));
plot([0,length(DVal)],[Percent,Percent],'--')
pause(.5)
NumOfEig=MinInd;
elseif ~((~isempty(NumOfEig))&(isempty(Percent)))
    error('Input values NumOfEig, Percent are not correct');
end   
Vprj{k}=Vsort(:,1:NumOfEig);
end
disp('Projection Vectors Calculated!')
%Vprj is the projection matrix
%.............................................................................................
%.............................................................................................
