clc
clear
close
load('precision_vs_amp')
for u = 1:length(output_SAE_MAE)
    if (label(u) ~= output_SAE_MAE(u))
        output_SAE_MAE(u) = 0;
    end
end
for u = 1:length(output_MAE_MAE)
    if (label(u) ~= output_MAE_MAE(u) && output_MAE_MAE(u) ~= 0)
        output_MAE_MAE(u) = label(u);
    end
end
figure
subplot(2,1,1)
plot(Time,label,'Color','red') 
hold on
plot(Time,output_SAE_MAE,'*','Color','blue')
xlim([Time(1) Time(length(Time))])
ylim([-1 7])
subplot(2,1,2)
plot(Time,label,'Color','red')
hold on
plot(Time,output_MAE_MAE,'*','Color','blue')
xlim([Time(1) Time(length(Time))])
ylim([-1 7])