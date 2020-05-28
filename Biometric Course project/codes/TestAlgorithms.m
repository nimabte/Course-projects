function [Error,PredictedLabel,TestLabel,Mask]=TestAlgorithms(dir2,Vprj,method,ImTrainPca,TrainLabel)
%% The Method Defines Number Of Directions Inwhich 2DPCA Should Be Implemented
switch method
    case '2DPCA'
        disp('Testing Two Dimensional Principal Algorithm');
        ImTestPca=cell(1,1);
        theta=0;
    case 'Alt2DPCA'
        disp('Testing Alternative Two Dimensional Principal Algorithm');
        ImTestPca=cell(1,1);
        theta=90;
    case '2D2DPCA'
        disp('Testing 2 Directional Two Dimensional Principal Algorithm');
        ImTestPca=cell(1,2);
        theta=[0,90];
    case '4D2DPCA'
        disp('Testing 4 Directional Two Dimensional Principal Algorithm');
        ImTestPca=cell(1,4);
        theta=0:180/4:3*180/4;
        theta=[theta];
    case '6D2DPCA'
        disp('Testing 6 Directional Two Dimensional Principal Algorithm');
        ImTestPca=cell(1,6);
        theta=0:180/6:5*180/6;
        theta=[theta,90];
end
%% Reading test images and projecting them on projection vectors
disp('Reading All Test Images & their Calculating Feature Matrix')
TestLabel=cell(1,length(dir2));
NumOfEig=size(Vprj{1},2);
for k=1:length(theta)
    disp([num2str(floor(k/length(theta)*100)),' Percent...'])
    I=imread(['./test_44/',dir2(1).name]);
    I=imrotate(I,theta(k),'bicubic');
    TestPca=zeros(size(I,1),NumOfEig,length(dir2));
    Vproj=Vprj{k};
for i=1:length(dir2)
    ImName=dir2(i).name;
    I=imread(['./test_44/',ImName]);
    TestLabel{i}=ImName(1:5);
    I=imrotate(I,theta(k),'bicubic');
    I=double(I);
     I(I>=230)=0;
% I(I==0)=255;
    TestPca(:,:,i)=I*Vproj;
end
ImTestPca{k}=TestPca;
end
disp('Feature matrix of Test Images Calculated!')
pause(.1);
disp('Classifying The Testing Samples...')
%% Classifying Test Samples Based on the Distance between each test feature matrix and traing feature matirixes 
[Error,PredictedLabel,TestLabel,Mask]=ClassifySamples(ImTestPca,TestLabel,ImTrainPca,TrainLabel);

    
