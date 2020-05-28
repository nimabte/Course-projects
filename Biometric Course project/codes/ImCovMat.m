function [GMat,Images,TrainLabel]=ImCovMat(dir1,theta)
%ImCovMat  takes "dir1" folder of training images as input
%ImCovMat gives Image Covariance Matrix, "G" as output
%% Calculating The Mean of Training Images
Imean=0;
I=imread(['./train_44/',dir1(1).name]);
Images=zeros(size(I,1),size(I,2),length(dir1));
TrainLabel=cell(1,length(dir1));
disp('Reading Training Images...');
unit=floor(length(dir1)/10);
for i=1:length(dir1)
    if mod(i,unit)==0
        disp([num2str(i/length(dir1)*100),' Percent...']);
    end
    ImName=dir1(i).name;
    I=imread(['./train_44/',ImName]);
    TrainLabel{i}=ImName(1:5);
    %     I=rgb2gray(I);
    I=double(I);
    %     I=double(imresize(I,[50,40]));
    Imean=Imean+I;
    Images(:,:,i)=I;
end
Imean=Imean/length(dir1);
disp('All Images Has Been Read!');
%"Imean" is the mean of all traning images
%......................................................................................................
%......................................................................................................
%% Calculating the Image Covariance Matrix "G"
disp('Calculating Image Covariance Matrix, Please Wait...');
GMat=cell(1,length(theta));
for k=1:length(theta)
    disp([num2str(floor(k/length(theta)*100)),' Percent...'])
    G=0;
    Imeank=imrotate(Imean,theta(k),'bicubic');
    Imeank(Imeank>=230)=0;
    for i=1:length(dir1)
        I=Images(:,:,i);
        I=imrotate(I,theta(k),'bicubic');
        I=double(I);
        I(I>=230)=0;
        %     I=double(imresize(I,[50,40]));
        G=G+(I-Imeank)'*(I-Imeank);
    end
    G=G/length(dir1);
    GMat{k}=G;
end
disp('Image Covariance Matrix Calculated!');
% "G" is the Image Covariance Matrix
%if image size is m*n, then the size of G is n*n
%......................................................................................................
%......................................................................................................