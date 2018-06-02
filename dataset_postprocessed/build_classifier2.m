function model = build_classifier2(data,nbimuused,usegyro)
%%
% load(data);
% %% training
% size = length(Pitch1Raw(1:end))*1/3-12*301;
% %size = length(Pitch1Raw(1:end))*1/2;
% labeltrain = 0;
% meantrainpitch1 = 0; meantrainpitch2 = 0; meantrainpitch3 = 0;
% meantrainroll1 = 0;  meantrainroll2 = 0;  meantrainroll3 = 0;
% meantrainyaw1 = 0;   meantrainyaw2 = 0;   meantrainyaw3 = 0;
% meantraingyrox1 = 0; meantraingyroy1 = 0; meantraingyroz1 = 0;
% meantraingyrox2 = 0; meantraingyroy2 = 0; meantraingyroz2 = 0;
% meantraingyrox3 = 0; meantraingyroy3 = 0; meantraingyroz3 = 0;
% index = 1;
% k = 1;
% while k <= size
%     labeltrain (index) = Etiquette(index);
%     meantrainpitch1(index) = mean(Pitch1Raw(index));meantrainpitch2(index) = mean(Pitch2Raw(index));meantrainpitch3(index) = mean(Pitch3Raw(index));
%     meantrainroll1(index) = mean(Roll1Raw(index));meantrainroll2(index) = mean(Roll2Raw(index));meantrainroll3(index) = mean(Roll3Raw(index));
%     meantrainyaw1(index) = mean(Yaw1Raw(index));meantrainyaw2(index) = mean(Yaw2Raw(index));meantrainyaw3(index) = mean(Yaw3Raw(index));
%     meantraingyrox1(index) = mean(GYRO1X(index )); meantraingyrox2(index) = mean(GYRO2X(index )); meantraingyrox3(index) = mean(GYRO3X(index ));
%     meantraingyroy1(index) = mean(GYRO1Y(index )); meantraingyroy2(index) = mean(GYRO2Y(index )); meantraingyroy3(index) = mean(GYRO3Y(index ));
%     meantraingyroz1(index) = mean(GYRO1Z(index )); meantraingyroz2(index) = mean(GYRO2Z(index )); meantraingyroz3(index) = mean(GYRO3Z(index ));
%     index = index + 1;
%     k = k + 1;
% end
% index = 1;
% k = 1;
% if (usegyro == 1)
%     features_imu1 = [meantrainpitch1',meantrainroll1',meantrainyaw1',meantraingyrox1',meantraingyroy1',meantraingyroz1'];
% elseif (usegyro == 0)
%     features_imu1 = [meantrainpitch1',meantrainroll1',meantrainyaw1'];
% end
% features_imu2 = [meantrainpitch2',meantrainroll2'];
% features_imu3 = [meantrainpitch3',meantrainroll3'];
% if (nbimuused==1)
%     features = [features_imu1];
% elseif (nbimuused == 2)
%     features = [features_imu1,features_imu2];%,features_imu3];
% elseif (nbimuused == 3)
%     features = [features_imu1,features_imu2,features_imu3];
% end
% LearnMotion_lda = fitcdiscr(features,labeltrain');
% model = LearnMotion_lda;
% end
load(data);
%% training
Nwin = 8;
Novrlp = 7;
size = 2*length(Pitch1Raw(1:end))/3;
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
mode = 2;
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

if (nbimuused == 1)
    features = [features_imu1];
elseif (nbimuused == 2)
    features = [features_imu1,features_imu2];%,features_imu3];
elseif (nbimuused == 3)
    features = [features_imu1,features_imu2,features_imu3];
end
LearnMotion_lda = fitcdiscr(features,labeltrain');
model = LearnMotion_lda;
disp('Training: Model Generation Done')
