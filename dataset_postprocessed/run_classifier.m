function [out,label] = run_classifier(data,nbimuused,mode,nwin,novrlp,model_lda)
%precision
%% testing
load(data);
Nwin = nwin;
Novrlp = novrlp;
%size = length(Pitch1Raw(1:end))*1/3-12*301;
size = length(Pitch1Raw(1:end))*1/3 - 12*301;
if (nbimuused == 2)
    shift = 301*62;
elseif (nbimuused == 3)
    shift = 301*98;%301*49;%
end
%%
shift = 301*98;
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
%%%%%%%%
% index = 1;
% indexmax = -1;
% a = -1;
% k = 1;
% jump = 0;
% while k <= size
%     if a ~= Etiquette(k+shift)
%         a = Etiquette(k+shift);
%         h = k+shift;
%         var = 0;
%         while(h < size && var == 0)
%             if a ~= Etiquette(h+shift)
%                 var = 1;
%             else
%                 h = h + 1;
%             end
%         end
%         indexmax = h-1;
%         if (h == size)
%             indexmax = h;
%         end
%     end
%     index1 = k; index2 = k + Nwin - 1;
%     if index2 >= indexmax
%         jump =  indexmax - index1;
%         index2 = indexmax;
%     else
%         jump = 0;
%     end
%     if index2 > size
%         index2 = size;
%     end
%     if index2 <= indexmax && index1 ~= index2
%         labeltest (index) = Etiquette(index1+shift);
%         %mean
%         meantestpitch1(index) = mean(Pitch1Raw(index1+shift:index2+shift));meantestpitch2(index) = mean(Pitch2Raw(index1+shift:index2+shift));meantestpitch3(index) = mean(Pitch3Raw(index1+shift:index2+shift));
%         meantestroll1(index) = mean(Roll1Raw(index1+shift:index2+shift));meantestroll2(index) = mean(Roll2Raw(index1+shift:index2+shift));meantestroll3(index) = mean(Roll3Raw(index1+shift:index2+shift));
%         meantestyaw1(index) = mean(Yaw1Raw(index1+shift:index2+shift));meantestyaw2(index) = mean(Yaw2Raw(index1+shift:index2+shift));meantestyaw3(index) = mean(Yaw3Raw(index1+shift:index2+shift));
%         meantestgyrox1(index) = mean(GYRO1X(index1+shift:index2+shift)); meantestgyrox2(index) = mean(GYRO2X(index1+shift:index2+shift)); meantestgyrox3(index) = mean(GYRO3X(index1+shift:index2+shift));
%         meantestgyroy1(index) = mean(GYRO1Y(index1+shift:index2+shift)); meantestgyroy2(index) = mean(GYRO2Y(index1+shift:index2+shift)); meantestgyroy3(index) = mean(GYRO3Y(index1+shift:index2+shift));
%         meantestgyroz1(index) = mean(GYRO1Z(index1+shift:index2+shift)); meantestgyroz2(index) = mean(GYRO2Z(index1+shift:index2+shift)); meantestgyroz3(index) = mean(GYRO3Z(index1+shift:index2+shift));
%         %max
%         maxtestpitch1(index) = max(Pitch1Raw(index1+shift:index2+shift));maxtestpitch2(index) = max(Pitch2Raw(index1+shift:index2+shift));maxtestpitch3(index) = max(Pitch3Raw(index1+shift:index2+shift));
%         maxtestroll1(index) = max(Roll1Raw(index1+shift:index2+shift));maxtestroll2(index) = max(Roll2Raw(index1+shift:index2+shift));maxtestroll3(index) = max(Roll3Raw(index1+shift:index2+shift));
%         maxtestyaw1(index) = max(Yaw1Raw(index1+shift:index2+shift));maxtestyaw2(index) = max(Yaw2Raw(index1+shift:index2+shift));maxtestyaw3(index) = max(Yaw3Raw(index1+shift:index2+shift));
%         maxtestgyrox1(index) = max(GYRO1X(index1+shift:index2+shift )); maxtestgyrox2(index) = max(GYRO2X(index1 :index2 )); maxtestgyrox3(index) = max(GYRO3X(index1 :index2 ));
%         maxtestgyroy1(index) = max(GYRO1Y(index1+shift:index2+shift )); maxtestgyroy2(index) = max(GYRO2Y(index1 :index2 )); maxtestgyroy3(index) = max(GYRO3Y(index1 :index2 ));
%         maxtestgyroz1(index) = max(GYRO1Z(index1+shift:index2+shift )); maxtestgyroz2(index) = max(GYRO2Z(index1 :index2 )); maxtestgyroz3(index) = max(GYRO3Z(index1 :index2 ));
%         %min
%         mintestpitch1(index) = min(Pitch1Raw(index1+shift:index2+shift));mintestpitch2(index) = min(Pitch2Raw(index1+shift:index2+shift));mintestpitch3(index) = min(Pitch3Raw(index1+shift:index2+shift));
%         mintestroll1(index) = min(Roll1Raw(index1+shift:index2+shift));mintestroll2(index) = min(Roll2Raw(index1+shift:index2+shift));mintestroll3(index) = min(Roll3Raw(index1+shift:index2+shift));
%         mintestyaw1(index) = min(Yaw1Raw(index1+shift:index2+shift));mintestyaw2(index) = min(Yaw2Raw(index1+shift:index2+shift));mintestyaw3(index) = min(Yaw3Raw(index1+shift:index2+shift));
%         mintestgyrox1(index) = min(GYRO1X(index1+shift:index2+shift )); mintestgyrox2(index) = min(GYRO2X(index1 :index2 )); mintestgyrox3(index) = min(GYRO3X(index1 :index2 ));
%         mintestgyroy1(index) = min(GYRO1Y(index1+shift:index2+shift )); mintestgyroy2(index) = min(GYRO2Y(index1 :index2 )); mintestgyroy3(index) = min(GYRO3Y(index1 :index2 ));
%         mintestgyroz1(index) = min(GYRO1Z(index1+shift:index2+shift )); mintestgyroz2(index) = min(GYRO2Z(index1 :index2 )); mintestgyroz3(index) = min(GYRO3Z(index1 :index2 ));
%         %mad
%         madtestpitch1(index) = mad(Pitch1Raw(index1+shift:index2+shift));madtestpitch2(index) = mad(Pitch2Raw(index1+shift:index2+shift));madtestpitch3(index) = mad(Pitch3Raw(index1+shift:index2+shift));
%         madtestroll1(index) = mad(Roll1Raw(index1+shift:index2+shift));madtestroll2(index) = mad(Roll2Raw(index1+shift:index2+shift));madtestroll3(index) = mad(Roll3Raw(index1+shift:index2+shift));
%         madtestyaw1(index) = mad(Yaw1Raw(index1+shift:index2+shift));madtestyaw2(index) = mad(Yaw2Raw(index1+shift:index2+shift));madtestyaw3(index) = mad(Yaw3Raw(index1+shift:index2+shift));
%         madtestgyrox1(index) = mad(GYRO1X(index1+shift:index2+shift )); madtestgyrox2(index) = mad(GYRO2X(index1 :index2 )); madtestgyrox3(index) = mad(GYRO3X(index1 :index2 ));
%         madtestgyroy1(index) = mad(GYRO1Y(index1+shift:index2+shift )); madtestgyroy2(index) = mad(GYRO2Y(index1 :index2 )); madtestgyroy3(index) = mad(GYRO3Y(index1 :index2 ));
%         madtestgyroz1(index) = mad(GYRO1Z(index1+shift:index2+shift )); madtestgyroz2(index) = mad(GYRO2Z(index1 :index2 )); madtestgyroz3(index) = mad(GYRO3Z(index1 :index2 ));
%         %iav
%         iavtestpitch1(index) = iav(Pitch1Raw(index1+shift:index2+shift));iavtestpitch2(index) = iav(Pitch2Raw(index1+shift:index2+shift));iavtestpitch3(index) = iav(Pitch3Raw(index1+shift:index2+shift));
%         iavtestroll1(index) = iav(Roll1Raw(index1+shift:index2+shift));iavtestroll2(index) = iav(Roll2Raw(index1+shift:index2+shift));iavtestroll3(index) = iav(Roll3Raw(index1+shift:index2+shift));
%         iavtestyaw1(index) = iav(Yaw1Raw(index1+shift:index2+shift));iavtestyaw2(index) = iav(Yaw2Raw(index1+shift:index2+shift));iavtestyaw3(index) = iav(Yaw3Raw(index1+shift:index2+shift));
%         iavtestgyrox1(index) = iav(GYRO1X(index1+shift:index2+shift )); iavtestgyrox2(index) = iav(GYRO2X(index1 :index2 )); iavtestgyrox3(index) = iav(GYRO3X(index1 :index2 ));
%         iavtestgyroy1(index) = iav(GYRO1Y(index1+shift:index2+shift )); iavtestgyroy2(index) = iav(GYRO2Y(index1 :index2 )); iavtestgyroy3(index) = iav(GYRO3Y(index1 :index2 ));
%         iavtestgyroz1(index) = iav(GYRO1Z(index1+shift:index2+shift )); iavtestgyroz2(index) = iav(GYRO2Z(index1 :index2 )); iavtestgyroz3(index) = iav(GYRO3Z(index1 :index2 ));
%         %%%%%%
%         index = index+ 1;
%     end
%     if jump == 0
%         k = k + (Nwin-Novrlp);
%     else
%         k = k + jump;
%     end    
% end

index1 = shift + 1; index2 = shift + Nwin; index = 0; indexmax = 0;
a = -1; nbwindows = 0;
while indexmax < size + shift
    a = Etiquette(index1);
    indexmax =   index1 + 300;
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
    nbwindows = 0;
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

if (nbimuused == 1)
    input = [input_imu1];
elseif (nbimuused == 2)
    input = [input_imu1,input_imu2];
elseif (nbimuused == 3)
    input = [input_imu1,input_imu2,input_imu3];
end

disp('Testing: Feature Extraction Done')
%%
error = 0; output = 0;
for t = 1:length(input)
    output(t) = predict(model_lda,input(t,:));
    if output(t) ~= labeltest(t)
        error = error + 1;
    end
end

out = output;
label = labeltest;

acc = (1-(error/length(output)))*100;
disp('Accuracy LDA')
disp(acc)
precision = acc;

end

