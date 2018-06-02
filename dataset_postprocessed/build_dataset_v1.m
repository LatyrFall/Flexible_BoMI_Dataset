clear
close
clc
load('user1p.mat')
%% compute yaw angle with gyro only
gyro_gain = 2000/32768; period = 1/62;
Yaw1Gyro0 = 0; Yaw2Gyro0 = 0; Yaw3Gyro0 = 0;
drift1 = 0/period; drift2 =0/period; drift3 = 0/period;
mean1 = 0; mean2 = 0; mean3 = 0;

for i = 1:length(Yaw1Raw)
    Yaw1Gyro(i) = Yaw1Gyro0 + ((gyro_gain * (GYRO1X(i)-mean1)) - drift1) * period;
    Yaw2Gyro(i) = Yaw2Gyro0 + ((gyro_gain * (GYRO2X(i)-mean2)) - drift2) * period;
    Yaw3Gyro(i) = Yaw3Gyro0 + ((gyro_gain * (GYRO3X(i)-mean3)) - drift3) * period;
    Yaw1Gyro0 = Yaw1Gyro(i); Yaw2Gyro0 = Yaw2Gyro(i); Yaw3Gyro0 = Yaw3Gyro(i);
end
%% build dataset
nbc1 = 0; nbc2 = 0; nbc3 = 0; nbc4 = 0;
nbc5 = 0; nbc6 = 0; nbc7 = 0; nbc8 = 0;
line = 0; col  = 0; class = 0; k = 1; j = 0; index = 1; size = 0; order = 0;
while k <= length(Etiquette)
    if (Etiquette(k) == 1)
        nbc1 = nbc1 + 1;
        class = 1;
        line = nbc1;
        order = 1;
    elseif (Etiquette(k) == 2)
        nbc2 = nbc2 + 1;
        class = 2;
        line = nbc2;
        order = 3;
    elseif (Etiquette(k) == 3)
        nbc3 = nbc3 + 1;
        class = 3;
        line = nbc3;
        order = 2;
    elseif (Etiquette(k) == 4)
        nbc4 = nbc4 + 1;
        class = 4;
        line = nbc4;
        order = 4;
    elseif (Etiquette(k) == 5)
        nbc5 = nbc5 + 1;
        class = 5;
        line = nbc5;
        order = 5;
    elseif (Etiquette(k) == 6)
        nbc6 = nbc6 + 1;
        class = 6;
        line = nbc6;
        order = 6;
    elseif (Etiquette(k) == 7)
        nbc7 = nbc7 + 1;
        class = 7;
        line = nbc7;
        order = 7;
    elseif (Etiquette(k) == 8)
        nbc8 = nbc8 + 1;
        class = 8;
        line = nbc8;
        order = 8;
    end
    if (line ~= 0)
        j = k;
        while Etiquette(j+1) == class
            j = j + 1;
        end
        col = j;
        size = length(Etiquette(k:col)) - 1;
        index = (order-1)*(size+1) + 1;
        etiq(line,index:index+size)   = Etiquette(k:col);
        p_imu1(line,index:index+size) = Pitch1Raw(k:col); p_imu2(line,index:index+size) = Pitch2Raw(k:col); p_imu3(line,index:index+size) = Pitch3Raw(k:col);
        r_imu1(line,index:index+size) = Roll1Raw(k:col);  r_imu2(line,index:index+size) = Roll2Raw(k:col);  r_imu3(line,index:index+size) = Roll3Raw(k:col);
        y_imu1(line,index:index+size) = Yaw1Raw(k:col);   y_imu2(line,index:index+size) = Yaw2Raw(k:col);   y_imu3(line,index:index+size) = Yaw3Raw(k:col);
        ygyro_imu1(line,index:index+size) = Yaw1Gyro(k:col);  ygyro_imu2(line,index:index+size) = Yaw2Gyro(k:col);   ygyro_imu3(line,index:index+size) = Yaw3Gyro(k:col);
        magx_imu1 (line,index:index+size) = MAG1X(k:col); magy_imu1(line,index:index+size) = MAG1Y(k:col);  magz_imu1(line,index:index+size) = MAG1Z(k:col);
        magx_imu2 (line,index:index+size) = MAG2X(k:col); magy_imu2(line,index:index+size) = MAG2Y(k:col);  magz_imu2(line,index:index+size) = MAG2Z(k:col);
        magx_imu3 (line,index:index+size) = MAG3X(k:col); magy_imu3(line,index:index+size) = MAG3Y(k:col);  magz_imu3(line,index:index+size) = MAG3Z(k:col);
        k = j+1;
        col = 0;
        class = 0;
        line = 0;
    else
        k = k + 1;
    end
