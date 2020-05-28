function [ImTrainPca,TrainLabel,Vprj]=TrainAlgorithms(dir1,method,NumOfEig,Percent)
%% The Method Defines Number Of Directions Inwhich 2DPCA Should Be Implemented
switch method
    case '2DPCA'
        disp('Implementing Two Dimensional Principal Algorithm');
        ImTrainPca=cell(1,1);
        theta=0;
    case 'Alt2DPCA'
        disp('Implementing Alternative Two Dimensional Principal Algorithm');
        ImTrainPca=cell(1,1);
        theta=90;
    case '2D2DPCA'
        disp('Implementing 2 Directional Two Dimensional Principal Algorithm');
        ImTrainPca=cell(1,2);
        theta=[0,90];
    case '4D2DPCA'
        disp('Implementing 4 Directional Two Dimensional Principal Algorithm');
        ImTrainPca=cell(1,4);
        theta=0:180/4:3*180/4;
        theta=[theta];
    case '6D2DPCA'
        disp('Implementing 6 Directional Two Dimensional Principal Algorithm');
        ImTrainPca=cell(1,6);
        theta=0:180/6:5*180/6;
        theta=[theta,90];
end
%% Calculating Image Covariance Matrix
[Gmat,Images,TrainLabel]=ImCovMat(dir1,theta);
%% Calculating Projection Vectors
Vprj=ProjectionMatrix(Gmat,NumOfEig,Percent);
%% Projecting All Training Samples on Projection Vectors
disp('Calculating Feature Matrix Of Training Samples')
for k=1:length(theta)
    disp([num2str(floor(k/length(theta)*100)),' Percent...'])
    sample=Images(:,:,1);
    I=imrotate(sample,theta(k),'bicubic');
    TrainPca=zeros(size(I,1),NumOfEig,size(Images,3));
    Vproj=Vprj{k};
    for i=1:length(dir1)
        I=double(Images(:,:,i));
        I=imrotate(I,theta(k),'bicubic');
        I(I>=230)=0;
        TrainPca(:,:,i)=I*Vproj;
    end
    ImTrainPca{1,k}=TrainPca;
end
%"ImTrainPca" is a cell that each of its elements is a m*d*N matrix where m
%is number of rows of images, d is number of eigen vectors and N is number of trainig images
disp('Feature Matrix Of Training Samples Calculated!')






