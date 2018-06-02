function precision = build_dataset_v3(data,nbimuused,mode,nwin,novrlp)
%clear
%close
%clc
%%
%data = 'user1p.mat';
addpath('plotConfMat')
load(data);
%nbimuused = 2;
%% training
yt = 0;
Nwin = nwin;
Novrlp = novrlp;
size = 2*length(Pitch1Raw(1:end))*1/3;
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
        if index2 - index1 + 1 == 8
            for yt = 1:2
                index2 = index1 + 4*yt - 1;
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
                index = index + 1;
            end
        else
            labeltrain (index) = Etiquette(index1);
            %disp(index1)
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
            index = index + 1;
        end
        %%%%%%
        %index = index + 1;
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
    features_imu2 = [meantrainpitch2',meantrainroll2',meantraingyrox2',meantraingyroy2',meantraingyroz2'];
    features_imu3 = [meantrainpitch3',meantrainroll3',meantraingyrox3',meantraingyroy3',meantraingyroz3'];
elseif (mode == 2) %extracted features v1, with gyro
    %features_imu1 = [meantrainpitch1',madtrainpitch1',iavtrainpitch1',meantrainroll1',madtrainroll1',iavtrainroll1',meantrainyaw1',madtrainyaw1',iavtrainyaw1',meantraingyrox1',madtraingyrox1',iavtraingyrox1',meantraingyroy1',madtraingyroy1',iavtraingyroy1',meantraingyroz1',madtraingyroz1',iavtraingyroz1'];
    features_imu1 = [meantrainpitch1',maxtrainpitch1',mintrainpitch1',iavtrainpitch1',meantrainroll1',maxtrainroll1',mintrainroll1',iavtrainroll1',meantrainyaw1',maxtrainyaw1',mintrainyaw1',iavtrainyaw1',meantraingyrox1',maxtraingyrox1',mintraingyrox1',iavtraingyrox1',meantraingyroy1',maxtraingyroy1',mintraingyroy1',iavtraingyroy1',meantraingyroz1',maxtraingyroz1',mintraingyroz1',iavtraingyroz1'];
    features_imu2 = [meantrainpitch2',maxtrainpitch2',mintrainpitch2',iavtrainpitch2',meantrainroll2',maxtrainroll2',mintrainroll2',iavtrainroll2',meantraingyrox2',maxtraingyrox2',mintraingyrox2',iavtraingyrox2',meantraingyroy2',maxtraingyroy2',mintraingyroy2',iavtraingyroy2',meantraingyroz2',maxtraingyroz2',mintraingyroz2',iavtraingyroz2'];
    features_imu3 = [meantrainpitch3',maxtrainpitch3',mintrainpitch3',iavtrainpitch3',meantrainroll3',maxtrainroll3',mintrainroll3',iavtrainroll3',meantraingyrox3',maxtraingyrox3',mintraingyrox3',iavtraingyrox3',meantraingyroy3',maxtraingyroy3',mintraingyroy3',iavtraingyroy3',meantraingyroz3',maxtraingyroz3',mintraingyroz3',iavtraingyroz3'];
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
%%%%%%%%
index = 1;
indexmax = -1;
a = -1;
k = 1;
jump = 0;
while k <= size
    if a ~= Etiquette(k+shift)
        a = Etiquette(k+shift);
        h = k+shift;
        var = 0;
        while(h < size && var == 0)
            if a ~= Etiquette(h+shift)
                var = 1;
            else
                h = h + 1;
            end
        end
        indexmax = h-1;
        if (h == size)
            indexmax = h;
        end
    end
    index1 = k; index2 = k + Nwin - 1;
    if index2 >= indexmax
        jump =  indexmax - index1;
        index2 = indexmax;
    else
        jump = 0;
    end
    if index2 > size
        index2 = size;
    end
    if index2 <= indexmax && index1 ~= index2
        if index2 - index1 + 1 == 8
            for yt = 1:2
                index2 = index1 + 4*yt - 1;
                laabeltest (index) = Etiquette(index1);
                %mean
                meantestpitch1(index) = mean(Pitch1Raw(index1+shift:index2+shift));meantestpitch2(index) = mean(Pitch2Raw(index1+shift:index2+shift));meantestpitch3(index) = mean(Pitch3Raw(index1+shift:index2+shift));
                meantestroll1(index) = mean(Roll1Raw(index1+shift:index2+shift));meantestroll2(index) = mean(Roll2Raw(index1+shift:index2+shift));meantestroll3(index) = mean(Roll3Raw(index1+shift:index2+shift));
                meantestyaw1(index) = mean(Yaw1Raw(index1+shift:index2+shift));meantestyaw2(index) = mean(Yaw2Raw(index1+shift:index2+shift));meantestyaw3(index) = mean(Yaw3Raw(index1+shift:index2+shift));
                meantestgyrox1(index) = mean(GYRO1X(index1+shift:index2+shift )); meantestgyrox2(index) = mean(GYRO2X(index1 :index2 )); meantestgyrox3(index) = mean(GYRO3X(index1 :index2 ));
                meantestgyroy1(index) = mean(GYRO1Y(index1+shift:index2+shift )); meantestgyroy2(index) = mean(GYRO2Y(index1 :index2 )); meantestgyroy3(index) = mean(GYRO3Y(index1 :index2 ));
                meantestgyroz1(index) = mean(GYRO1Z(index1+shift:index2+shift )); meantestgyroz2(index) = mean(GYRO2Z(index1 :index2 )); meantestgyroz3(index) = mean(GYRO3Z(index1 :index2 ));
                %max
                maxtestpitch1(index) = max(Pitch1Raw(index1+shift:index2+shift));maxtestpitch2(index) = max(Pitch2Raw(index1+shift:index2+shift));maxtestpitch3(index) = max(Pitch3Raw(index1+shift:index2+shift));
                maxtestroll1(index) = max(Roll1Raw(index1+shift:index2+shift));maxtestroll2(index) = max(Roll2Raw(index1+shift:index2+shift));maxtestroll3(index) = max(Roll3Raw(index1+shift:index2+shift));
                maxtestyaw1(index) = max(Yaw1Raw(index1+shift:index2+shift));maxtestyaw2(index) = max(Yaw2Raw(index1+shift:index2+shift));maxtestyaw3(index) = max(Yaw3Raw(index1+shift:index2+shift));
                maxtestgyrox1(index) = max(GYRO1X(index1+shift:index2+shift )); maxtestgyrox2(index) = max(GYRO2X(index1 :index2 )); maxtestgyrox3(index) = max(GYRO3X(index1 :index2 ));
                maxtestgyroy1(index) = max(GYRO1Y(index1+shift:index2+shift )); maxtestgyroy2(index) = max(GYRO2Y(index1 :index2 )); maxtestgyroy3(index) = max(GYRO3Y(index1 :index2 ));
                maxtestgyroz1(index) = max(GYRO1Z(index1+shift:index2+shift )); maxtestgyroz2(index) = max(GYRO2Z(index1 :index2 )); maxtestgyroz3(index) = max(GYRO3Z(index1 :index2 ));
                %min
                mintestpitch1(index) = min(Pitch1Raw(index1+shift:index2+shift));mintestpitch2(index) = min(Pitch2Raw(index1+shift:index2+shift));mintestpitch3(index) = min(Pitch3Raw(index1+shift:index2+shift));
                mintestroll1(index) = min(Roll1Raw(index1+shift:index2+shift));mintestroll2(index) = min(Roll2Raw(index1+shift:index2+shift));mintestroll3(index) = min(Roll3Raw(index1+shift:index2+shift));
                mintestyaw1(index) = min(Yaw1Raw(index1+shift:index2+shift));mintestyaw2(index) = min(Yaw2Raw(index1+shift:index2+shift));mintestyaw3(index) = min(Yaw3Raw(index1+shift:index2+shift));
                mintestgyrox1(index) = min(GYRO1X(index1+shift:index2+shift )); mintestgyrox2(index) = min(GYRO2X(index1 :index2 )); mintestgyrox3(index) = min(GYRO3X(index1 :index2 ));
                mintestgyroy1(index) = min(GYRO1Y(index1+shift:index2+shift )); mintestgyroy2(index) = min(GYRO2Y(index1 :index2 )); mintestgyroy3(index) = min(GYRO3Y(index1 :index2 ));
                mintestgyroz1(index) = min(GYRO1Z(index1+shift:index2+shift )); mintestgyroz2(index) = min(GYRO2Z(index1 :index2 )); mintestgyroz3(index) = min(GYRO3Z(index1 :index2 ));
                %mad
                madtestpitch1(index) = mad(Pitch1Raw(index1+shift:index2+shift));madtestpitch2(index) = mad(Pitch2Raw(index1+shift:index2+shift));madtestpitch3(index) = mad(Pitch3Raw(index1+shift:index2+shift));
                madtestroll1(index) = mad(Roll1Raw(index1+shift:index2+shift));madtestroll2(index) = mad(Roll2Raw(index1+shift:index2+shift));madtestroll3(index) = mad(Roll3Raw(index1+shift:index2+shift));
                madtestyaw1(index) = mad(Yaw1Raw(index1+shift:index2+shift));madtestyaw2(index) = mad(Yaw2Raw(index1+shift:index2+shift));madtestyaw3(index) = mad(Yaw3Raw(index1+shift:index2+shift));
                madtestgyrox1(index) = mad(GYRO1X(index1+shift:index2+shift )); madtestgyrox2(index) = mad(GYRO2X(index1 :index2 )); madtestgyrox3(index) = mad(GYRO3X(index1 :index2 ));
                madtestgyroy1(index) = mad(GYRO1Y(index1+shift:index2+shift )); madtestgyroy2(index) = mad(GYRO2Y(index1 :index2 )); madtestgyroy3(index) = mad(GYRO3Y(index1 :index2 ));
                madtestgyroz1(index) = mad(GYRO1Z(index1+shift:index2+shift )); madtestgyroz2(index) = mad(GYRO2Z(index1 :index2 )); madtestgyroz3(index) = mad(GYRO3Z(index1 :index2 ));
                %iav
                iavtestpitch1(index) = iav(Pitch1Raw(index1+shift:index2+shift));iavtestpitch2(index) = iav(Pitch2Raw(index1+shift:index2+shift));iavtestpitch3(index) = iav(Pitch3Raw(index1+shift:index2+shift));
                iavtestroll1(index) = iav(Roll1Raw(index1+shift:index2+shift));iavtestroll2(index) = iav(Roll2Raw(index1+shift:index2+shift));iavtestroll3(index) = iav(Roll3Raw(index1+shift:index2+shift));
                iavtestyaw1(index) = iav(Yaw1Raw(index1+shift:index2+shift));iavtestyaw2(index) = iav(Yaw2Raw(index1+shift:index2+shift));iavtestyaw3(index) = iav(Yaw3Raw(index1+shift:index2+shift));
                iavtestgyrox1(index) = iav(GYRO1X(index1+shift:index2+shift )); iavtestgyrox2(index) = iav(GYRO2X(index1 :index2 )); iavtestgyrox3(index) = iav(GYRO3X(index1 :index2 ));
                iavtestgyroy1(index) = iav(GYRO1Y(index1+shift:index2+shift )); iavtestgyroy2(index) = iav(GYRO2Y(index1 :index2 )); iavtestgyroy3(index) = iav(GYRO3Y(index1 :index2 ));
                iavtestgyroz1(index) = iav(GYRO1Z(index1+shift:index2+shift )); iavtestgyroz2(index) = iav(GYRO2Z(index1 :index2 )); iavtestgyroz3(index) = iav(GYRO3Z(index1 :index2 ));
                index = index + 1;
            end
        else
            labeltest (index) = Etiquette(index1);
            %mean
            meantestpitch1(index) = mean(Pitch1Raw(index1+shift:index2+shift));meantestpitch2(index) = mean(Pitch2Raw(index1+shift:index2+shift));meantestpitch3(index) = mean(Pitch3Raw(index1+shift:index2+shift));
            meantestroll1(index) = mean(Roll1Raw(index1+shift:index2+shift));meantestroll2(index) = mean(Roll2Raw(index1+shift:index2+shift));meantestroll3(index) = mean(Roll3Raw(index1+shift:index2+shift));
            meantestyaw1(index) = mean(Yaw1Raw(index1+shift:index2+shift));meantestyaw2(index) = mean(Yaw2Raw(index1+shift:index2+shift));meantestyaw3(index) = mean(Yaw3Raw(index1+shift:index2+shift));
            meantestgyrox1(index) = mean(GYRO1X(index1+shift:index2+shift )); meantestgyrox2(index) = mean(GYRO2X(index1 :index2 )); meantestgyrox3(index) = mean(GYRO3X(index1 :index2 ));
            meantestgyroy1(index) = mean(GYRO1Y(index1+shift:index2+shift )); meantestgyroy2(index) = mean(GYRO2Y(index1 :index2 )); meantestgyroy3(index) = mean(GYRO3Y(index1 :index2 ));
            meantestgyroz1(index) = mean(GYRO1Z(index1+shift:index2+shift )); meantestgyroz2(index) = mean(GYRO2Z(index1 :index2 )); meantestgyroz3(index) = mean(GYRO3Z(index1 :index2 ));
            %max
            maxtestpitch1(index) = max(Pitch1Raw(index1+shift:index2+shift));maxtestpitch2(index) = max(Pitch2Raw(index1+shift:index2+shift));maxtestpitch3(index) = max(Pitch3Raw(index1+shift:index2+shift));
            maxtestroll1(index) = max(Roll1Raw(index1+shift:index2+shift));maxtestroll2(index) = max(Roll2Raw(index1+shift:index2+shift));maxtestroll3(index) = max(Roll3Raw(index1+shift:index2+shift));
            maxtestyaw1(index) = max(Yaw1Raw(index1+shift:index2+shift));maxtestyaw2(index) = max(Yaw2Raw(index1+shift:index2+shift));maxtestyaw3(index) = max(Yaw3Raw(index1+shift:index2+shift));
            maxtestgyrox1(index) = max(GYRO1X(index1+shift:index2+shift )); maxtestgyrox2(index) = max(GYRO2X(index1 :index2 )); maxtestgyrox3(index) = max(GYRO3X(index1 :index2 ));
            maxtestgyroy1(index) = max(GYRO1Y(index1+shift:index2+shift )); maxtestgyroy2(index) = max(GYRO2Y(index1 :index2 )); maxtestgyroy3(index) = max(GYRO3Y(index1 :index2 ));
            maxtestgyroz1(index) = max(GYRO1Z(index1+shift:index2+shift )); maxtestgyroz2(index) = max(GYRO2Z(index1 :index2 )); maxtestgyroz3(index) = max(GYRO3Z(index1 :index2 ));
            %min
            mintestpitch1(index) = min(Pitch1Raw(index1+shift:index2+shift));mintestpitch2(index) = min(Pitch2Raw(index1+shift:index2+shift));mintestpitch3(index) = min(Pitch3Raw(index1+shift:index2+shift));
            mintestroll1(index) = min(Roll1Raw(index1+shift:index2+shift));mintestroll2(index) = min(Roll2Raw(index1+shift:index2+shift));mintestroll3(index) = min(Roll3Raw(index1+shift:index2+shift));
            mintestyaw1(index) = min(Yaw1Raw(index1+shift:index2+shift));mintestyaw2(index) = min(Yaw2Raw(index1+shift:index2+shift));mintestyaw3(index) = min(Yaw3Raw(index1+shift:index2+shift));
            mintestgyrox1(index) = min(GYRO1X(index1+shift:index2+shift )); mintestgyrox2(index) = min(GYRO2X(index1 :index2 )); mintestgyrox3(index) = min(GYRO3X(index1 :index2 ));
            mintestgyroy1(index) = min(GYRO1Y(index1+shift:index2+shift )); mintestgyroy2(index) = min(GYRO2Y(index1 :index2 )); mintestgyroy3(index) = min(GYRO3Y(index1 :index2 ));
            mintestgyroz1(index) = min(GYRO1Z(index1+shift:index2+shift )); mintestgyroz2(index) = min(GYRO2Z(index1 :index2 )); mintestgyroz3(index) = min(GYRO3Z(index1 :index2 ));
            %mad
            madtestpitch1(index) = mad(Pitch1Raw(index1+shift:index2+shift));madtestpitch2(index) = mad(Pitch2Raw(index1+shift:index2+shift));madtestpitch3(index) = mad(Pitch3Raw(index1+shift:index2+shift));
            madtestroll1(index) = mad(Roll1Raw(index1+shift:index2+shift));madtestroll2(index) = mad(Roll2Raw(index1+shift:index2+shift));madtestroll3(index) = mad(Roll3Raw(index1+shift:index2+shift));
            madtestyaw1(index) = mad(Yaw1Raw(index1+shift:index2+shift));madtestyaw2(index) = mad(Yaw2Raw(index1+shift:index2+shift));madtestyaw3(index) = mad(Yaw3Raw(index1+shift:index2+shift));
            madtestgyrox1(index) = mad(GYRO1X(index1+shift:index2+shift )); madtestgyrox2(index) = mad(GYRO2X(index1 :index2 )); madtestgyrox3(index) = mad(GYRO3X(index1 :index2 ));
            madtestgyroy1(index) = mad(GYRO1Y(index1+shift:index2+shift )); madtestgyroy2(index) = mad(GYRO2Y(index1 :index2 )); madtestgyroy3(index) = mad(GYRO3Y(index1 :index2 ));
            madtestgyroz1(index) = mad(GYRO1Z(index1+shift:index2+shift )); madtestgyroz2(index) = mad(GYRO2Z(index1 :index2 )); madtestgyroz3(index) = mad(GYRO3Z(index1 :index2 ));
            %iav
            iavtestpitch1(index) = iav(Pitch1Raw(index1+shift:index2+shift));iavtestpitch2(index) = iav(Pitch2Raw(index1+shift:index2+shift));iavtestpitch3(index) = iav(Pitch3Raw(index1+shift:index2+shift));
            iavtestroll1(index) = iav(Roll1Raw(index1+shift:index2+shift));iavtestroll2(index) = iav(Roll2Raw(index1+shift:index2+shift));iavtestroll3(index) = iav(Roll3Raw(index1+shift:index2+shift));
            iavtestyaw1(index) = iav(Yaw1Raw(index1+shift:index2+shift));iavtestyaw2(index) = iav(Yaw2Raw(index1+shift:index2+shift));iavtestyaw3(index) = iav(Yaw3Raw(index1+shift:index2+shift));
            iavtestgyrox1(index) = iav(GYRO1X(index1+shift:index2+shift )); iavtestgyrox2(index) = iav(GYRO2X(index1 :index2 )); iavtestgyrox3(index) = iav(GYRO3X(index1 :index2 ));
            iavtestgyroy1(index) = iav(GYRO1Y(index1+shift:index2+shift )); iavtestgyroy2(index) = iav(GYRO2Y(index1 :index2 )); iavtestgyroy3(index) = iav(GYRO3Y(index1 :index2 ));
            iavtestgyroz1(index) = iav(GYRO1Z(index1+shift:index2+shift )); iavtestgyroz2(index) = iav(GYRO2Z(index1 :index2 )); iavtestgyroz3(index) = iav(GYRO3Z(index1 :index2 )); 
            index = index + 1;
        end
        %%%%%%
        %index = index+ 1;
    end
    if jump == 0
        k = k + (Nwin-Novrlp);
    else
        k = k + jump;
    end    
end

if (mode == 0) %raw, without gyro
    input_imu1 = [meantestpitch1',meantestroll1',meantestyaw1'];
    input_imu2 = [meantestpitch2',meantestroll2'];
    input_imu3 = [meantestpitch3',meantestroll3'];
elseif (mode == 1) %raw, with gyro
    input_imu1 = [meantestpitch1',meantestroll1',meantestyaw1',meantestgyrox1',meantestgyroy1',meantestgyroz1'];
    input_imu2 = [meantestpitch2',meantestroll2',meantestgyrox2',meantestgyroy2',meantestgyroz2'];
    input_imu3 = [meantestpitch3',meantestroll3',meantestgyrox3',meantestgyroy3',meantestgyroz3'];
elseif (mode == 2) %extracted input v1, with gyro
    %input_imu1 = [meantestpitch1',madtestpitch1',iavtestpitch1',meantestroll1',madtestroll1',iavtestroll1',meantestyaw1',madtestyaw1',iavtestyaw1',meantestgyrox1',madtestgyrox1',iavtestgyrox1',meantestgyroy1',madtestgyroy1',iavtestgyroy1',meantestgyroz1',madtestgyroz1',iavtestgyroz1'];
    input_imu1 = [meantestpitch1',maxtestpitch1',mintestpitch1',iavtestpitch1',meantestroll1',maxtestroll1',mintestroll1',iavtestroll1',meantestyaw1',maxtestyaw1',mintestyaw1',iavtestyaw1',meantestgyrox1',maxtestgyrox1',mintestgyrox1',iavtestgyrox1',meantestgyroy1',maxtestgyroy1',mintestgyroy1',iavtestgyroy1',meantestgyroz1',maxtestgyroz1',mintestgyroz1',iavtestgyroz1'];
    input_imu2 = [meantestpitch2',maxtestpitch2',mintestpitch2',iavtestpitch2',meantestroll2',maxtestroll2',mintestroll2',iavtestroll2',meantestgyrox2',maxtestgyrox2',mintestgyrox2',iavtestgyrox2',meantestgyroy2',maxtestgyroy2',mintestgyroy2',iavtestgyroy2',meantestgyroz2',maxtestgyroz2',mintestgyroz2',iavtestgyroz2'];
    input_imu3 = [meantestpitch3',maxtestpitch3',mintestpitch3',iavtestpitch3',meantestroll3',maxtestroll3',mintestroll3',iavtestroll3',meantestgyrox3',maxtestgyrox3',mintestgyrox3',iavtestgyrox3',meantestgyroy3',maxtestgyroy3',mintestgyroy3',iavtestgyroy3',meantestgyroz3',maxtestgyroz3',mintestgyroz3',iavtestgyroz3'];
elseif (mode == 3) %extracted input v2, without gyro
    input_imu1 = [meantestpitch1',madtestpitch1',iavtestpitch1',meantestroll1',madtestroll1',iavtestroll1',meantestyaw1',madtestyaw1',iavtestyaw1'];
    input_imu2 = [meantestpitch2',madtestpitch2',iavtestpitch2',meantestroll2',madtestroll2',iavtestroll2'];
    input_imu3 = [meantestpitch3',madtestpitch3',iavtestpitch3',meantestroll3',madtestroll3',iavtestroll3'];
elseif (mode == 4) %extracted features v2, with gyro
    input_imu1 = [meantestpitch1',madtestpitch1',iavtestpitch1',meantestroll1',madtestroll1',iavtestroll1',meantestyaw1',madtestyaw1',iavtestyaw1',meantestgyrox1',madtestgyrox1',iavtestgyrox1',meantestgyroy1',madtestgyroy1',iavtestgyroy1',meantestgyroz1',madtestgyroz1',iavtestgyroz1'];
    input_imu2 = [meantestpitch2',madtestpitch2',iavtestpitch2',meantestroll2',madtestroll2',iavtestroll2'];
    input_imu3 = [meantestpitch3',madtestpitch3',iavtestpitch3',meantestroll3',madtestroll3',iavtestroll3'];
end

if (nbimuused == 2)
    input = [input_imu1,input_imu2];
elseif (nbimuused == 3)
    input = [input_imu1,input_imu2,input_imu3];
end
%%
error = 0; output = 0;
for t = 1:length(input)
    output(t) = predict(LearnMotion_lda,input(t,:));
    if output(t) ~= labeltest(t)
        error = error + 1;
    end
end

acc = (1-(error/length(output)))*100;
disp('Accuracy LDA')
disp(acc)
precision = acc;

% %% Order labels 2 and 3
% for ip = 1:length(labeltest)
%     if (labeltest(ip) == 2)
%         labeltest(ip) = 3;
%     elseif (labeltest(ip) == 3)
%         labeltest(ip) = 2;
%     end
%     if (output(ip) == 2)
%         output(ip) = 3;
%     elseif (output(ip) == 3)
%         output(ip) = 2;
%     end
% end
%%
% % figure
% % plot(output)
%% Build Confusion Matrix
% test_class = unique(labeltest);
% matrix_size = length(test_class);
% lda_matrix = zeros(matrix_size,matrix_size);
% count = 0;
% for c = 1:matrix_size
%     current_class = test_class(c);
%     %disp(current_class)
%     for t = 1:length(labeltest)
%         if (labeltest(t) == current_class)
%             count = count + 1;
%             lda_matrix(current_class+1,output(t)+1) = lda_matrix(current_class+1,output(t)+1) + 1; 
%         end
%     end
%     count = 0;
% end
% labels = {'0','1','2','3','4','5'};%,'6','7','8'};
% %labels = num2str(test_class);
% figure
% plotConfMat(lda_matrix',labels);
% title(data)