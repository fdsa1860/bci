function [data] = read_gTec_dat(fname,samplesPerBlock,numChnl)

% 08/06/11 - Allow data file to contain fractional blocks.
%          - Changed variables *Trigger to *Block.
%          - Changed 16 to numChnl-1.
% 10/25/11 - Allow user to designate fname only (samplesPerBlock and numChnl are automatically determined from fname)
%          - changed "10" to "ndx(10)" in the main loop
% 11/02/11 - changed the mean removal line of code in the main loop to ignore the last channel (numChnl)

if strcmpi(fname(end-3:end),'.dat') == 0
   fname = [fname '.dat'];
end

if nargin < 2
   f1 = findstr(fname,'_samplesPerBlock_');
   f2 = findstr(fname,'_numChnl_');
   samplesPerBlock = str2double(fname(f1+17:f2-1));
end

if nargin < 3
   f2 = findstr(fname,'_numChnl_');
   f3 = findstr(fname,'.dat');
   numChnl = str2double(fname(f2+9:f3-1));
end

% read file
try % using new method for writing data
   fid = fopen(fname,'r');
   data = fread(fid,'double');
   numBlocks = round(length(data)/(samplesPerBlock*numChnl));
   data = reshape(data,numChnl,numBlocks*samplesPerBlock);
   fclose(fid);
   return
catch p
   % if error above, default to using old method for writing data
   try
      fclose(fid); % close file (if it was successfully opened)
   catch
   end
end

fid = fopen(fname,'r');
y = fread(fid);
fclose(fid);

% initialize
numBlocks = fix(length(y)/(3*numChnl*(samplesPerBlock+2)));
y(3*numChnl*(samplesPerBlock+2)*numBlocks+1:end) = [];
y = reshape(y,3*numChnl,numBlocks*(samplesPerBlock + 2));

% inverse uint24
data = y(1:3:end,:)*2^16 + y(2:3:end,:)*2^8 + y(3:3:end,:);
data = data/(2^24-1);

% get meanV, remove meanV from data
ndx = 1 : samplesPerBlock+2 : size(data,2);
meanV = data(:,ndx);
meanV(1:numChnl-1,:) = meanV(1:numChnl-1,:)/2 - 0.250;
data(:,ndx) = [];

% get gainV, remove gainV from data
ndx = 1 : samplesPerBlock+1 : size(data,2);
gainV = data(:,ndx);
gainV(1:numChnl-1,:) = gainV(1:numChnl-1,:)/2;
data(:,ndx) = [];

% re-normalize trigger channel
data(numChnl,:) = data(numChnl,:)*255;

% loop
ndx = 1:samplesPerBlock;
for i = 1:numBlocks
   data(:,ndx) = data(:,ndx).*repmat(gainV(:,i),1,samplesPerBlock);
   data(1:16,ndx) = data(1:16,ndx) - repmat(mean(data(1:16,ndx(10):ndx(end)),2) - meanV(1:16,i),1,samplesPerBlock);
   ndx = ndx + samplesPerBlock;
end

% clean-up trigger channel
data(numChnl,:) = round(data(numChnl,:));

end
