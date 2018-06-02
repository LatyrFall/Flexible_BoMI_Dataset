function precision = build_dataset_v4(data,nbimuused,usegyro)
%clear
%close
%clc
%%
%%%data = 'user1p.mat';
load(data);
%%%nbimuused = 2;
%% training
size = length(Pitch1Raw(1:end))*1/3;
labeltrain = 0;
meantrainpitch1 = 0; meantrainpitch2 = 0; meantrainpitch3 = 0;
meantrainroll1 = 0;  meantrainroll2 = 0;  meantrainroll3 = 0;
meantrainyaw1 = 0;   meantrainyaw2 = 0;   meantrainyaw3 = 0;
meantraingyrox1 = 0; meantraingyroy1 = 0; meantraingyroz1 = 0;
meantraingyrox2 = 0; meantraingyroy2 = 0; meantraingyroz2 = 0;
meantraingyrox3 = 0; meantraingyroy3 = 0; meantraingyroz3 = 0;
index = 1;
k = 1;
while k <= size
    labeltrain (index) = Etiquette(index);
    meantrainpitch1(index) = mean(Pitch1Raw(index));meantrainpitch2(index) = mean(Pitch2Raw(index));meantrainpitch3(index) = mean(Pitch3Raw(index));
    meantrainroll1(index) = mean(Roll1Raw(index));meantrainroll2(index) = mean(Roll2Raw(index));meantrainroll3(index) = mean(Roll3Raw(index));
    meantrainyaw1(index) = mean(Yaw1Raw(index));meantrainyaw2(index) = mean(Yaw2Raw(index));meantrainyaw3(index) = mean(Yaw3Raw(index));
    meantraingyrox1(index) = mean(GYRO1X(index )); meantraingyrox2(index) = mean(GYRO2X(index )); meantraingyrox3(index) = mean(GYRO3X(index ));
    meantraingyroy1(index) = mean(GYRO1Y(index )); meantraingyroy2(index) = mean(GYRO2Y(index )); meantraingyroy3(index) = mean(GYRO3Y(index ));
    meantraingyroz1(index) = mean(GYRO1Z(index )); meantraingyroz2(index) = mean(GYRO2Z(index )); meantraingyroz3(index) = mean(GYRO3Z(index ));
    index = index + 1;
    k = k + 1;
end
index = 1;
k = 1;
if (usegyro == 1)
    features_imu1 = [meantrainpitch1',meantrainroll1',meantrainyaw1',meantraingyrox1',meantraingyroy1',meantraingyroz1'];
elseif (usegyro == 0)
    features_imu1 = [meantrainpitch1',meantrainroll1',meantrainyaw1'];
end
features_imu2 = [meantrainpitch2',meantrainroll2'];
features_imu3 = [meantrainpitch3',meantrainroll3'];
if (nbimuused == 2)
    features = [features_imu1,features_imu2];%,features_imu3];
elseif (nbimuused == 3)
    features = [features_imu1,features_imu2,features_imu3];
end
LearnMotion_lda = fitcdiscr(features,labeltrain');
%% testing
load(data);
size = length(Pitch1Raw(1:end))*1/3;
if (nbimuused == 2)
    shift = 301*62;
elseif (nbimuused == 3)
    shift = 301*98;
end
labeltest = 0;
meantestpitch1 = 0; meantestpitch2 = 0; meantestpitch3 = 0;
meantestroll1 = 0;  meantestroll2 = 0;  meantestroll3 = 0;
meantestyaw1 = 0;   meantestyaw2 = 0;   meantestyaw3 = 0;
meantestgyrox1 = 0; meantestgyroy1 = 0; meantestgyroz1 = 0;
meantestgyrox2 = 0; meantestgyroy2 = 0; meantestgyroz2 = 0;
meantestgyrox3 = 0; meantestgyroy3 = 0; meantestgyroz3 = 0;
index = 1;
k = 1;
while k <= size
    labeltest (index) = Etiquette(index+shift);
    meantestpitch1(index) = mean(Pitch1Raw(index+shift));meantestpitch2(index) = mean(Pitch2Raw(index+shift));meantestpitch3(index) = mean(Pitch3Raw(index+shift));
    meantestroll1(index) = mean(Roll1Raw(index+shift));meantestroll2(index) = mean(Roll2Raw(index+shift));meantestroll3(index) = mean(Roll3Raw(index+shift));
    meantestyaw1(index) = mean(Yaw1Raw(index+shift));meantestyaw2(index) = mean(Yaw2Raw(index+shift));meantestyaw3(index) = mean(Yaw3Raw(index+shift));
    meantestgyrox1(index) = mean(GYRO1X(index+shift)); meantestgyrox2(index) = mean(GYRO2X(index+shift)); meantestgyrox3(index) = mean(GYRO3X(index+shift));
    meantestgyroy1(index) = mean(GYRO1Y(index+shift)); meantestgyroy2(index) = mean(GYRO2Y(index+shift)); meantestgyroy3(index) = mean(GYRO3Y(index+shift));
    meantestgyroz1(index) = mean(GYRO1Z(index+shift)); meantestgyroz2(index) = mean(GYRO2Z(index+shift)); meantestgyroz3(index) = mean(GYRO3Z(index+shift));
    index = index+ 1;
    k = k + 1;   
end
if (usegyro == 1)
    input_imu1 = [meantestpitch1',meantestroll1',meantestyaw1',meantestgyrox1',meantestgyroy1',meantestgyroz1'];
elseif (usegyro == 0)
    input_imu1 = [meantestpitch1',meantestroll1',meantestyaw1'];
end
input_imu2 = [meantestpitch2',meantestroll2'];
input_imu3 = [meantestpitch3',meantestroll3'];
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