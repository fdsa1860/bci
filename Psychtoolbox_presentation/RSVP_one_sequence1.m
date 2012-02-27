centerhorizental = winRect(3) / 2;
centervertical = winRect(4) / 2;
horizental = winRect(3);
vertical = winRect(4);

totallength = min(floor(horizental/3),floor(vertical/3));

centerhstart = floor(centerhorizental - totallength / 2);
centervstart = floor(centervertical - totallength / 2);
centerhend = floor(centerhorizental + totallength / 2);
centervend = floor(centervertical + totallength / 2);

rightsidestart = horizental - totallength;
bottomstart = vertical - totallength;

dstRect_nontarget = [centerhorizental-10,vertical-50,centerhorizental+10,vertical-30];

%% Modified by shalini for adding gray frame around previous selected
% checkerboard
offset_box = 30;
decision_shalini = 0;
size_box = totallength + offset_box;% GreenBox Shalini
green_box = zeros(size_box,size_box);% GreenBox Shalini
green_box(1:offset_box/2,:) = 128*ones(offset_box/2,size_box); % GreenBox Shalini
green_box((size_box-offset_box/2 + 1):size_box,:) = 128*ones(offset_box/2,size_box); % GreenBox Shalini
green_box(:,1:offset_box/2) = 128*ones(size_box,offset_box/2);% GreenBox Shalini
green_box(:,(size_box-offset_box/2 + 1):size_box) = 128*ones(size_box,offset_box/2);% GreenBox Shalini
green_box_texture = Screen('MakeTexture',win,green_box);% GreenBox Shalini
%%

