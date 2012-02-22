Screen('FillRect',win,[0 0 0]); % Setting the background to black.
Screen('Flip', win, 0, 1, 0, 0);
calllib('inpout32','Out32',portNum,0);