end
k = 1; j = 1; size = 0;
line = 0; size_0 = 0;
diffsize = 0;
while k <= length(Etiquette)
    if (Etiquette(k) == 0)
        j = k; size = 0;
        while (j+1 <= length(Etiquette) && Etiquette(j+1) == 0)
            j = j + 1;
            size = size + 1;
        end
        %if (j+1 <= length(Etiquette))
        %    disp(Etiquette(j+1))
        %end
        line = line + 1;
        index = 1;
        %disp(line)
        etiq_0(line,index:index+size)   = Etiquette(k:j); size_0(line) = size+1;
        p_imu1_0(line,index:index+size) = Pitch1Raw(k:j); p_imu2_0(line,index:index+size) = Pitch2Raw(k:j); p_imu3_0(line,index:index+size) = Pitch3Raw(k:j);
        r_imu1_0(line,index:index+size) = Roll1Raw(k:j);  r_imu2_0(line,index:index+size) = Roll2Raw(k:j);  r_imu3_0(line,index:index+size) = Roll3Raw(k:j);
        y_imu1_0(line,index:index+size) = Yaw1Raw(k:j);   y_imu2_0(line,index:index+size) = Yaw2Raw(k:j);   y_imu3_0(line,index:index+size) = Yaw3Raw(k:j);
        ygyro_imu1_0(line,index:index+size) = Yaw1Gyro(k:j);  ygyro_imu2_0(line,index:index+size) = Yaw2Gyro(k:j);   ygyro_imu3_0(line,index:index+size) = Yaw3Gyro(k:j);
        magx_imu1_0 (line,index:index+size) = MAG1X(k:j); magy_imu1_0(line,index:index+size) = MAG1Y(k:j);  magz_imu1_0(line,index:index+size) = MAG1Z(k:j);
        magx_imu2_0 (line,index:index+size) = MAG2X(k:j); magy_imu2_0(line,index:index+size) = MAG2Y(k:j);  magz_imu2_0(line,index:index+size) = MAG2Z(k:j);
        magx_imu3_0 (line,index:index+size) = MAG3X(k:j); magy_imu3_0(line,index:index+size) = MAG3Y(k:j);  magz_imu3_0(line,index:index+size) = MAG3Z(k:j);
        k = j+1;
    else
        k = k+1;
    end
