
%%Parallel Port Initialization
portNum=hex2dec('2FD8');
%portNum=hex2dec(PortAddress);
% loadlibrary('inpout32','inpout32.h'); calllib('inpout32','Out32',portNum,0)
parallel1BitCode=1;
%Parallel Port Initialization ends

%% function checkerboard(sidelength,frequency)
% texture based

exit_flag=0;
sidelength = 60;
totallength = 475;

% DurationOfEachTrial = 30;
% Frequency = 1;
Frequency1 = 20;
Frequency2 = 20;
Frequency3 = 20;
Frequency4 = 20;
frecord = 0;
freqnow = 0;

NumberofTrials=10;
randomfreq = randperm(NumberofTrials);
randcounter = 0;


pf1 = 1;

% mpf1 = [1,1,1,0,1,0,1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0;];
% mpf2 = [1,0,1,0,1,1,0,0,0,0,1,1,1,0,0,1,1,0,1,1,1,1,1,0,1,0,0,0,1,0,0;];
% mpf3 = [1,1,1,0,0,0,1,0,1,0,1,1,0,1,0,0,0,0,1,1,0,0,1,0,0,1,1,1,1,1,0;];
% mpf4 = [1,0,0,1,1,0,0,0,0,1,0,1,1,0,1,0,1,0,0,0,1,1,1,0,1,1,1,1,1,0,0;];

%%%Shifted M-sequences used on 3/30/2011
mpf1 = [1,1,1,0,1,0,1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0;];
mpf2 = [0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1;];
mpf3 = [0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1,0,0,0,0,1,0,0,1;];
mpf4 = [1,1,0,0,0,1,1,0,1,1,1,0,1,0,1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1;];
%%%

%%%Interchange m-seq
% mpf3 = [1,1,1,0,1,0,1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0;];
% mpf4 = [0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1;];
% mpf1 = [0,1,1,0,0,1,1,1,1,1,0,0,0,1,1,0,1,1,1,0,1,0,1,0,0,0,0,1,0,0,1;];
% mpf2 = [1,1,0,0,0,1,1,0,1,1,1,0,1,0,1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1;];
%%%


mpf5 = [1,0,1,1,1,0,0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,0,0,1,1,1,1,0,0,1,0,0,1,0,1,0,1,0,0,1,1,0,1,0,0,0,0,1,0,0,0,1,0,1,1,0,1,1,1,1,1,1,0;];
mpf6 = [1,0,1,0,1,0,0,1,1,1,1,1,1,0,1,0,0,0,0,0,1,1,1,0,0,0,0,1,0,0,1,0,0,0,1,1,0,1,1,0,0,1,0,1,1,0,1,0,1,1,1,0,1,1,1,1,0,0,1,1,0,0,0;];
mpf7 = [1,1,1,0,1,1,0,0,1,1,0,1,0,1,0,1,1,1,1,1,1,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,1,0,1,0,0,1,1,1,1,0,1,0,0,0,1,1,1,0,0,1,0,0,1,0,1,1,0;];
mpf8 = [1,0,0,1,1,1,1,0,0,0,0,0,1,1,0,1,1,1,0,0,1,1,0,0,0,1,1,1,0,1,0,1,1,1,1,1,1,0,1,1,0,1,0,0,0,1,0,0,0,0,1,0,1,1,0,0,1,0,1,0,1,0,0;];


mrecord = 0;
seq = 0;

%myScreen = max(Screen('Screens')-1);
myScreen=0;

%     for(screen_index=1:myScreen)
%         old_res(screen_index)=Screen('Resolution',screen_index);
%         Screen('Resolution',screen_index,800,600);
%     end
% myScreen = 1;

[win,winRect] = Screen(myScreen,'OpenWindow');

[fwidth, fheight] = RectSize(winRect);
width = totallength;
height = totallength;

numCheckers =  ceil([width; height] ./ sidelength);

Screen('FillRect',win,[0 0 0]); % Setting the background to black.

% make an atomic checkerboard
miniboard = eye(2,'uint8') .* 255;

% repeat it in half of x,y, since it's 2x2
checkerboard_heads = repmat(miniboard, ceil(0.5 .* numCheckers))';

% invert for the other cycle
checkerboard_tails = 255 - checkerboard_heads;

% scale the images up
checkerboard_heads = imresize(checkerboard_heads,sidelength,'box');
checkerboard_tails = imresize(checkerboard_tails,sidelength,'box');

% make textures clipped to screen size

texture(1) = Screen('MakeTexture', win, checkerboard_heads(1:height,1:width));
texture(2) = Screen('MakeTexture', win, checkerboard_tails(1:height,1:width));

%     [w,screenRect] = Screen('OpenWindow',screenNumber,black);
%stimulus_onset_indicator(1) = Screen('MakeTexture',win,255*ones(25,130,'uint8')); % square
stimulus_onset_indicator(1) = Screen('MakeTexture',win,zeros(25,130,'uint8')); % square (blacked out)
stimulus_onset_indicator(2) = Screen('MakeTexture',win,zeros(25,130,'uint8')); % black square
screenRect = winRect;
y = imread('im_fixation_500_500.bmp');
fixation_image_texture = Screen('MakeTexture',win,y);

TopLeftArrow = imread('TopLeftArrow.bmp');
TopLeftArrow_texture = Screen('MakeTexture',win,TopLeftArrow);

TopRightArrow = imread('TopRightArrow.bmp');
TopRightArrow_texture = Screen('MakeTexture',win,TopRightArrow);

BottomRightArrow = imread('BottomRightArrow.bmp');
BottomRightArrow_texture = Screen('MakeTexture',win,BottomRightArrow);

BottomLeftArrow = imread('BottomLeftArrow.bmp');
BottomLeftArrow_texture = Screen('MakeTexture',win,BottomLeftArrow);

winSize = size(y,1);    bgn1 = round(screenRect(3)*0.1);
end2 = round(screenRect(4)*0.9);
srcRect = [0 0 winSize-1 winSize-1];
dstRect = CenterRect([0 0 winSize-1 winSize-1],screenRect);
dstRect_nontarget = [bgn1 end2-24 bgn1+20 end2];

% don't need those anymore
clear checkerboard_*;


% Define refresh rate.
ifi = Screen('GetFlipInterval', win);

% p1 = floor(1/(ifi*Frequency));
p1 = round(1/(ifi*Frequency*2));
DF=1/(ifi*round(1/(ifi*Frequency)));    % Default Frequency
DP = round(1/(ifi*Frequency));          % Default Period for M-sequences
F1=1/(ifi*round(1/(ifi*Frequency1)));
F2=1/(ifi*round(1/(ifi*Frequency2)));
F3=1/(ifi*round(1/(ifi*Frequency3)));
F4=1/(ifi*round(1/(ifi*Frequency4)));

flip_duration_fixation= 1;%round(frameRate*(fixation_duration/2000))*ifi;

Screen('FillRect',win,[0 0 0]); % Setting the background to black.
Screen('Flip', win,0);


calllib('inpout32','Out32',portNum,0);
