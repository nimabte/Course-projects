function [Error,Mask]=ErrorCal(PredictedLabel,TestLabel,ImTestPca)
%% Error Rate is calculated
True=0;
False=0;
Mask=zeros(1,length(PredictedLabel));
    for i=1:length(PredictedLabel)
    if strcmp(PredictedLabel{i},TestLabel{i})
        %Mask(i) is 1 if the predicted class for i'th sample is correct
        Mask(i)=1;
        True=True+1;
    else
        False=False+1;
    end
    end 
% Error=(False-4*length(ImTestPca))/(True+False);
 Error=(False)/(True+False);
    
    