end
%%
nb_examples = length(p_imu1(:,1));
nb_neutral  = length(p_imu1_0(:,1));
% figure
% subplot(3,1,1)
% for i = 1:nb_examples
%     plot(p_imu1(i,:));
%     hold on
%     plot(r_imu1(i,:),'r');
%     plot(y_imu1(i,:),'g');
%     plot(etiq(i,:)*20-40,'Color','black');
% end
% subplot(3,1,2)
% for i = 1:nb_examples
%     plot(p_imu2(i,:));
%     hold on
%     plot(r_imu2(i,:),'r');
%     plot(y_imu2(i,:),'g');
%     plot(etiq(i,:)*20-40,'Color','black');
% end
% subplot(3,1,3)
% for i = 1:nb_examples
%     plot(p_imu3(i,:));
%     hold on
%     plot(r_imu3(i,:),'r');
%     plot(y_imu3(i,:),'g');
%     plot(etiq(i,:)*20-40,'Color','black');
% end
% figure
% subplot(3,1,1)
% for i = 1:nb_neutral
%     plot(p_imu1_0(i,1:size_0(i)));
%     hold on
%     plot(r_imu1_0(i,1:size_0(i)),'r');
%     plot(y_imu1_0(i,1:size_0(i)),'g');
%     %plot(etiq(i,:)*20-40,'Color','black');
% end
% subplot(3,1,2)
% for i = 1:nb_neutral
%     plot(p_imu2_0(i,1:size_0(i)));
%     hold on
%     plot(r_imu2_0(i,1:size_0(i)),'r');
%     plot(y_imu2_0(i,1:size_0(i)),'g');
%     %plot(etiq(i,:)*20-40,'Color','black');
% end
% subplot(3,1,3)
% for i = 1:nb_neutral
%     plot(p_imu3_0(i,1:size_0(i)));
%     hold on
%     plot(r_imu3_0(i,1:size_0(i)),'r');
%     plot(y_imu3_0(i,1:size_0(i)),'g');
%     %plot(etiq(i,:)*20-40,'Color','black');
% end
%%
%% build classifier with 3 first repetitions
etiq_0_train = 0;
p_imu1_0_train = 0; p_imu2_0_train = 0; p_imu3_0_train = 0;
r_imu1_0_train = 0; r_imu2_0_train = 0; r_imu3_0_train = 0;
y_imu1_0_train = 0; y_imu2_0_train = 0; y_imu3_0_train = 0;
for o = 1:5%1:nb_neutral-20
    if (o == 1)
        etiq_0_train = etiq_0(o,1:size_0(o));
        p_imu1_0_train = p_imu1_0(o,1:size_0(o)); p_imu2_0_train = p_imu2_0(o,1:size_0(o)); p_imu3_0_train = p_imu3_0(o,1:size_0(o));
        r_imu1_0_train = r_imu1_0(o,1:size_0(o)); r_imu2_0_train = r_imu2_0(o,1:size_0(o)); r_imu3_0_train = r_imu3_0(o,1:size_0(o));
        y_imu1_0_train = y_imu1_0(o,1:size_0(o)); y_imu2_0_train = y_imu2_0(o,1:size_0(o)); y_imu3_0_train = y_imu3_0(o,1:size_0(o));
    else
        etiq_0_train = [etiq_0_train etiq_0(o,1:size_0(o))];
        p_imu1_0_train = [p_imu1_0_train p_imu1_0(o,1:size_0(o))]; p_imu2_0_train = [p_imu2_0_train p_imu2_0(o,1:size_0(o))]; p_imu3_0_train = [p_imu3_0_train p_imu3_0(o,1:size_0(o))];
        r_imu1_0_train = [r_imu1_0_train r_imu1_0(o,1:size_0(o))]; r_imu2_0_train = [r_imu2_0_train r_imu2_0(o,1:size_0(o))]; r_imu3_0_train = [r_imu3_0_train r_imu3_0(o,1:size_0(o))];
        y_imu1_0_train = [y_imu1_0_train y_imu1_0(o,1:size_0(o))]; y_imu2_0_train = [y_imu2_0_train y_imu2_0(o,1:size_0(o))]; y_imu3_0_train = [y_imu3_0_train y_imu3_0(o,1:size_0(o))];
    end
