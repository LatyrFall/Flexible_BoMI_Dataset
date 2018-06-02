function precision = build_dataset_v31(data,nbimuused,mode,nwin,novrlp)
%clear
%close
%clc
%%
addpath('plotConfMat')
load(data);
precision = 0;
%% training
Nwin = nwin;
Novrlp = novrlp;
size = 2*length(Pitch1Raw(1:end))*1/3;
%disp('size')
%disp(size)
labeltrain = 0;
%mean
meantrainpitch1 = 0; meantrainpitch2 = 0; meantrainpitch3 = 0;
meantrainroll1 = 0;  meantrainroll2 = 0;  meantrainroll3 = 0;
meantrainyaw1 = 0;   meantrainyaw2 = 0;   meantrainyaw3 = 0;
meantraingyrox1 = 0; meantraingyroy1 = 0; meantraingyroz1 = 0;
meantraingyrox2 = 0; meantraingyroy2 = 0; meantraingyroz2 = 0;
meantraingyrox3 = 0; meantraingyroy3 = 0; meantraingyroz3 = 0;
%max
maxtrainpitch1 = 0; maxtrainpitch2 = 0; maxtrainpitch3 = 0;
maxtrainroll1 = 0;  maxtrainroll2 = 0;  maxtrainroll3 = 0;
maxtrainyaw1 = 0;   maxtrainyaw2 = 0;   maxtrainyaw3 = 0;
maxtraingyrox1 = 0; maxtraingyroy1 = 0; maxtraingyroz1 = 0;
maxtraingyrox2 = 0; maxtraingyroy2 = 0; maxtraingyroz2 = 0;
maxtraingyrox3 = 0; maxtraingyroy3 = 0; maxtraingyroz3 = 0;
%min
mintrainpitch1 = 0; mintrainpitch2 = 0; mintrainpitch3 = 0;
mintrainroll1 = 0;  mintrainroll2 = 0;  mintrainroll3 = 0;
mintrainyaw1 = 0;   mintrainyaw2 = 0;   mintrainyaw3 = 0;
mintraingyrox1 = 0; mintraingyroy1 = 0; mintraingyroz1 = 0;
mintraingyrox2 = 0; mintraingyroy2 = 0; mintraingyroz2 = 0;
mintraingyrox3 = 0; mintraingyroy3 = 0; mintraingyroz3 = 0;
%mad
madtrainpitch1 = 0; madtrainpitch2 = 0; madtrainpitch3 = 0;
madtrainroll1 = 0;  madtrainroll2 = 0;  madtrainroll3 = 0;
madtrainyaw1 = 0;   madtrainyaw2 = 0;   madtrainyaw3 = 0;
madtraingyrox1 = 0; madtraingyroy1 = 0; madtraingyroz1 = 0;
madtraingyrox2 = 0; madtraingyroy2 = 0; madtraingyroz2 = 0;
madtraingyrox3 = 0; madtraingyroy3 = 0; madtraingyroz3 = 0;
%iav
iavtrainpitch1 = 0; iavtrainpitch2 = 0; iavtrainpitch3 = 0;
iavtrainroll1 = 0;  iavtrainroll2 = 0;  iavtrainroll3 = 0;
iavtrainyaw1 = 0;   iavtrainyaw2 = 0;   iavtrainyaw3 = 0;
iavtraingyrox1 = 0; iavtraingyroy1 = 0; iavtraingyroz1 = 0;
iavtraingyrox2 = 0; iavtraingyroy2 = 0; iavtraingyroz2 = 0;
iavtraingyrox3 = 0; iavtraingyroy3 = 0; iavtraingyroz3 = 0;
%%
index1 = 1; index2 = Nwin; index = 0; indexmax = 0;
a = -1; nbwindows = 0;
while indexmax < size
    a = Etiquette(index1);
    indexmax =   index1 + 300;
    if a == Etiquette(indexmax + 1) && indexmax < size
        indexmax = indexmax + 301;
    end
    while (index2 < indexmax)
        subwin = 1;
        index = index + 1;
        while subwin < 3
            index2 = index1 + 4*subwin - 1;
            labeltrain (index) = Etiquette(index1);
            %mean
            meantrainpitch1(index,subwin) = mean(Pitch1Raw(index1:index2));meantrainpitch2(index,subwin) = mean(Pitch2Raw(index1:index2));meantrainpitch3(index,subwin) = mean(Pitch3Raw(index1:index2));
            meantrainroll1(index,subwin) = mean(Roll1Raw(index1:index2));meantrainroll2(index,subwin) = mean(Roll2Raw(index1:index2));meantrainroll3(index,subwin) = mean(Roll3Raw(index1:index2));
            meantrainyaw1(index,subwin) = mean(Yaw1Raw(index1:index2));meantrainyaw2(index,subwin) = mean(Yaw2Raw(index1:index2));meantrainyaw3(index,subwin) = mean(Yaw3Raw(index1:index2));
            meantraingyrox1(index,subwin) = mean(GYRO1X(index1:index2 )); meantraingyrox2(index,subwin) = mean(GYRO2X(index1 :index2 )); meantraingyrox3(index,subwin) = mean(GYRO3X(index1 :index2 ));
            meantraingyroy1(index,subwin) = mean(GYRO1Y(index1:index2 )); meantraingyroy2(index,subwin) = mean(GYRO2Y(index1 :index2 )); meantraingyroy3(index,subwin) = mean(GYRO3Y(index1 :index2 ));
            meantraingyroz1(index,subwin) = mean(GYRO1Z(index1:index2 )); meantraingyroz2(index,subwin) = mean(GYRO2Z(index1 :index2 )); meantraingyroz3(index,subwin) = mean(GYRO3Z(index1 :index2 ));
            %max
            maxtrainpitch1(index,subwin) = max(Pitch1Raw(index1:index2));maxtrainpitch2(index,subwin) = max(Pitch2Raw(index1:index2));maxtrainpitch3(index,subwin) = max(Pitch3Raw(index1:index2));
            maxtrainroll1(index,subwin) = max(Roll1Raw(index1:index2));maxtrainroll2(index,subwin) = max(Roll2Raw(index1:index2));maxtrainroll3(index,subwin) = max(Roll3Raw(index1:index2));
            maxtrainyaw1(index,subwin) = max(Yaw1Raw(index1:index2));maxtrainyaw2(index,subwin) = max(Yaw2Raw(index1:index2));maxtrainyaw3(index,subwin) = max(Yaw3Raw(index1:index2));
            maxtraingyrox1(index,subwin) = max(GYRO1X(index1:index2 )); maxtraingyrox2(index,subwin) = max(GYRO2X(index1 :index2 )); maxtraingyrox3(index,subwin) = max(GYRO3X(index1 :index2 ));
            maxtraingyroy1(index,subwin) = max(GYRO1Y(index1:index2 )); maxtraingyroy2(index,subwin) = max(GYRO2Y(index1 :index2 )); maxtraingyroy3(index,subwin) = max(GYRO3Y(index1 :index2 ));
            maxtraingyroz1(index,subwin) = max(GYRO1Z(index1:index2 )); maxtraingyroz2(index,subwin) = max(GYRO2Z(index1 :index2 )); maxtraingyroz3(index,subwin) = max(GYRO3Z(index1 :index2 ));
            %min
            mintrainpitch1(index,subwin) = min(Pitch1Raw(index1:index2));mintrainpitch2(index,subwin) = min(Pitch2Raw(index1:index2));mintrainpitch3(index,subwin) = min(Pitch3Raw(index1:index2));
            mintrainroll1(index,subwin) = min(Roll1Raw(index1:index2));mintrainroll2(index,subwin) = min(Roll2Raw(index1:index2));mintrainroll3(index,subwin) = min(Roll3Raw(index1:index2));
            mintrainyaw1(index,subwin) = min(Yaw1Raw(index1:index2));mintrainyaw2(index,subwin) = min(Yaw2Raw(index1:index2));mintrainyaw3(index,subwin) = min(Yaw3Raw(index1:index2));
            mintraingyrox1(index,subwin) = min(GYRO1X(index1:index2 )); mintraingyrox2(index,subwin) = min(GYRO2X(index1 :index2 )); mintraingyrox3(index,subwin) = min(GYRO3X(index1 :index2 ));
            mintraingyroy1(index,subwin) = min(GYRO1Y(index1:index2 )); mintraingyroy2(index,subwin) = min(GYRO2Y(index1 :index2 )); mintraingyroy3(index,subwin) = min(GYRO3Y(index1 :index2 ));
            mintraingyroz1(index,subwin) = min(GYRO1Z(index1:index2 )); mintraingyroz2(index,subwin) = min(GYRO2Z(index1 :index2 )); mintraingyroz3(index,subwin) = min(GYRO3Z(index1 :index2 ));
            %mad
            madtrainpitch1(index,subwin) = mad(Pitch1Raw(index1:index2));madtrainpitch2(index,subwin) = mad(Pitch2Raw(index1:index2));madtrainpitch3(index,subwin) = mad(Pitch3Raw(index1:index2));
            madtrainroll1(index,subwin) = mad(Roll1Raw(index1:index2));madtrainroll2(index,subwin) = mad(Roll2Raw(index1:index2));madtrainroll3(index,subwin) = mad(Roll3Raw(index1:index2));
            madtrainyaw1(index,subwin) = mad(Yaw1Raw(index1:index2));madtrainyaw2(index,subwin) = mad(Yaw2Raw(index1:index2));madtrainyaw3(index,subwin) = mad(Yaw3Raw(index1:index2));
            madtraingyrox1(index,subwin) = mad(GYRO1X(index1:index2 )); madtraingyrox2(index,subwin) = mad(GYRO2X(index1 :index2 )); madtraingyrox3(index,subwin) = mad(GYRO3X(index1 :index2 ));
            madtraingyroy1(index,subwin) = mad(GYRO1Y(index1:index2 )); madtraingyroy2(index,subwin) = mad(GYRO2Y(index1 :index2 )); madtraingyroy3(index,subwin) = mad(GYRO3Y(index1 :index2 ));
            madtraingyroz1(index,subwin) = mad(GYRO1Z(index1:index2 )); madtraingyroz2(index,subwin) = mad(GYRO2Z(index1 :index2 )); madtraingyroz3(index,subwin) = mad(GYRO3Z(index1 :index2 ));
            %iav
            iavtrainpitch1(index,subwin) = iav(Pitch1Raw(index1:index2));iavtrainpitch2(index,subwin) = iav(Pitch2Raw(index1:index2));iavtrainpitch3(index,subwin) = iav(Pitch3Raw(index1:index2));
            iavtrainroll1(index,subwin) = iav(Roll1Raw(index1:index2));iavtrainroll2(index,subwin) = iav(Roll2Raw(index1:index2));iavtrainroll3(index,subwin) = iav(Roll3Raw(index1:index2));
            iavtrainyaw1(index,subwin) = iav(Yaw1Raw(index1:index2));iavtrainyaw2(index,subwin) = iav(Yaw2Raw(index1:index2));iavtrainyaw3(index,subwin) = iav(Yaw3Raw(index1:index2));
            iavtraingyrox1(index,subwin) = iav(GYRO1X(index1:index2 )); iavtraingyrox2(index,subwin) = iav(GYRO2X(index1 :index2 )); iavtraingyrox3(index,subwin) = iav(GYRO3X(index1 :index2 ));
            iavtraingyroy1(index,subwin) = iav(GYRO1Y(index1:index2 )); iavtraingyroy2(index,subwin) = iav(GYRO2Y(index1 :index2 )); iavtraingyroy3(index,subwin) = iav(GYRO3Y(index1 :index2 ));
            iavtraingyroz1(index,subwin) = iav(GYRO1Z(index1:index2 )); iavtraingyroz2(index,subwin) = iav(GYRO2Z(index1 :index2 )); iavtraingyroz3(index,subwin) = iav(GYRO3Z(index1 :index2 ));
            subwin = subwin + 1;
        end
        index1 = index1 + (Nwin - Novrlp);
        index2 = index1 + Nwin - 1;
        nbwindows = nbwindows + 1;
    end
    index1 = indexmax + 1;
    index2 = index1 + Nwin - 1;
    %disp(nbwindows)
    nbwindows = 0;
    %disp(index)
