close all
clc

n = 1200;
%ch = 7;
[b,a] = butter(4, [1 20]/(128/2), 'bandpass');
%[b,a] = butter(4, 0.1/(128/2), 'high');
%[b,a] = butter(4, [29 40]/(128/2), 'stop');
%[b,a] = butter(4, 30/(128/2), 'low');

dataIn_struct = pop_biosig('town-[2016.10.21-16.31.49].gdf');

dataOVFiltered_struct = pop_biosig('bandpass_4_Hz-1_20.gdf');
%dataOVFiltered_struct = pop_biosig('highpass_4_Hz-01.gdf');
%dataOVFiltered_struct = pop_biosig('bandstop_4_Hz-29_40.gdf');
%dataOVFiltered_struct = pop_biosig('lowpass_4_Hz-30.gdf');

for ch = 1:14
    dataOVFiltered = dataOVFiltered_struct.data(ch,1:n);
    %dataOVFiltered = dataOVFiltered - mean(dataOVFiltered);
    
    dataIn = dataIn_struct.data(ch,1:n);
    dataIn = double(dataIn);
    %dataIn = dataIn - mean(dataIn);

    time = dataIn_struct.times(1:n);

    y0 = zeros(1, length(b) - 1);
    x0 = dataIn(length(b):-1:1);

    %computeInitial(b,a) ce uvijek biti isti, moze se izdvojit van for petlje

    dataOut_filterIc = filter(b, a, dataIn);%,computeInitial(b,a)*dataIn(1));
    figureName = strcat('Channel #', num2str(ch));
    figure('Name', figureName, 'NumberTitle', 'off')
    
     plot(time, dataOVFiltered, time, dataOut_filterIc)
    %figureName = strcat('Channel #', num2str(ch));
    %figure('Name', figureName, 'NumberTitle', 'off')
    %plot(abs(dataOut_filterIc - dataOVFiltered));
end