end
etiq_0_train = etiq_0_train';
p_imu1_0_train = p_imu1_0_train'; p_imu2_0_train = p_imu2_0_train'; p_imu3_0_train = p_imu3_0_train';
r_imu1_0_train = r_imu1_0_train'; r_imu2_0_train = r_imu2_0_train'; r_imu3_0_train = r_imu3_0_train';
y_imu1_0_train = y_imu1_0_train'; y_imu2_0_train = y_imu2_0_train'; y_imu3_0_train = y_imu3_0_train';
%etiq_train = [etiq(1,:) etiq(2,:) etiq(4,:) etiq(5,:) etiq(7,:) etiq(8,:)]'; etiq_train = [etiq_0_train;etiq_train];
etiq_train = [etiq(1,:) etiq(2,:) etiq(3,:)]';
%%%%%%%%%%%%%%%%%%%%%%%%%
magx_imu1_train = [magx_imu1(1,:) magx_imu1(2,:) magx_imu1(4,:) magx_imu1(5,:) magx_imu1(7,:) magx_imu1(8,:)]';
magy_imu1_train = [magy_imu1(1,:) magy_imu1(2,:) magy_imu1(4,:) magy_imu1(5,:) magy_imu1(7,:) magy_imu1(8,:)]';
magz_imu1_train = [magz_imu1(1,:) magz_imu1(2,:) magz_imu1(4,:) magz_imu1(5,:) magz_imu1(7,:) magz_imu1(8,:)]';
%p_imu1_train = [p_imu1(1,:) p_imu1(2,:) p_imu1(4,:) p_imu1(5,:) p_imu1(7,:) p_imu1(8,:)]'; p_imu1_train = [p_imu1_0_train;p_imu1_train];
%r_imu1_train = [r_imu1(1,:) r_imu1(2,:) r_imu1(4,:) r_imu1(5,:) r_imu1(7,:) r_imu1(8,:)]'; r_imu1_train = [r_imu1_0_train;r_imu1_train];
%y_imu1_train = [y_imu1(1,:) y_imu1(2,:) y_imu1(4,:) y_imu1(5,:) y_imu1(7,:) y_imu1(8,:)]'; y_imu1_train = [y_imu1_0_train;y_imu1_train];
ygyro_imu1_train = [ygyro_imu1(1,:) ygyro_imu1(2,:) ygyro_imu1(4,:) ygyro_imu1(5,:) ygyro_imu1(7,:) ygyro_imu1(8,:)]';
p_imu1_train = [p_imu1(1,:) p_imu1(2,:) p_imu1(3,:)]';
r_imu1_train = [r_imu1(1,:) r_imu1(2,:) r_imu1(3,:)]';
y_imu1_train = [y_imu1(1,:) y_imu1(2,:) y_imu1(3,:)]';
%%%%%%%%%%%%%%%%%%%%%%%%%
magx_imu2_train = [magx_imu2(1,:) magx_imu2(2,:) magx_imu2(4,:) magx_imu2(5,:) magx_imu2(7,:) magx_imu2(8,:)]';
magy_imu2_train = [magy_imu2(1,:) magy_imu2(2,:) magy_imu2(4,:) magy_imu2(5,:) magy_imu2(7,:) magy_imu2(8,:)]';
magz_imu2_train = [magz_imu2(1,:) magz_imu2(2,:) magz_imu2(4,:) magz_imu2(5,:) magz_imu2(7,:) magz_imu2(8,:)]';
%p_imu2_train = [p_imu2(1,:) p_imu2(2,:) p_imu2(4,:) p_imu2(5,:) p_imu2(7,:) p_imu2(8,:)]'; p_imu2_train = [p_imu2_0_train;p_imu2_train];
%r_imu2_train = [r_imu2(1,:) r_imu2(2,:) r_imu2(4,:) r_imu2(5,:) r_imu2(7,:) r_imu2(8,:)]'; r_imu2_train = [r_imu2_0_train;r_imu2_train];
%y_imu2_train = [y_imu2(1,:) y_imu2(2,:) y_imu2(4,:) y_imu2(5,:) y_imu2(7,:) y_imu2(8,:)]'; y_imu2_train = [y_imu2_0_train;y_imu2_train];
ygyro_imu2_train = [ygyro_imu2(1,:) ygyro_imu2(2,:) ygyro_imu2(4,:) ygyro_imu2(5,:) ygyro_imu2(7,:) ygyro_imu2(8,:)]';
p_imu2_train = [p_imu2(1,:) p_imu2(2,:) p_imu2(3,:)]'; 
r_imu2_train = [r_imu2(1,:) r_imu2(2,:) r_imu2(3,:)]'; 
y_imu2_train = [y_imu2(1,:) y_imu2(2,:) y_imu2(3,:)]';
%%%%%%%%%%%%%%%%%%%%%%%%%
magx_imu3_train = [magx_imu3(1,:) magx_imu3(2,:) magx_imu3(4,:) magx_imu3(5,:) magx_imu3(7,:) magx_imu3(8,:)]';
magy_imu3_train = [magy_imu3(1,:) magy_imu3(2,:) magy_imu3(4,:) magy_imu3(5,:) magy_imu3(7,:) magy_imu3(8,:)]';
magz_imu3_train = [magz_imu3(1,:) magz_imu3(2,:) magz_imu3(4,:) magz_imu3(5,:) magz_imu3(7,:) magz_imu3(8,:)]';
%p_imu3_train = [p_imu3(1,:) p_imu3(2,:) p_imu3(4,:) p_imu3(5,:) p_imu3(7,:) p_imu3(8,:)]'; p_imu3_train = [p_imu3_0_train;p_imu3_train];
%r_imu3_train = [r_imu3(1,:) r_imu3(2,:) r_imu3(4,:) r_imu3(5,:) r_imu3(7,:) r_imu3(8,:)]'; r_imu3_train = [r_imu3_0_train;r_imu3_train];
%y_imu3_train = [y_imu3(1,:) y_imu3(2,:) y_imu3(4,:) y_imu3(5,:) y_imu3(7,:) y_imu3(8,:)]'; y_imu3_train = [y_imu3_0_train;y_imu3_train];
ygyro_imu3_train = [ygyro_imu3(1,:) ygyro_imu3(2,:) ygyro_imu3(4,:) ygyro_imu3(5,:) ygyro_imu3(7,:) ygyro_imu3(8,:)]';        
p_imu3_train = [p_imu3(1,:) p_imu3(2,:) p_imu3(3,:)]'; 
r_imu3_train = [r_imu3(1,:) r_imu3(2,:) r_imu3(3,:)]'; 
y_imu3_train = [y_imu3(1,:) y_imu3(2,:) y_imu3(3,:)]'; 
%%%%%%%%%%%%%%%%%%%%%%%%%
%features = [p_imu1_train,r_imu1_train,y_imu1_train,p_imu2_train,r_imu2_train,y_imu2_train,p_imu3_train,r_imu3_train,y_imu3_train];
features = [p_imu1_train,r_imu1_train,y_imu1_train,p_imu2_train,r_imu2_train];
%features = [p_imu1_train,r_imu1_train,magx_imu1_train,magy_imu1_train,magz_imu1_train,p_imu2_train,r_imu2_train,p_imu3_train,r_imu3_train];
%features = [p_imu1_train,r_imu1_train,p_imu2_train,r_imu2_train,p_imu3_train,r_imu3_train];
LearnMotion_lda = fitcdiscr(features,etiq_train);
%kernel_type = 'rbf';
%LearnMotion_svm = svm.train(features,etiq_train,kernel_type);
%% run classifier with 3 last repititions
etiq_0_run = 0;
p_imu1_0_run = 0; p_imu2_0_run = 0; p_imu3_0_run = 0;
r_imu1_0_run = 0; r_imu2_0_run = 0; r_imu3_0_run = 0;
y_imu1_0_run = 0; y_imu2_0_run = 0; y_imu3_0_run = 0;
for o = 10:15%nb_neutral-19:nb_neutral
    if (o == 1)
        etiq_0_run = etiq_0(o,1:size_0(o));
        p_imu1_0_run = p_imu1_0(o,1:size_0(o)); p_imu2_0_run = p_imu2_0(o,1:size_0(o)); p_imu3_0_run = p_imu3_0(o,1:size_0(o));
        r_imu1_0_run = r_imu1_0(o,1:size_0(o)); r_imu2_0_run = r_imu2_0(o,1:size_0(o)); r_imu3_0_run = r_imu3_0(o,1:size_0(o));
        y_imu1_0_run = y_imu1_0(o,1:size_0(o)); y_imu2_0_run = y_imu2_0(o,1:size_0(o)); y_imu3_0_run = y_imu3_0(o,1:size_0(o));
    else
        etiq_0_run = [etiq_0_run etiq_0(o,1:size_0(o))];
        p_imu1_0_run = [p_imu1_0_run p_imu1_0(o,1:size_0(o))]; p_imu2_0_run = [p_imu2_0_run p_imu2_0(o,1:size_0(o))]; p_imu3_0_run = [p_imu3_0_run p_imu3_0(o,1:size_0(o))];
        r_imu1_0_run = [r_imu1_0_run r_imu1_0(o,1:size_0(o))]; r_imu2_0_run = [r_imu2_0_run r_imu2_0(o,1:size_0(o))]; r_imu3_0_run = [r_imu3_0_run r_imu3_0(o,1:size_0(o))];
        y_imu1_0_run = [y_imu1_0_run y_imu1_0(o,1:size_0(o))]; y_imu2_0_run = [y_imu2_0_run y_imu2_0(o,1:size_0(o))]; y_imu3_0_run = [y_imu3_0_run y_imu3_0(o,1:size_0(o))];
    end
