clear
clc
close
addpath('plotConfMat')
%% plot conf mat user1 et user2
mode = 2;
precision1 = 0;
precision2 = 0;
nwin = 8; novrlp = 7;
% run
precision1 = build_dataset_v31('user1p',2,mode,nwin,novrlp);
precision2 = build_dataset_v31('user2p',2,mode,nwin,novrlp);
%% different features (mode = 0,1,2,3,4)
% init
mode = [0 1 2];
precision = 0;
nwin = 8; novrlp = 7;
% run test
%build_dataset_v31 ('user1p',2,0,8,7);
for y = 1:length(mode)
    precision(y,1) = build_dataset_v31 ('user3p',3,mode(y),nwin,novrlp); %P1
    precision(y,2) = build_dataset_v31 ('user5p',3,mode(y),nwin,novrlp); %P2
    precision(y,3) = build_dataset_v31 ('user6p',3,mode(y),nwin,novrlp); %P3
    precision(y,4) = build_dataset_v31 ('user1p',2,mode(y),nwin,novrlp); %P4
    precision(y,5) = build_dataset_v31 ('user2p',2,mode(y),nwin,novrlp); %P5
end
bar(precision')
legend('mode0','mode1','mode2')%,'mode3','mode4')
%% nwin = 1
precision = 0;
precision(1) = build_dataset_v4 ('user3p',3,1); %P1
precision(2) = build_dataset_v4 ('user5p',3,1); %P2
precision(3) = build_dataset_v4 ('user6p',3,1); %P3
precision(4) = build_dataset_v4 ('user1p',2,1); %P4
precision(5) = build_dataset_v4 ('user2p',2,1); %P5
bar(precision')
%% predict different motion amplitude
% build model
% model_lda_SAE = build_classifier('user3p',3,1,8,6);
% model_lda_MAE = build_classifier('user3_2p',3,1,8,6);
model_lda_SAE = build_classifier2('user3p',1,2);
model_lda_MAE = build_classifier2('user3_2p',1,2);
% run classifier
[output_SAE_MAE,label] = run_classifier('user3_2p',1,2,8,7,model_lda_SAE);
[output_MAE_MAE,label] = run_classifier('user3_2p',1,2,8,7,model_lda_MAE);
% [output_SAE_MAE,label] = run_classifier2('user3_2p',1,0,model_lda_SAE);
% [output_MAE_MAE,label] = run_classifier2('user3_2p',1,0,model_lda_MAE);
% reverse class
for ip = 1:length(label)
    if (label(ip) == 2)
        label(ip) = 3;
    elseif (label(ip) == 3)
        label(ip) = 2;
    end
    if (output_SAE_MAE(ip) == 2)
        output_SAE_MAE(ip) = 3;
    elseif (output_SAE_MAE(ip) == 3)
        output_SAE_MAE(ip) = 2;
    end
    if (output_MAE_MAE(ip) == 2)
        output_MAE_MAE(ip) = 3;
    elseif (output_MAE_MAE(ip) == 3)
        output_MAE_MAE(ip) = 2;
    end
end
Time = 0;
for ip = 1:length(label)
    Time(ip) = (ip-1)*(1/62);
end
figure
subplot(2,1,1)
plot(Time,label,'Color','red')
hold on
plot(Time,output_SAE_MAE,'*','Color','blue')
title('Training : SAE - Prediction : MAE')
xlim([Time(1) Time(length(Time))])
ylim([-1 7])
subplot(2,1,2)
plot(Time,label,'Color','red')
hold on
plot(Time,output_MAE_MAE,'*','Color','blue')
title('Training : MAE - Prediction : MAE')
xlim([Time(1) Time(length(Time))])
ylim([-1 7])
%% window size and overlap perf test
% init
usegyro = 1; 
nwin = [4 6 8 10 12 14 16]; nbwin = length(nwin); 
novrlp = round((3/4)*nwin);
if (nwin(1) == 1)
    novrlp(1) = 0;
end
if (nwin(2) == 2)
    novrlp(2) = 0;
end
precision = 0;
%run
for y = 1:nbwin
    % P1
    precision(y,1) = build_dataset_v3 ('user3p',3,usegyro,nwin(y),novrlp(y));
    % P2
    precision(y,2) = build_dataset_v3 ('user5p',3,usegyro,nwin(y),novrlp(y));
    % P3
    precision(y,3) = build_dataset_v3 ('user6p',3,usegyro,nwin(y),novrlp(y));
    % P4
    precision(y,4) = build_dataset_v3 ('user1p',2,usegyro,nwin(y),novrlp(y));
    % P5
    precision(y,5) = build_dataset_v3 ('user2p',2,usegyro,nwin(y),novrlp(y));
end
plot(precision)
legend('P1','P2','P3','P4','P5')
%% Performance vs Time
addpath('dataset_5days/')
precision = 0;
dday1 = 1; dday = 2;
% % build
% model_day1 = build_classifier2('day1_trainp.mat',3,0);
% model_day2 = build_classifier2('day2_trainp.mat',3,0);
% model_day3 = build_classifier2('day3_trainp.mat',3,0);
% model_day4 = build_classifier2('day4_trainp.mat',3,0);
% model_day5 = build_classifier2('day5_trainp.mat',3,0);
% precision dday1
load('models')
precision(dday1,1) = run_classifier('day1_testp.mat',3,2,8,7,model_day1);
precision(dday1,2) = run_classifier('day2_testp.mat',3,2,8,7,model_day1);
precision(dday1,3) = run_classifier('day3_testp.mat',3,2,8,7,model_day1);
precision(dday1,4) = run_classifier('day4_testp.mat',3,2,8,7,model_day1);
precision(dday1,5) = run_classifier('day5_testp.mat',3,2,8,7,model_day1);
% precision dday
precision(dday,1) = run_classifier('day1_testp.mat',3,2,8,7,model_day1);
precision(dday,2) = run_classifier('day2_testp.mat',3,2,8,7,model_day2);
precision(dday,3) = run_classifier('day3_testp.mat',3,2,8,7,model_day3);
precision(dday,4) = run_classifier('day4_testp.mat',3,2,8,7,model_day4);
precision(dday,5) = run_classifier('day5_testp.mat',3,2,8,7,model_day5);
% plot precision
bar(precision')
%%
% %%
% l = 1;
% % P1
% precision(l,1) = build_dataset_v4 ('user3p',3,usegyro);
% % P2
% precision(l,2) = build_dataset_v4 ('user5p',3,usegyro);
% % P3
% precision(l,3) = build_dataset_v4 ('user6p',3,usegyro);
% % P4
% precision(l,4) = build_dataset_v4 ('user1p',2,usegyro);
% % P5
% precision(l,5) = build_dataset_v4 ('user2p',2,usegyro);
% %%
% l = 2;
% % P1
% precision(l,1) = build_dataset_v3 ('user3p',3,usegyro,nwin,novrlp);
% % P2
% precision(l,2) = build_dataset_v3 ('user5p',3,usegyro,nwin,novrlp);
% % P3
% precision(l,3) = build_dataset_v3 ('user6p',3,usegyro,nwin,novrlp);
% % P4
% precision(l,4) = build_dataset_v3 ('user1p',2,usegyro,nwin,novrlp);
% % P5
% precision(l,5) = build_dataset_v3 ('user2p',2,usegyro,nwin,novrlp);
% %%
% bar(precision')
% %%