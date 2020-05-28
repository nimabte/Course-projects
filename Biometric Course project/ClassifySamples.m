function [Error,PredictedLabel,TestLabel,Mask]=ClassifySamples(ImTestPca,TestLabel,ImTrainPca,TrainLabel)
%% This Function Calculates the Match Score between each test sample and all training samples
PredictedLabel=cell(1,length(TestLabel));
NumOfTest=size(ImTestPca{1},3);
NumOfTrain=size(ImTrainPca{1},3);
NumOfAngles=length(ImTestPca);
unit=floor(NumOfTest/10);
%% for each sample test, "MatchScore" is a (NumOfAngles)*(NumOfTrain) matrix
%each row of MatchScore score is the distances between each test sample and
%all traing samples in a particular direction
for i=1:NumOfTest
    if mod(i,unit)==0
        disp([num2str(floor(i/NumOfTest*100)),' Percent...']);
    end
    MatchScore=zeros(NumOfAngles,NumOfTrain);
    for k=1:NumOfAngles
        TestImages=ImTestPca{k};
        TrainImages=ImTrainPca{k};
        ImTest=TestImages(:,:,i);
        for j=1:NumOfTrain
            ImTrain=TrainImages(:,:,j);
            %the distance is calculated here
            MatchScore(k,j)=sum(sqrt(sum((ImTest-ImTrain).^2)));
        end
    end
    MatchScoreMean=repmat(mean(MatchScore')',1,NumOfTrain);
%     MatchScoreMean=repmat(sqrt(sum((MatchScore').^2)),1,NumOfTrain);
    MatchScore=MatchScore-MatchScoreMean;
    MatchScores=sum(MatchScore,1);
%     MatchScores=MatchScores+MatchScore(1,:);
    %sum of match scores for all directions
    [MInVal,MinInd]=min(MatchScores);
    %finding the nearest training sample
    PredictedLabel{i}=TrainLabel{MinInd};
end
%%
disp('Calculating Error Rate...')
%calculate the error rate by seeing how many elements of "PredictedLabel"
%and "TestLabel" are different
[Error,Mask]=ErrorCal(PredictedLabel,TestLabel,ImTestPca);