end
etiq_0_run = etiq_0_run';
p_imu1_0_run = p_imu1_0_run'; p_imu2_0_run = p_imu2_0_run'; p_imu3_0_run = p_imu3_0_run';
r_imu1_0_run = r_imu1_0_run'; r_imu2_0_run = r_imu2_0_run'; r_imu3_0_run = r_imu3_0_run';
y_imu1_0_run = y_imu1_0_run'; y_imu2_0_run = y_imu2_0_run'; y_imu3_0_run = y_imu3_0_run';
%etiq_test   = [etiq(3,:) etiq(6,:) etiq(9,:)]'; etiq_test = [etiq_0_run;etiq_test];
etiq_test   = [etiq(7,:) etiq(8,:) etiq(9,:)]';
%%%%%%%%%%%%%%%%%%%%%%%%
magx_imu1_test = [magx_imu1(3,:) magx_imu1(6,:) magx_imu1(9,:)]';
magy_imu1_test = [magy_imu1(3,:) magy_imu1(6,:) magy_imu1(9,:)]';
magz_imu1_test = [magz_imu1(3,:) magz_imu1(6,:) magz_imu1(9,:)]';
%p_imu1_test = [p_imu1(3,:) p_imu1(6,:) p_imu1(9,:)]'; p_imu1_test = [p_imu1_0_run;p_imu1_test];
%r_imu1_test = [r_imu1(3,:) r_imu1(6,:) r_imu1(9,:)]'; r_imu1_test = [r_imu1_0_run;r_imu1_test];
%y_imu1_test = [y_imu1(3,:) y_imu1(6,:) y_imu1(9,:)]'; y_imu1_test = [y_imu1_0_run;y_imu1_test];
ygyro_imu1_test = [ygyro_imu1(3,:) ygyro_imu1(6,:) ygyro_imu1(9,:)]';
p_imu1_test = [p_imu1(7,:) p_imu1(8,:) p_imu1(9,:)]';
r_imu1_test = [r_imu1(7,:) r_imu1(8,:) r_imu1(9,:)]';
y_imu1_test = [y_imu1(7,:) y_imu1(8,:) y_imu1(9,:)]';;
%%%%%%%%%%%%%%%%%%%%%%%%
magx_imu2_test = [magx_imu2(3,:) magx_imu2(6,:) magx_imu2(9,:)]';
magy_imu2_test = [magy_imu2(3,:) magy_imu2(6,:) magy_imu2(9,:)]';
magz_imu2_test = [magz_imu2(3,:) magz_imu2(6,:) magz_imu2(9,:)]';
%p_imu2_test = [p_imu2(3,:) p_imu2(6,:) p_imu2(9,:)]'; p_imu2_test = [p_imu2_0_run;p_imu2_test];
%r_imu2_test = [r_imu2(3,:) r_imu2(6,:) r_imu2(9,:)]'; r_imu2_test = [r_imu2_0_run;r_imu2_test];
%y_imu2_test = [y_imu2(3,:) y_imu2(6,:) y_imu2(9,:)]'; y_imu2_test = [y_imu2_0_run;y_imu2_test];
ygyro_imu2_test = [ygyro_imu2(3,:) ygyro_imu2(6,:) ygyro_imu2(9,:)]';
p_imu2_test = [p_imu2(7,:) p_imu2(8,:) p_imu2(9,:)]'; 
r_imu2_test = [r_imu2(7,:) r_imu2(8,:) r_imu2(9,:)]'; 
y_imu2_test = [y_imu2(7,:) y_imu2(8,:) y_imu2(9,:)]';
%%%%%%%%%%%%%%%%%%%%%%%%
magx_imu3_test = [magx_imu3(3,:) magx_imu3(6,:) magx_imu3(9,:)]';
magy_imu3_test = [magy_imu3(3,:) magy_imu3(6,:) magy_imu3(9,:)]';
magz_imu3_test = [magz_imu3(3,:) magz_imu3(6,:) magz_imu3(9,:)]';
%p_imu3_test = [p_imu3(3,:) p_imu3(6,:) p_imu3(9,:)]'; p_imu3_test = [p_imu3_0_run;p_imu3_test];
%r_imu3_test = [r_imu3(3,:) r_imu3(6,:) r_imu3(9,:)]'; r_imu3_test = [r_imu3_0_run;r_imu3_test];
%y_imu3_test = [y_imu3(3,:) y_imu3(6,:) y_imu3(9,:)]'; y_imu3_test = [y_imu3_0_run;y_imu3_test];
ygyro_imu3_test = [ygyro_imu3(3,:) ygyro_imu3(6,:) ygyro_imu3(9,:)]';
p_imu3_test = [p_imu3(7,:) p_imu3(8,:) p_imu3(9,:)]'; 
r_imu3_test = [r_imu3(7,:) r_imu3(8,:) r_imu3(9,:)]'; 
y_imu3_test = [y_imu3(7,:) y_imu3(8,:) y_imu3(9,:)]';
error = 0;
error_lda = 0;
error_svm = 0;
%%
for i = 1:length(p_imu1_test)
    %input = [p_imu1_test(i),r_imu1_test(i),y_imu1_test(i),p_imu2_test(i),r_imu2_test(i),y_imu2_test(i),p_imu3_test(i),r_imu3_test(i),y_imu3_test(i)];
    input = [p_imu1_test(i),r_imu1_test(i),y_imu1_test(i),p_imu2_test(i),r_imu2_test(i)];
    %input = [p_imu1_test(i),r_imu1_test(i),magx_imu1_test(i),magy_imu1_test(i),magz_imu1_test(i),p_imu2_test(i),r_imu2_test(i),p_imu3_test(i),r_imu3_test(i)];
    %input = [p_imu1_test(i),r_imu1_test(i),p_imu2_test(i),r_imu2_test(i),p_imu3_test(i),r_imu3_test(i)];
    output_lda(i) = predict(LearnMotion_lda,input);
    %output_svm(i) = svm.predict(LearnMotion_svm,input);
    if (output_lda(i) ~= etiq_test(i))
        error = error + 1;
        error_lda = error_lda + 1;
    end
    %if (output_svm(i) ~= etiq_test(i))
    %    error_svm = error_svm + 1;
    %end
