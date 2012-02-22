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

Screen('DrawTexture',win,fixation_image_texture,srcRect,dstRect,0,0);
Screen('DrawTexture',win,stimulus_onset_indicator(1),[0 0 20 20],dstRect_nontarget,0,0);
% [vbl StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip', win, 0,0);
[vbl] = Screen('Flip', win, 0,0);
calllib('inpout32','Out32',portNum,parallel1BitCode);

flip_duration_fixation = 1;
Screen('DrawTexture',win,fixation_image_texture,srcRect,dstRect,0,0);
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


