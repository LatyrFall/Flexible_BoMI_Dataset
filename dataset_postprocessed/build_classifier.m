function model = build_classifier(data,nbimuused,mode,nwin,novrlp)
%clear
%close
%clc
%%
%data = 'user1p.mat';
load(data);
%nbimuused = 2;
%% training
Nwin = nwin;
Novrlp = novrlp;
size = length(Pitch1Raw(1:end))*1/2;
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

index = 1;
indexmax = -1;
a = -1;
k = 1;
jump = 0;
while k <= size
    if a ~= Etiquette(k)
        a = Etiquette(k);
        h = k;
        var = 0;
        while(h < size && var == 0)
            if a ~= Etiquette(h)
                var = 1;
            else
                h = h + 1;
            end
        end
        indexmax = h-1;
        if (h == size)
            indexmax = h;
        end
        %disp(indexmax)
    end
    jump = 0;
    index1 = k; index2 = k + Nwin - 1;
    if index2 > indexmax
        jump =  indexmax - index1;
        index2 = indexmax;
    else
        jump = 0;
    end
    if index2 <= indexmax && index1 ~= index2
        labeltrain (index) = Etiquette(index1);
        %mean
        meantrainpitch1(index) = mean(Pitch1Raw(index1:index2));meantrainpitch2(index) = mean(Pitch2Raw(index1:index2));meantrainpitch3(index) = mean(Pitch3Raw(index1:index2));
        meantrainroll1(index) = mean(Roll1Raw(index1:index2));meantrainroll2(index) = mean(Roll2Raw(index1:index2));meantrainroll3(index) = mean(Roll3Raw(index1:index2));
        meantrainyaw1(index) = mean(Yaw1Raw(index1:index2));meantrainyaw2(index) = mean(Yaw2Raw(index1:index2));meantrainyaw3(index) = mean(Yaw3Raw(index1:index2));
        meantraingyrox1(index) = mean(GYRO1X(index1:index2 )); meantraingyrox2(index) = mean(GYRO2X(index1 :index2 )); meantraingyrox3(index) = mean(GYRO3X(index1 :index2 ));
        meantraingyroy1(index) = mean(GYRO1Y(index1:index2 )); meantraingyroy2(index) = mean(GYRO2Y(index1 :index2 )); meantraingyroy3(index) = mean(GYRO3Y(index1 :index2 ));
        meantraingyroz1(index) = mean(GYRO1Z(index1:index2 )); meantraingyroz2(index) = mean(GYRO2Z(index1 :index2 )); meantraingyroz3(index) = mean(GYRO3Z(index1 :index2 ));
        %max
        maxtrainpitch1(index) = max(Pitch1Raw(index1:index2));maxtrainpitch2(index) = max(Pitch2Raw(index1:index2));maxtrainpitch3(index) = max(Pitch3Raw(index1:index2));
        maxtrainroll1(index) = max(Roll1Raw(index1:index2));maxtrainroll2(index) = max(Roll2Raw(index1:index2));maxtrainroll3(index) = max(Roll3Raw(index1:index2));
        maxtrainyaw1(index) = max(Yaw1Raw(index1:index2));maxtrainyaw2(index) = max(Yaw2Raw(index1:index2));maxtrainyaw3(index) = max(Yaw3Raw(index1:index2));
        maxtraingyrox1(index) = max(GYRO1X(index1:index2 )); maxtraingyrox2(index) = max(GYRO2X(index1 :index2 )); maxtraingyrox3(index) = max(GYRO3X(index1 :index2 ));
        maxtraingyroy1(index) = max(GYRO1Y(index1:index2 )); maxtraingyroy2(index) = max(GYRO2Y(index1 :index2 )); maxtraingyroy3(index) = max(GYRO3Y(index1 :index2 ));
        maxtraingyroz1(index) = max(GYRO1Z(index1:index2 )); maxtraingyroz2(index) = max(GYRO2Z(index1 :index2 )); maxtraingyroz3(index) = max(GYRO3Z(index1 :index2 ));
        %min
        mintrainpitch1(index) = min(Pitch1Raw(index1:index2));mintrainpitch2(index) = min(Pitch2Raw(index1:index2));mintrainpitch3(index) = min(Pitch3Raw(index1:index2));
        mintrainroll1(index) = min(Roll1Raw(index1:index2));mintrainroll2(index) = min(Roll2Raw(index1:index2));mintrainroll3(index) = min(Roll3Raw(index1:index2));
        mintrainyaw1(index) = min(Yaw1Raw(index1:index2));mintrainyaw2(index) = min(Yaw2Raw(index1:index2));mintrainyaw3(index) = min(Yaw3Raw(index1:index2));
        mintraingyrox1(index) = min(GYRO1X(index1:index2 )); mintraingyrox2(index) = min(GYRO2X(index1 :index2 )); mintraingyrox3(index) = min(GYRO3X(index1 :index2 ));
        mintraingyroy1(index) = min(GYRO1Y(index1:index2 )); mintraingyroy2(index) = min(GYRO2Y(index1 :index2 )); mintraingyroy3(index) = min(GYRO3Y(index1 :index2 ));
        mintraingyroz1(index) = min(GYRO1Z(index1:index2 )); mintraingyroz2(index) = min(GYRO2Z(index1 :index2 )); mintraingyroz3(index) = min(GYRO3Z(index1 :index2 ));
        %mad
        madtrainpitch1(index) = mad(Pitch1Raw(index1:index2));madtrainpitch2(index) = mad(Pitch2Raw(index1:index2));madtrainpitch3(index) = mad(Pitch3Raw(index1:index2));
        madtrainroll1(index) = mad(Roll1Raw(index1:index2));madtrainroll2(index) = mad(Roll2Raw(index1:index2));madtrainroll3(index) = mad(Roll3Raw(index1:index2));
        madtrainyaw1(index) = mad(Yaw1Raw(index1:index2));madtrainyaw2(index) = mad(Yaw2Raw(index1:index2));madtrainyaw3(index) = mad(Yaw3Raw(index1:index2));
        madtraingyrox1(index) = mad(GYRO1X(index1:index2 )); madtraingyrox2(index) = mad(GYRO2X(index1 :index2 )); madtraingyrox3(index) = mad(GYRO3X(index1 :index2 ));
        madtraingyroy1(index) = mad(GYRO1Y(index1:index2 )); madtraingyroy2(index) = mad(GYRO2Y(index1 :index2 )); madtraingyroy3(index) = mad(GYRO3Y(index1 :index2 ));
        madtraingyroz1(index) = mad(GYRO1Z(index1:index2 )); madtraingyroz2(index) = mad(GYRO2Z(index1 :index2 )); madtraingyroz3(index) = mad(GYRO3Z(index1 :index2 ));
        %iav
        iavtrainpitch1(index) = iav(Pitch1Raw(index1:index2));iavtrainpitch2(index) = iav(Pitch2Raw(index1:index2));iavtrainpitch3(index) = iav(Pitch3Raw(index1:index2));
        iavtrainroll1(index) = iav(Roll1Raw(index1:index2));iavtrainroll2(index) = iav(Roll2Raw(index1:index2));iavtrainroll3(index) = iav(Roll3Raw(index1:index2));
        iavtrainyaw1(index) = iav(Yaw1Raw(index1:index2));iavtrainyaw2(index) = iav(Yaw2Raw(index1:index2));iavtrainyaw3(index) = iav(Yaw3Raw(index1:index2));
        iavtraingyrox1(index) = iav(GYRO1X(index1:index2 )); iavtraingyrox2(index) = iav(GYRO2X(index1 :index2 )); iavtraingyrox3(index) = iav(GYRO3X(index1 :index2 ));
        iavtraingyroy1(index) = iav(GYRO1Y(index1:index2 )); iavtraingyroy2(index) = iav(GYRO2Y(index1 :index2 )); iavtraingyroy3(index) = iav(GYRO3Y(index1 :index2 ));
        iavtraingyroz1(index) = iav(GYRO1Z(index1:index2 )); iavtraingyroz2(index) = iav(GYRO2Z(index1 :index2 )); iavtraingyroz3(index) = iav(GYRO3Z(index1 :index2 ));
        %%%%%%
        index = index + 1;
    end
    if jump == 0
        k = k + (Nwin-Novrlp);
    else
        k = k + jump;
    end
