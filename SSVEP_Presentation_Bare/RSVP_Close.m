%Priority(1);

clock_str='';
%numeric_begin=0;
R=raw_data_path;
[T,R]=strtok(R,'\'); 
while(~isempty(R))
   clock_str=strcat(clock_str,T,'\');
   [T,R]=strtok(R,'\')
end
    clock_str=strcat(clock_str,T(1:13));
   %clock_str=raw_data_path(1:13);
%    for(ii=1:length(raw_data_path))
%        if(~numeric_begin && isnumeric(raw_data_path(ii)))
%            numeric_begin=1;
%        end
%        if(numeric_begin && ischar(raw_data_path(ii)))
%            numeric_begin=0;
%        end
%        if(numeric_begin)
%            clock_str=clock_str+raw_data_path(ii);
%        end   
%    end
   
%  % clock_str=[num2str(initialization_clock(1)) num2str(initialization_clock(2),2) num2str(initialization_clock(3)) '_' num2str(initialization_clock(4)) num2str(initialization_clock(5))];
% % % % % % %    save(strcat(clock_str,'_imageIDs_target.mat'),'imageIDs_target');
% % % % % % %    save(strcat(clock_str,'_imageIDs_trial_orders.mat'),'imageIDs_trial_orders');
% % % % % % %    save(strcat(clock_str,'_target_seen.mat'),'target_seen');
% % % % % % %    parameters=struct('trial_duration',trial_duration,'fixation_duration',fixation_duration,'sequences_per_epoch',sequences_per_epoch,'distractors_per_seq',distractors_per_seq,'target_probability',target_probability,'target_ordering_mode',target_ordering_mode,'image_duty_cycle',image_duty_cycle,'epoch_number',epoch_number,'amplifierCount',amplifierCount,'trials_per_seq',trials_per_seq,'black_screen_duration',black_screen_duration);
% % % % % % %    
% % % % % % %    
% % % % % % %    save(strcat(clock_str,'_parameters.mat'),'parameters')
parameters = struct('flickertype',flickertype,'DurationOfEachTrial',DurationOfEachTrial,'Frequency',Frequency,'NumberofTrials',NumberofTrials,'Frequency1',Frequency1,'Frequency2',Frequency2,'Frequency3',Frequency3,'Frequency4',Frequency4,'DefaultPeriod',DP,'DefaultFrequency',DF,'frecord',frecord,'mrecord',mrecord,'seq',seq,'ifi',ifi,'p1',p1,'F1',F1,'F2',F2,'F3',F3,'F4',F4);   
save(strcat(clock_str,'_parameters.mat'),'parameters')


  %Screen('Close')
  Screen('CloseAll')
  
%   for screen_index=1:screenNumber
%    Screen('Resolution',screen_index, old_res(screen_index).width,old_res(screen_index).height);
%   end
 
  %clear Screen
  %close all