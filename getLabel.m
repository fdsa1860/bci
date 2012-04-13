clc;clear;close all;
%% read data
% [ym,labels,data]=read_binary_data();   % read data and labels
[data] = read_gTec_dat('.\p300data\2012-01-17_Meghan_1_train_samplesPerBlock_1792_numChnl_17',1792,17);
ym=process_data(data);
% numLabels=numel(unique(labels));

% %% sampling
% sampleRate = 1;
% [y,ym,dataLength]=sampleData(ym,sampleRate);


% [yy,yms]=sortdata(ym,labels);       % sort data according to labels

% %% generate test data
% ymean=mean(yy(:,:),2);
% ysimilar=[yy(1:dataLength,1); yy(1:dataLength,40)];
% ydifferent=[yy(1:dataLength,1); yy(1+dataLength:dataLength+dataLength,40)];
% ydifferent1=[yy(1+dataLength:dataLength+dataLength,40);yy(1:dataLength,1)];

fprintf('data acquired...');

FILTER_EN=1;

if FILTER_EN==1
    B=25;
    F=ones(size(ym,1),1);
    F(1+B:length(F)-B)=0;
    for i=1:size(ym,2)
        Y(:,i)=fft(ym(:,i)).*F;
        ymF(:,i)=real(ifft(Y(:,i)));    % not a good filter
        %     plot(abs(fftshift(fft(ymF(:,i)))),'b');
    end
%     keyboard;
end


%% seperate data due to dynamic switch
norm_used=2;
% epsilon=7;
order=10;
% for i=1:20
    for epsilon=900
        fprintf('order=%d\n',order);
        [p_est group]=indep_dyn_switch_detect(ymF,norm_used,epsilon,order);
%         [p_est
%         group]=indep_dyn_switch_detect(mean(yms(:,1+3*65:65+3*65),2),norm_used,epsilon,order);
        %      [x group]=indep_dyn_switch_detect1(data(16662:16662+1000,2),norm_used,epsilon,order);
        %      [x group]=indep_dyn_switch_detect1(data(24231:25094+266,2),norm_used,epsilon,order);
        %     [x group] = indep_dyn_switch_detect_offset(ymean(1:532,1),norm_used,epsilon,order);
        %     group=l1_switch_detect(data(16662:16662+1000,2),norm_used,epsilon);
        %     group = multidim_dyn_switch_detect(yh,norm_used,epsilon,order);
        
        if ~isempty(group)
            fprintf('The number of groups=%d\n',numel(unique(group)));
            if numel(unique(group))>1
                continue;
            else
%                 para(:,i)=p_est(1:3);
                break;
            end
        end
    end
%     close all;
% end
% num_order=8;
% for i=1:num_order
%     p(:,i)=x(i:num_order:end,:);
% end

    
    
