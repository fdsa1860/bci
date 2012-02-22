clear
keyPressMode = 0;
NumberofTrials = 20;
Frequency = 30;
flickertype = 1;
DurationOfEachTrial = 13;

PortAddress = '2FD8';
trial_duration=100;
target_duration=1000;
fixation_duration=1000;
trials_per_seq=10;
sequences_per_epoch=1;
distractors_per_seq=0;
target_probability=0.8;
target_ordering_mode=2;

image_duty_cycle=0.2;
epoch_number=3;
amplifierCount=2;

estimated_duration=target_duration/2+sequences_per_epoch*(target_duration/2+fixation_duration+trials_per_seq*trial_duration);

RSVP_Initialization2
RSVP_epoch_beginning
RSVP_one_sequence1
pause(1);
%keypress_wait

clear Screen