end

if (mode == 0) %raw, without gyro
    features_imu1 = [meantrainpitch1',meantrainroll1',meantrainyaw1'];
    features_imu2 = [meantrainpitch2',meantrainroll2'];
    features_imu3 = [meantrainpitch3',meantrainroll3'];
elseif (mode == 1) %raw, with gyro
    features_imu1 = [meantrainpitch1',meantrainroll1',meantrainyaw1',meantraingyrox1',meantraingyroy1',meantraingyroz1'];
    features_imu2 = [meantrainpitch2',meantrainroll2'];
    features_imu3 = [meantrainpitch3',meantrainroll3'];
elseif (mode == 2) %extracted features v1, with gyro
    %features_imu1 = [meantrainpitch1',madtrainpitch1',iavtrainpitch1',meantrainroll1',madtrainroll1',iavtrainroll1',meantrainyaw1',madtrainyaw1',iavtrainyaw1',meantraingyrox1',madtraingyrox1',iavtraingyrox1',meantraingyroy1',madtraingyroy1',iavtraingyroy1',meantraingyroz1',madtraingyroz1',iavtraingyroz1'];
    features_imu1 = [meantrainpitch1',iavtrainpitch1',meantrainroll1',iavtrainroll1',meantrainyaw1',iavtrainyaw1',meantraingyrox1',iavtraingyrox1',meantraingyroy1',iavtraingyroy1',meantraingyroz1',iavtraingyroz1'];
    features_imu2 = [meantrainpitch2',madtrainpitch2',iavtrainpitch2'];
    features_imu3 = [meantrainpitch3',madtrainpitch3',iavtrainpitch3'];
elseif (mode == 3) %extracted features v2, without gyro
    features_imu1 = [meantrainpitch1',madtrainpitch1',iavtrainpitch1',meantrainroll1',madtrainroll1',iavtrainroll1',meantrainyaw1',madtrainyaw1',iavtrainyaw1'];
    features_imu2 = [meantrainpitch2',madtrainpitch2',iavtrainpitch2',meantrainroll2',madtrainroll2',iavtrainroll2'];
    features_imu3 = [meantrainpitch3',madtrainpitch3',iavtrainpitch3',meantrainroll3',madtrainroll3',iavtrainroll3'];
elseif (mode == 4) %extracted features v2, with gyro
    features_imu1 = [meantrainpitch1',madtrainpitch1',iavtrainpitch1',meantrainroll1',madtrainroll1',iavtrainroll1',meantrainyaw1',madtrainyaw1',iavtrainyaw1',meantraingyrox1',madtraingyrox1',iavtraingyrox1',meantraingyroy1',madtraingyroy1',iavtraingyroy1',meantraingyroz1',madtraingyroz1',iavtraingyroz1'];
    features_imu2 = [meantrainpitch2',madtrainpitch2',iavtrainpitch2',meantrainroll2',madtrainroll2',iavtrainroll2'];
    features_imu3 = [meantrainpitch3',madtrainpitch3',iavtrainpitch3',meantrainroll3',madtrainroll3',iavtrainroll3'];
end

if (nbimuused == 2)
    features = [features_imu1,features_imu2];%,features_imu3];
elseif (nbimuused == 3)
    features = [features_imu1,features_imu2,features_imu3];
end
LearnMotion_lda = fitcdiscr(features,labeltrain');
model = LearnMotion_lda;