end
message = strcat('Training: Last Index = ',num2str(index2-Nwin));
disp(message);
disp('Training: Feature Extraction Done')
if (mode == 0) %raw, without gyro
    features_imu1 = [meantrainpitch1,meantrainroll1,meantrainyaw1];
    features_imu2 = [meantrainpitch2,meantrainroll2];
    features_imu3 = [meantrainpitch3,meantrainroll3];
elseif (mode == 1) %raw, with gyro
    features_imu1 = [meantrainpitch1,meantrainroll1,meantrainyaw1,meantraingyrox1,meantraingyroy1,meantraingyroz1];
    features_imu2 = [meantrainpitch2,meantrainroll2,meantraingyrox2,meantraingyroy2,meantraingyroz2];
    features_imu3 = [meantrainpitch3,meantrainroll3,meantraingyrox3,meantraingyroy3,meantraingyroz3];
elseif (mode == 2) %extracted features v1, with gyro
    features_imu1 = [meantrainpitch1,maxtrainpitch1,mintrainpitch1,iavtrainpitch1,meantrainroll1,maxtrainroll1,mintrainroll1,iavtrainroll1,meantrainyaw1,maxtrainyaw1,mintrainyaw1,iavtrainyaw1,meantraingyrox1,maxtraingyrox1,mintraingyrox1,iavtraingyrox1,meantraingyroy1,maxtraingyroy1,mintraingyroy1,iavtraingyroy1,meantraingyroz1,maxtraingyroz1,mintraingyroz1,iavtraingyroz1];
    features_imu2 = [meantrainpitch2,maxtrainpitch2,mintrainpitch2,iavtrainpitch2,meantrainroll2,maxtrainroll2,mintrainroll2,iavtrainroll2,meantraingyrox2,maxtraingyrox2,mintraingyrox2,iavtraingyrox2,meantraingyroy2,maxtraingyroy2,mintraingyroy2,iavtraingyroy2,meantraingyroz2,maxtraingyroz2,mintraingyroz2,iavtraingyroz2];
    features_imu3 = [meantrainpitch3,maxtrainpitch3,mintrainpitch3,iavtrainpitch3,meantrainroll3,maxtrainroll3,mintrainroll3,iavtrainroll3,meantraingyrox3,maxtraingyrox3,mintraingyrox3,iavtraingyrox3,meantraingyroy3,maxtraingyroy3,mintraingyroy3,iavtraingyroy3,meantraingyroz3,maxtraingyroz3,mintraingyroz3,iavtraingyroz3];
