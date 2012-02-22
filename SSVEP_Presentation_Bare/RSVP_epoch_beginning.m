%Screen('DrawText', w, [num2str(epoch) ' ' num2str(epoch)], 50, 50, [255, 255, 255]);



Screen('DrawText', win, num2str(randcounter), 50, 50, [255, 255, 255]);
Screen('DrawText', win, 'Press Esc to Quit...', 200, 500, [255, 255, 255]);
Screen('DrawText', win, 'Press any other key to continue...', 200, 550, [255, 255, 255]);

[vbl StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip', win,0);

%save(['../data/channels_data' num2str(epoch) '.mat'],'channels_data');

[secs, keyCode, deltaSecs] =KbWait;
letter_pressed=find(keyCode);
switch letter_pressed(1)
case 27 %27 is escape
   exit_flag=1;
end

randcounter = randcounter + 1;
randseletor = mod(randomfreq(randcounter),4);

if flickertype == 0
    if randseletor == 0
        p1 = round(0.5/(ifi*Frequency1));
        freqnow = Frequency1;
    else
        if randseletor == 1
            p1 = round(0.5/(ifi*Frequency2));
            freqnow = Frequency2;
        else
            if randseletor == 2
                p1 = round(0.5/(ifi*Frequency3));
                freqnow = Frequency3;
            else
                if randseletor == 3
                    p1 = round(0.5/(ifi*Frequency4));
                    freqnow = Frequency4;
                end
            end
        end
    end
    
    frecord = [frecord , freqnow];
    
else
    if flickertype ==1
        if randseletor == 0
            mseq = mpf1;
        else
            if randseletor == 1
                mseq = mpf2;
            else
                if randseletor == 2
                    mseq = mpf3;
                else
                    if randseletor == 3
                        mseq = mpf4;
                    end
                end
            end
        end
        mrecord = [mrecord , mseq];
        seq = [seq, mod(randomfreq(randcounter),4)];
        
    else
        if flickertype ==2
            if randseletor == 0
                mseq = mpf5;
            else
                if randseletor == 1
                    mseq = mpf6;
                else
                    if randseletor == 2
                        mseq = mpf7;
                    else
                        if randseletor == 3
                            mseq = mpf8;
                        end
                    end
                end
            end
            mrecord = [mrecord , mseq];
            seq = [seq, mod(randomfreq(randcounter),4)+4];
            pstat = 1;
            
        end
    end
end


% epoch=epoch+1;
% sequence=0;

% switch target_ordering_mode
    % case 0 %Random target
        % x=randperm(actual_image_count);
        % y=randperm(distractor_image_count)+actual_image_count;
        % order_of_trials=zeros(sequences_per_epoch,trials_per_seq+distractors_per_seq);
        % order_of_trials_main=[x(1:trials_per_seq) y(1:distractors_per_seq)];
        % if(rand<=target_probability)
            % target_of_seq=x(1);
        % else
            % target_of_seq=x(trials_per_seq+(ceil(rand*(actual_image_count-trials_per_seq))));
        % end
        
        
    % case 1  %Fixed target
        % if(epoch==1)
            % main_target=ceil(rand*actual_image_count);
            % nontarget_list=[1:main_target-1 main_target+1:actual_image_count];
        % end
        
        
        % x=nontarget_list(randperm(actual_image_count-1));
        % y=randperm(distractor_image_count)+actual_image_count;
        % target_of_seq=main_target;
        
        % order_of_trials=zeros(sequences_per_epoch,trials_per_seq+distractors_per_seq);
        
        
        
        % if(rand<=target_probability)
            % order_of_trials_main=[main_target x(1:trials_per_seq-1) y(1:distractors_per_seq)];
            
            
        % else
            % order_of_trials_main=[x(1:trials_per_seq) y(1:distractors_per_seq)];
        % end
        
    % case 2
        % if(epoch==1)
            % load('target_list.txt');
        % end
        
        % target_of_seq=target_list(epoch);
        % nontarget_list=[1:target_of_seq-1 target_of_seq+1:actual_image_count];
        % x=nontarget_list(randperm(actual_image_count-1));
        % y=randperm(distractor_image_count)+actual_image_count;
        
        % order_of_trials=zeros(sequences_per_epoch,trials_per_seq+distractors_per_seq);
        % if(rand<=target_probability)
            
            % order_of_trials_main=[target_of_seq x(1:trials_per_seq-1) y(1:distractors_per_seq)];
            
        % else
            % order_of_trials_main=[x(1:trials_per_seq) y(1:distractors_per_seq)];
        % end
        
        
        
        
        
        
% end
% for(seq=1:sequences_per_epoch)
    % order_of_trials(seq,:)=order_of_trials_main(randperm(trials_per_seq+distractors_per_seq));
% end

% imageIDs_target(epoch)=target_of_seq;
% imageIDs_trial_orders(epoch,:,:)=order_of_trials;
%tstart=tic;



% Screen('DrawTexture',win,image_texture(target_of_seq),srcRect,dstRect,0,0);
% Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
% [vbl StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip', w, 0,0);

% Screen('DrawTexture',win,image_texture(target_of_seq),srcRect,dstRect,0,0);
% Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
% [vbl StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip', w, vbl + flip_duration_target-0.5*ifi,0,0 );

% Screen('DrawTexture',win,black_image,srcRect,dstRect,0,0);
% Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
% [vbl StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip', w, vbl + flip_duration_target-0.5*ifi,0,0 );

