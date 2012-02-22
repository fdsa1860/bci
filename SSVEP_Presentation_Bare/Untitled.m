% cd(folder_path);
% cd('RSVP_paradigm');
% portNum=hex2dec(PortAddress);
% loadlibrary('inpout32','inpout32.h'); 
% calllib('inpout32','Out32',portNum,0)

RSVP_Initialization2
RSVP_epoch_beginning
for(ii=1:20)
RSVP_one_sequence2
end
RSVP_Close