end

if (nbimuused == 2)
    features = [features_imu1,features_imu2];%,features_imu3];
elseif (nbimuused == 3)
    features = [features_imu1,features_imu2,features_imu3];
end
LearnMotion_lda = fitcdiscr(features,labeltrain');
disp('Training: Model Generation Done')
%%
%% testing
load(data);
Nwin = nwin;
Novrlp = novrlp;
size = length(Pitch1Raw(1:end))*1/3;
if (nbimuused == 2)
    shift = 301*62;
elseif (nbimuused == 3)
    shift = 301*98;
end
%%
labeltest = 0;
%mean
meantestpitch1 = 0; meantestpitch2 = 0; meantestpitch3 = 0;
meantestroll1 = 0;  meantestroll2 = 0;  meantestroll3 = 0;
meantestyaw1 = 0;   meantestyaw2 = 0;   meantestyaw3 = 0;
meantestgyrox1 = 0; meantestgyroy1 = 0; meantestgyroz1 = 0;
meantestgyrox2 = 0; meantestgyroy2 = 0; meantestgyroz2 = 0;
meantestgyrox3 = 0; meantestgyroy3 = 0; meantestgyroz3 = 0;
%max
maxtestpitch1 = 0; maxtestpitch2 = 0; maxtestpitch3 = 0;
maxtestroll1 = 0;  maxtestroll2 = 0;  maxtestroll3 = 0;
maxtestyaw1 = 0;   maxtestyaw2 = 0;   maxtestyaw3 = 0;
maxtestgyrox1 = 0; maxtestgyroy1 = 0; maxtestgyroz1 = 0;
maxtestgyrox2 = 0; maxtestgyroy2 = 0; maxtestgyroz2 = 0;
maxtestgyrox3 = 0; maxtestgyroy3 = 0; maxtestgyroz3 = 0;
%min
mintestpitch1 = 0; mintestpitch2 = 0; mintestpitch3 = 0;
mintestroll1 = 0;  mintestroll2 = 0;  mintestroll3 = 0;
mintestyaw1 = 0;   mintestyaw2 = 0;   mintestyaw3 = 0;
mintestgyrox1 = 0; mintestgyroy1 = 0; mintestgyroz1 = 0;
mintestgyrox2 = 0; mintestgyroy2 = 0; mintestgyroz2 = 0;
mintestgyrox3 = 0; mintestgyroy3 = 0; mintestgyroz3 = 0;
%mad
madtestpitch1 = 0; madtestpitch2 = 0; madtestpitch3 = 0;
madtestroll1 = 0;  madtestroll2 = 0;  madtestroll3 = 0;
madtestyaw1 = 0;   madtestyaw2 = 0;   madtestyaw3 = 0;
madtestgyrox1 = 0; madtestgyroy1 = 0; madtestgyroz1 = 0;
madtestgyrox2 = 0; madtestgyroy2 = 0; madtestgyroz2 = 0;
madtestgyrox3 = 0; madtestgyroy3 = 0; madtestgyroz3 = 0;
%iav
iavtestpitch1 = 0; iavtestpitch2 = 0; iavtestpitch3 = 0;
iavtestroll1 = 0;  iavtestroll2 = 0;  iavtestroll3 = 0;
iavtestyaw1 = 0;   iavtestyaw2 = 0;   iavtestyaw3 = 0;
iavtestgyrox1 = 0; iavtestgyroy1 = 0; iavtestgyroz1 = 0;
iavtestgyrox2 = 0; iavtestgyroy2 = 0; iavtestgyroz2 = 0;
iavtestgyrox3 = 0; iavtestgyroy3 = 0; iavtestgyroz3 = 0;
%%
index1 = shift + 1; index2 = shift + Nwin; index = 0; indexmax = 0;
a = -1; nbwindows = 0;
while indexmax < size + shift
    a = Etiquette(index1);
    indexmax =   index1 + 300;
%     if a == Etiquette(indexmax + 1) && indexmax < size
%         indexmax = indexmax + 301;
%     end
    while (index2 < indexmax)
        subwin = 1;
        index = index + 1;
        while subwin < 3
            index2 = index1 + 4*subwin - 1;
            labeltest (index) = Etiquette(index1);
            %mean
            meantestpitch1(index,subwin) = mean(Pitch1Raw(index1:index2));meantestpitch2(index,subwin) = mean(Pitch2Raw(index1:index2));meantestpitch3(index,subwin) = mean(Pitch3Raw(index1:index2));
            meantestroll1(index,subwin) = mean(Roll1Raw(index1:index2));meantestroll2(index,subwin) = mean(Roll2Raw(index1:index2));meantestroll3(index,subwin) = mean(Roll3Raw(index1:index2));
            meantestyaw1(index,subwin) = mean(Yaw1Raw(index1:index2));meantestyaw2(index,subwin) = mean(Yaw2Raw(index1:index2));meantestyaw3(index,subwin) = mean(Yaw3Raw(index1:index2));
            meantestgyrox1(index,subwin) = mean(GYRO1X(index1:index2 )); meantestgyrox2(index,subwin) = mean(GYRO2X(index1 :index2 )); meantestgyrox3(index,subwin) = mean(GYRO3X(index1 :index2 ));
            meantestgyroy1(index,subwin) = mean(GYRO1Y(index1:index2 )); meantestgyroy2(index,subwin) = mean(GYRO2Y(index1 :index2 )); meantestgyroy3(index,subwin) = mean(GYRO3Y(index1 :index2 ));
            meantestgyroz1(index,subwin) = mean(GYRO1Z(index1:index2 )); meantestgyroz2(index,subwin) = mean(GYRO2Z(index1 :index2 )); meantestgyroz3(index,subwin) = mean(GYRO3Z(index1 :index2 ));
            %max
            maxtestpitch1(index,subwin) = max(Pitch1Raw(index1:index2));maxtestpitch2(index,subwin) = max(Pitch2Raw(index1:index2));maxtestpitch3(index,subwin) = max(Pitch3Raw(index1:index2));
            maxtestroll1(index,subwin) = max(Roll1Raw(index1:index2));maxtestroll2(index,subwin) = max(Roll2Raw(index1:index2));maxtestroll3(index,subwin) = max(Roll3Raw(index1:index2));
            maxtestyaw1(index,subwin) = max(Yaw1Raw(index1:index2));maxtestyaw2(index,subwin) = max(Yaw2Raw(index1:index2));maxtestyaw3(index,subwin) = max(Yaw3Raw(index1:index2));
            maxtestgyrox1(index,subwin) = max(GYRO1X(index1:index2 )); maxtestgyrox2(index,subwin) = max(GYRO2X(index1 :index2 )); maxtestgyrox3(index,subwin) = max(GYRO3X(index1 :index2 ));
            maxtestgyroy1(index,subwin) = max(GYRO1Y(index1:index2 )); maxtestgyroy2(index,subwin) = max(GYRO2Y(index1 :index2 )); maxtestgyroy3(index,subwin) = max(GYRO3Y(index1 :index2 ));
            maxtestgyroz1(index,subwin) = max(GYRO1Z(index1:index2 )); maxtestgyroz2(index,subwin) = max(GYRO2Z(index1 :index2 )); maxtestgyroz3(index,subwin) = max(GYRO3Z(index1 :index2 ));
            %min
            mintestpitch1(index,subwin) = min(Pitch1Raw(index1:index2));mintestpitch2(index,subwin) = min(Pitch2Raw(index1:index2));mintestpitch3(index,subwin) = min(Pitch3Raw(index1:index2));
            mintestroll1(index,subwin) = min(Roll1Raw(index1:index2));mintestroll2(index,subwin) = min(Roll2Raw(index1:index2));mintestroll3(index,subwin) = min(Roll3Raw(index1:index2));
            mintestyaw1(index,subwin) = min(Yaw1Raw(index1:index2));mintestyaw2(index,subwin) = min(Yaw2Raw(index1:index2));mintestyaw3(index,subwin) = min(Yaw3Raw(index1:index2));
            mintestgyrox1(index,subwin) = min(GYRO1X(index1:index2 )); mintestgyrox2(index,subwin) = min(GYRO2X(index1 :index2 )); mintestgyrox3(index,subwin) = min(GYRO3X(index1 :index2 ));
            mintestgyroy1(index,subwin) = min(GYRO1Y(index1:index2 )); mintestgyroy2(index,subwin) = min(GYRO2Y(index1 :index2 )); mintestgyroy3(index,subwin) = min(GYRO3Y(index1 :index2 ));
            mintestgyroz1(index,subwin) = min(GYRO1Z(index1:index2 )); mintestgyroz2(index,subwin) = min(GYRO2Z(index1 :index2 )); mintestgyroz3(index,subwin) = min(GYRO3Z(index1 :index2 ));
            %mad
            madtestpitch1(index,subwin) = mad(Pitch1Raw(index1:index2));madtestpitch2(index,subwin) = mad(Pitch2Raw(index1:index2));madtestpitch3(index,subwin) = mad(Pitch3Raw(index1:index2));
            madtestroll1(index,subwin) = mad(Roll1Raw(index1:index2));madtestroll2(index,subwin) = mad(Roll2Raw(index1:index2));madtestroll3(index,subwin) = mad(Roll3Raw(index1:index2));
            madtestyaw1(index,subwin) = mad(Yaw1Raw(index1:index2));madtestyaw2(index,subwin) = mad(Yaw2Raw(index1:index2));madtestyaw3(index,subwin) = mad(Yaw3Raw(index1:index2));
            madtestgyrox1(index,subwin) = mad(GYRO1X(index1:index2 )); madtestgyrox2(index,subwin) = mad(GYRO2X(index1 :index2 )); madtestgyrox3(index,subwin) = mad(GYRO3X(index1 :index2 ));
            madtestgyroy1(index,subwin) = mad(GYRO1Y(index1:index2 )); madtestgyroy2(index,subwin) = mad(GYRO2Y(index1 :index2 )); madtestgyroy3(index,subwin) = mad(GYRO3Y(index1 :index2 ));
            madtestgyroz1(index,subwin) = mad(GYRO1Z(index1:index2 )); madtestgyroz2(index,subwin) = mad(GYRO2Z(index1 :index2 )); madtestgyroz3(index,subwin) = mad(GYRO3Z(index1 :index2 ));
            %iav
            iavtestpitch1(index,subwin) = iav(Pitch1Raw(index1:index2));iavtestpitch2(index,subwin) = iav(Pitch2Raw(index1:index2));iavtestpitch3(index,subwin) = iav(Pitch3Raw(index1:index2));
            iavtestroll1(index,subwin) = iav(Roll1Raw(index1:index2));iavtestroll2(index,subwin) = iav(Roll2Raw(index1:index2));iavtestroll3(index,subwin) = iav(Roll3Raw(index1:index2));
            iavtestyaw1(index,subwin) = iav(Yaw1Raw(index1:index2));iavtestyaw2(index,subwin) = iav(Yaw2Raw(index1:index2));iavtestyaw3(index,subwin) = iav(Yaw3Raw(index1:index2));
            iavtestgyrox1(index,subwin) = iav(GYRO1X(index1:index2 )); iavtestgyrox2(index,subwin) = iav(GYRO2X(index1 :index2 )); iavtestgyrox3(index,subwin) = iav(GYRO3X(index1 :index2 ));
            iavtestgyroy1(index,subwin) = iav(GYRO1Y(index1:index2 )); iavtestgyroy2(index,subwin) = iav(GYRO2Y(index1 :index2 )); iavtestgyroy3(index,subwin) = iav(GYRO3Y(index1 :index2 ));
            iavtestgyroz1(index,subwin) = iav(GYRO1Z(index1:index2 )); iavtestgyroz2(index,subwin) = iav(GYRO2Z(index1 :index2 )); iavtestgyroz3(index,subwin) = iav(GYRO3Z(index1 :index2 ));
            subwin = subwin + 1;
        end
        index1 = index1 + (Nwin - Novrlp);
        index2 = index1 + Nwin - 1;
        nbwindows = nbwindows + 1;
    end
    index1 = indexmax + 1;
    index2 = index1 + Nwin - 1;
    %disp(nbwindows)
    nbwindows = 0;
    %disp(index)
end
message = strcat('Test: Last Index = ',num2str(index2-Nwin));
disp(message);

if (mode == 0) %raw, without gyro
    input_imu1 = [meantestpitch1,meantestroll1,meantestyaw1];
    input_imu2 = [meantestpitch2,meantestroll2];
    input_imu3 = [meantestpitch3,meantestroll3];
elseif (mode == 1) %raw, with gyro
    input_imu1 = [meantestpitch1,meantestroll1,meantestyaw1,meantestgyrox1,meantestgyroy1,meantestgyroz1];
    input_imu2 = [meantestpitch2,meantestroll2,meantestgyrox2,meantestgyroy2,meantestgyroz2];
    input_imu3 = [meantestpitch3,meantestroll3,meantestgyrox3,meantestgyroy3,meantestgyroz3];
elseif (mode == 2) %extracted input v1, with gyro
    input_imu1 = [meantestpitch1,maxtestpitch1,mintestpitch1,iavtestpitch1,meantestroll1,maxtestroll1,mintestroll1,iavtestroll1,meantestyaw1,maxtestyaw1,mintestyaw1,iavtestyaw1,meantestgyrox1,maxtestgyrox1,mintestgyrox1,iavtestgyrox1,meantestgyroy1,maxtestgyroy1,mintestgyroy1,iavtestgyroy1,meantestgyroz1,maxtestgyroz1,mintestgyroz1,iavtestgyroz1];
    input_imu2 = [meantestpitch2,maxtestpitch2,mintestpitch2,iavtestpitch2,meantestroll2,maxtestroll2,mintestroll2,iavtestroll2,meantestgyrox2,maxtestgyrox2,mintestgyrox2,iavtestgyrox2,meantestgyroy2,maxtestgyroy2,mintestgyroy2,iavtestgyroy2,meantestgyroz2,maxtestgyroz2,mintestgyroz2,iavtestgyroz2];
    input_imu3 = [meantestpitch3,maxtestpitch3,mintestpitch3,iavtestpitch3,meantestroll3,maxtestroll3,mintestroll3,iavtestroll3,meantestgyrox3,maxtestgyrox3,mintestgyrox3,iavtestgyrox3,meantestgyroy3,maxtestgyroy3,mintestgyroy3,iavtestgyroy3,meantestgyroz3,maxtestgyroz3,mintestgyroz3,iavtestgyroz3];
end

if (nbimuused == 2)
    input = [input_imu1,input_imu2];
elseif (nbimuused == 3)
    input = [input_imu1,input_imu2,input_imu3];
end

disp('Testing: Feature Extraction Done')
%% Prediction
error = 0; output = 0;
for t = 1:length(input)
    output(t) = predict(LearnMotion_lda,input(t,:));
    if output(t) ~= labeltest(t)
        error = error + 1;
    end
end

disp('Testing: Prediction Done')

acc = (1-(error/length(output)))*100;
disp('Accuracy LDA')
disp(acc)
precision = acc;
%%
%% Order labels 2 and 3
for ip = 1:length(labeltest)
    if (labeltest(ip) == 2)
        labeltest(ip) = 3;
    elseif (labeltest(ip) == 3)
        labeltest(ip) = 2;
    end
    if (output(ip) == 2)
        output(ip) = 3;
    elseif (output(ip) == 3)
        output(ip) = 2;
    end
end
%%
%figure
%plot(output)
%Build Confusion Matrix
test_class = unique(labeltest);
matrix_size = length(test_class);
lda_matrix = zeros(matrix_size,matrix_size);
count = 0;
for c = 1:matrix_size
    current_class = test_class(c);
    disp(current_class)
    for t = 1:length(labeltest)
        if (labeltest(t) == current_class)
            count = count + 1;
            lda_matrix(current_class+1,output(t)+1) = lda_matrix(current_class+1,output(t)+1) + 1; 
        end
    end
    count = 0;
end
labels = {'0','1','2','3','4','5'};%,'6','7','8'};
%labels = num2str(test_class);
figure
plotConfMat(lda_matrix',labels);
title(data)