function [ym labels data]=read_binary_data(str)
%This function reads binary data recorded from gtec amplifier using Labview
%str is the address of the file to be read
%Umut Orhan

if(nargin==0)    
    str='20110524_1910__ExperimentDescription.dat';
end
aa = dir('.\data');
for i=1:size(aa,1)
if strcmp(aa(i).name,str)
    fid=fopen(['.\data\' aa(i).name],'r');
    sizeoffile=aa(i).bytes;
end
end
frame_count=fread(fid,1,'uint32','b');
channel_count=fread(fid,1,'uint32','b');
N=sizeoffile/(4*(frame_count*channel_count+2));

data=zeros(frame_count*N,channel_count);
for(n=1:N)
%for(ii=1:frame_count)
        data((n-1)*frame_count+1:n*frame_count,:)=fread(fid,[channel_count,frame_count],'single','b')';
        %y((n-1)*frame_count+ii,:)=fread(fid,channel_count,'single','b');
%end
fread(fid,1,'uint32','b');
fread(fid,1,'uint32','b');
end

fclose(fid);

diffPulse=[0 ;diff(data(:,end))];   % get derivative of the data
% IndNegOne = find(diffPulse==-1);    % get Indices of -1
IndPosOne = find(diffPulse==1);     % get Indices of 1

Ind=1:size(IndPosOne,1);            % get the indices of the starting point
Ind=reshape(Ind,14,numel(Ind)/14);
Ind=Ind(2:14,:);
istart=Ind(:);
StartPoints=IndPosOne(istart);

dataLength=266; % dataLength is 266, determined by hardware
ChSel=2;        % selected channel

%% data pre-processing
for j=1:size(StartPoints,1)
    y((j-1)*dataLength+1:j*dataLength,1)=data(StartPoints(j):StartPoints(j)+dataLength-1,ChSel);
end
ym=reshape(y,dataLength,numel(y)/dataLength);

load '.\data\20110524_1910_parameters.mat';
labels=parameters.seq(2:21);
labels=labels+1;            % convert labels 0 1 2 3 to labels 1 2 3 4
labels=repmat(labels,13,1);
labels=labels(:).';
end