end

acc = (1-(error/length(output_lda)))*100;
acc_lda = (1-(error_lda/length(output_lda)))*100;
%acc_svm = (1-(error_svm/length(output_svm)))*100;
disp('Accuracy LDA')
disp(acc_lda)
%disp('Accuracy SVM')
%disp(acc_svm)
%%
% figure
% subplot(2,1,1)
% plot(output_lda,'LineWidth',2,'Color','red')
% hold on
% plot(etiq_test,'LineWidth',2)
% legend('Output_L_D_A','Etiquette')
% ylim([-1 9])
% xlim([1 length(output_lda)])
% subplot(2,1,2)
% plot(output_svm,'LineWidth',2,'Color','green')
% hold on
% plot(etiq_test,'LineWidth',2)
% legend('Output_S_V_M','Etiquette')
% ylim([-1 9])
% xlim([1 length(output_svm)])
%% Build Confusion Matrix
% test_class = unique(etiq_test);
% matrix_size = length(test_class);
% lda_matrix = zeros(matrix_size,matrix_size);
% svm_matrix = zeros(matrix_size,matrix_size);
% count = 0;
% for c = 1:matrix_size
%     current_class = test_class(c);
%     %disp(current_class)
%     for t = 1:length(etiq_test)
%         if (etiq_test(t) == current_class) %&& etiq_test(t) == output_lda(t))
%             count = count + 1;
%             lda_matrix(current_class+1,output_lda(t)+1) = lda_matrix(current_class+1,output_lda(t)+1) + 1; 
%             svm_matrix(current_class+1,output_svm(t)+1) = svm_matrix(current_class+1,output_svm(t)+1) + 1;
%         end
%     end
%     %disp(count)
%     count = 0;
% end
% labels = num2str(test_class);
% figure
% subplot(2,1,1)
% plotConfMat(lda_matrix,labels);
% title('LDA')
% subplot(2,1,2)
% plotConfMat(svm_matrix,labels);
% title(strcat('SVM','~~',kernel_type))