Screen('DrawTexture',win,fixation_image_texture,srcRect,dstRect,0,0);
Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
% [vbl StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip', win, 0,0);
[vbl] = Screen('Flip', win, 0,0);
% calllib('inpout32','Out32',portNum,parallel1BitCode);

flip_duration_fixation = 1;
Screen('DrawTexture',win,fixation_image_texture,srcRect,dstRect,0,0);
Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
[vbl] = Screen('Flip', win, vbl + flip_duration_fixation-0.5*ifi,0,0 );
% calllib('inpout32','Out32',portNum,0);


% added  to increase the black time between the fixation and the start of the sequences to prevent missing the start
Screen('FillRect',win,[0 0 0]); % Setting the background to black.
Screen('Flip', win, 0, 1, 0, 0);
% calllib('inpout32','Out32',portNum,0);
%

% centerhorizental = winRect(3) / 2;
% centervertical = winRect(4) / 2;
% horizental = winRect(3);
% vertical = winRect(4);

% centerhstart = floor(centerhorizental - totallength / 2);
% centervstart = floor(centervertical - totallength / 2);
% centerhend = floor(centerhorizental + totallength / 2);
% centervend = floor(centervertical + totallength / 2);

% rightsidestart = horizental - totallength;
% bottomstart = vertical - totallength;

% dstRect_nontarget = [centerhorizental-10,vertical-50,centerhorizental+10,vertical-30];

%     while (~KbCheck)
% for iter = 1:15
mseqcounter = 0;
ii = 1;
indicator_flag=0;

% for ii=1:round(DurationOfEachTrial/ifi)
while (~KbCheck)
    
    %             tic
    if flickertype ==0
        
        if ~mod(ii,p1)
            if pf1
                Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend]);   %  flickering at top left
                pf1 = 0;
                Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                indicator_flag=1;
            else
                Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend]);   %  flickering at top left
                pf1 = 1;
                Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                indicator_flag=0;
            end
        end
    else
        if flickertype ==1
            if ~mod(ii,DP)
                if mpf1(mod(mseqcounter,length(mseq))+1)
                    if(decision_shalini == 1)   % Modified by Shalini
                        Screen('DrawTexture',win,green_box_texture,[0,0,size_box,size_box],[0,0,size_box,size_box]);   %  flickering at top left
                    end
                    Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[offset_box/2,offset_box/2,totallength+offset_box/2,totallength+offset_box/2]);
                    % Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                else
                    if(decision_shalini == 1)
                        Screen('DrawTexture',win,green_box_texture,[0,0,size_box,size_box],[0,0,size_box,size_box]);   %  flickering at top left
                    end
                    Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[offset_box/2,offset_box/2,totallength+offset_box/2,totallength+offset_box/2]);
                    % Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                end
                if mpf2(mod(mseqcounter,length(mseq))+1)
                    if(decision_shalini == 2)
                        Screen('DrawTexture',win,green_box_texture,[0,0,size_box,size_box],[rightsidestart-offset_box, 0,horizental,totallength+offset_box]);   %  flickering at top left
                    end
                    Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[rightsidestart-offset_box/2,offset_box/2,horizental-offset_box/2,totallength+offset_box/2]);   %  flickering at top right
                    % Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                else
                     if(decision_shalini == 2)
                        Screen('DrawTexture',win,green_box_texture,[0,0,size_box,size_box],[rightsidestart-offset_box, 0,horizental,totallength+offset_box]);   %  flickering at top left
                    end
                    Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[rightsidestart-offset_box/2,offset_box/2,horizental-offset_box/2,totallength+offset_box/2]);   %  flickering at top right
                    here = 2;
                    % Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                end
                if mpf3(mod(mseqcounter,length(mseq))+1)
                    if(decision_shalini == 3)
                        Screen('DrawTexture',win,green_box_texture,[0,0,size_box,size_box],[0,bottomstart-offset_box,totallength+offset_box,vertical]);   %  flickering at top left
                    end
                    Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[0+offset_box/2, bottomstart-offset_box/2,totallength+offset_box/2,vertical-offset_box/2]);   %  flickering at bottom left
                    % Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                else
                    if(decision_shalini == 3)
                        Screen('DrawTexture',win,green_box_texture,[0,0,size_box,size_box],[0,bottomstart-offset_box,totallength+offset_box,vertical]);   %  flickering at top left
                    end
                    Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[0+offset_box/2, bottomstart-offset_box/2,totallength+offset_box/2,vertical-offset_box/2]);   %  flickering at bottom left
                    % Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                end
                if mpf4(mod(mseqcounter,length(mseq))+1)
                    if(decision_shalini == 4)
                        Screen('DrawTexture',win,green_box_texture,[0,0,size_box,size_box],[rightsidestart-offset_box,bottomstart-offset_box,horizental,vertical]);   %  flickering at top left
                    end
                    Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[rightsidestart-offset_box/2, bottomstart-offset_box/2,horizental-offset_box/2,vertical-offset_box/2]);   %  flickering at bottom right
                    % Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                else
                    if(decision_shalini == 4)
                        Screen('DrawTexture',win,green_box_texture,[0,0,size_box,size_box],[rightsidestart-offset_box,bottomstart-offset_box,horizental,vertical]);   %  flickering at top left
                    end
                    Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[rightsidestart-offset_box/2, bottomstart-offset_box/2,horizental-offset_box/2,vertical-offset_box/2]);   %  flickering at bottom right
                    % Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                end
                
                if ~mseqcounter
                    Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                    indicator_flag=1;
                else
                    Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                    indicator_flag=0;
                end
                
                if (mseqcounter < 30)
                    mseqcounter = mseqcounter + 1;
                else
                    mseqcounter = 0;
                end
            end
        else
            if flickertype ==2
                if ~mod(ii,DP)
                    if mseq(mod(mseqcounter,length(mseq))+1)
                        Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend]);   %  flickering at top left
                        Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                        indicator_flag=1;
                    else
                        Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend]);   %  flickering at top left
                        Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                        indicator_flag=0;
                    end
                    mseqcounter = mseqcounter + 1;
                end
                
                
                %                 if ~mod(ii,p1)
                %                     if mseq(mod(mseqcounter,length(mseq))+1)
                %                         if ~(pstat)
                %                             Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend]);   %  flickering at top left
                %                             Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                %                             pstat = 1;
                %                         else
                %                             Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend]);   %  flickering at top left
                %                             Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                %                             pstat = 0;
                %                         end
                %                     end
                %                     mseqcounter = mseqcounter + 1;
                %                 end
                
            end
        end
    end
    
    if ii < DP
        ii = ii + 1;
    else
        ii = 1;
    end
    
    
    if(indicator_flag)
            Screen('Flip', win, 0, 1, 0, 0);

%         calllib('inpout32','Out32',portNum,parallel1BitCode);
    else
            Screen('Flip', win, 0, 1, 0, 0);

%         calllib('inpout32','Out32',portNum,0);
    end
    %             toc
end
Screen('FillRect',win,[0 0 0]); % Setting the background to black.
Screen('Flip', win, 0, 1, 0, 0);
% calllib('inpout32','Out32',portNum,0);
