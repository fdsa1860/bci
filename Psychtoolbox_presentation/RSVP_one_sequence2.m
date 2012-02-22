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

switch randseletor
    case (0)
        Screen('DrawTexture',win,TopLeftArrow_texture,[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend],0,0);
        Screen('DrawTexture',win,fixation_image_texture,srcRect,[0,0,totallength,totallength],0,0);
    case (1)
        Screen('DrawTexture',win,TopRightArrow_texture,[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend],0,0);
        Screen('DrawTexture',win,fixation_image_texture,srcRect,[rightsidestart, 0,horizental,totallength],0,0);
    case (2)
        Screen('DrawTexture',win,BottomLeftArrow_texture,[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend],0,0);
        Screen('DrawTexture',win,fixation_image_texture,srcRect,[0, bottomstart,totallength,vertical],0,0);
    case (3)
        Screen('DrawTexture',win,BottomRightArrow_texture,[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend],0,0);
        Screen('DrawTexture',win,fixation_image_texture,srcRect,[rightsidestart, bottomstart,horizental,vertical],0,0);
end






% Screen('DrawTexture',win,fixation_image_texture,srcRect,dstRect,0,0);
Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
% [vbl StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip', win, 0,0);
[vbl] = Screen('Flip', win, 0,0);
calllib('inpout32','Out32',portNum,parallel1BitCode);

flip_duration_fixation = 1;
% Screen('DrawTexture',win,fixation_image_texture,srcRect,dstRect,0,0);
Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
[vbl] = Screen('Flip', win, vbl + flip_duration_fixation-0.5*ifi,0,0 );
calllib('inpout32','Out32',portNum,0);



% added  to increase the black time between the fixation and the start of the sequences to prevent missing the start
Screen('FillRect',win,[0 0 0]); % Setting the background to black.
Screen('Flip', win, 0, 1, 0, 0);
calllib('inpout32','Out32',portNum,0);
%

% centerhorizental = winRect(3) / 2;
% centervertical = winRect(4) / 2;

% centerhstart = floor(centerhorizental - totallength / 2);
% centervstart = floor(centervertical - totallength / 2);
% centerhend = floor(centerhorizental + totallength / 2);
% centervend = floor(centervertical + totallength / 2);

% horizental = winRect(3);
% vertical = winRect(4);

% dstRect_nontarget = [centerhorizental-10,vertical-50,centerhorizental+10,vertical-30];

%     while (~KbCheck)
% for iter = 1:15


mseqcounter = 0;
indicator_flag=0;

for ii=1:round(DurationOfEachTrial/ifi)
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
                    Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[0,0,totallength,totallength]);   %  flickering at top left
                    % Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                else
                    Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[0,0,totallength,totallength]);   %  flickering at top left
                    % Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                end
                if mpf2(mod(mseqcounter,length(mseq))+1)
                    Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[rightsidestart, 0,horizental,totallength]);   %  flickering at top right
                    % Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                else
                    Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[rightsidestart, 0,horizental,totallength]);   %  flickering at top right
                    % Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                end
                if mpf3(mod(mseqcounter,length(mseq))+1)
                    Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[0, bottomstart,totallength,vertical]);   %  flickering at bottom left
                    % Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                else
                    Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[0, bottomstart,totallength,vertical]);   %  flickering at bottom left
                    % Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                end
                if mpf4(mod(mseqcounter,length(mseq))+1)
                    Screen('DrawTexture',win,texture(1),[0,0,totallength,totallength],[rightsidestart, bottomstart,horizental,vertical]);   %  flickering at bottom right
                    % Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                else
                    Screen('DrawTexture',win,texture(2),[0,0,totallength,totallength],[rightsidestart, bottomstart,horizental,vertical]);   %  flickering at bottom right
                    % Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                end
                
                if ~mseqcounter
                    Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
                    indicator_flag=1;
                    
                else
                    Screen('DrawTexture',win,stimulus_onset_indicator(2),[0 0 20 20],dstRect_nontarget,0,0);
                    indicator_flag=0;
                    
                end
                
                switch randseletor
                    case (0)
                        Screen('DrawTexture',win,TopLeftArrow_texture,[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend],0,0);
                    case (1)
                        Screen('DrawTexture',win,TopRightArrow_texture,[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend],0,0);
                    case (2)
                        Screen('DrawTexture',win,BottomLeftArrow_texture,[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend],0,0);
                    case (3)
                        Screen('DrawTexture',win,BottomRightArrow_texture,[0,0,totallength,totallength],[centerhstart, centervstart,centerhend,centervend],0,0);
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
    
    Screen('Flip', win, 0, 1, 0, 0);
    if(indicator_flag)
        calllib('inpout32','Out32',portNum,parallel1BitCode);
    else
        calllib('inpout32','Out32',portNum,0);
    end
    %             toc
end
Screen('FillRect',win,[0 0 0]); % Setting the background to black.
Screen('Flip', win, 0, 1, 0, 0);
calllib('inpout32','Out32',portNum,0);
