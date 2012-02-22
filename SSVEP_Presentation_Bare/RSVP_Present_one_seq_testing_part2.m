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

        calllib('inpout32','Out32',portNum,parallel1BitCode);
    else
            Screen('Flip', win, 0, 1, 0, 0);

        calllib('inpout32','Out32',portNum,0);
    end
    %             toc
end