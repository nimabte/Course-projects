dir1=dir('./train_44/*.bmp');
dir2=dir('./test_44/*.bmp');
Error_2DPCA=[];
Error_Alt2DPCA=[];
Error_2D2DPCA=[];
Error_4D2DPCA=[];
Error_6D2DPCA=[];
k=1;
for NumOfEig=10:2:20
    NumOfEig
[ImTrainPca,TrainLabel,Vprj]=TrainAlgorithms(dir1,'2DPCA',NumOfEig,[]);
[Error,PredictedLabel,TestLabel,Mask]=TestAlgorithms(dir2,Vprj,'2DPCA',ImTrainPca,TrainLabel);
Error_2DPCA(k)=1-Error
[ImTrainPca,TrainLabel,Vprj]=TrainAlgorithms(dir1,'Alt2DPCA',NumOfEig,[]);
[Error,PredictedLabel,TestLabel,Mask]=TestAlgorithms(dir2,Vprj,'Alt2DPCA',ImTrainPca,TrainLabel);
Error_Alt2DPCA(k)=1-Error
[ImTrainPca,TrainLabel,Vprj]=TrainAlgorithms(dir1,'2D2DPCA',NumOfEig,[]);
[Error,PredictedLabel,TestLabel,Mask]=TestAlgorithms(dir2,Vprj,'2D2DPCA',ImTrainPca,TrainLabel);
Error_2D2DPCA(k)=1-Error
[ImTrainPca,TrainLabel,Vprj]=TrainAlgorithms(dir1,'4D2DPCA',NumOfEig,[]);
[Error,PredictedLabel,TestLabel,Mask]=TestAlgorithms(dir2,Vprj,'4D2DPCA',ImTrainPca,TrainLabel);
Error_4D2DPCA(k)=1-Error
[ImTrainPca,TrainLabel,Vprj]=TrainAlgorithms(dir1,'6D2DPCA',NumOfEig,[]);
[Error,PredictedLabel,TestLabel,Mask]=TestAlgorithms(dir2,Vprj,'6D2DPCA',ImTrainPca,TrainLabel);
Error_6D2DPCA(k)=1-Error
k=k+1;
end
Error_2DPCA
Error_Alt2DPCA
Error_2D2DPCA
Error_4D2DPCA
Error_6D2DPCA


