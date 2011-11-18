function [lb all_DF]=Hlabeling(data,template,numLabel)
% inputs:
% data: 266 x 1 input
% template: PieceSize x 4
% Outputs:
% DF: Final decistion label
% all_DF: all labels

% pieceSize = size(template,1);
pieceSize = size(data,1);
numPiece=floor(size(data,1)/pieceSize);

all_DF=ones(numLabel,numPiece);

for i=1:numPiece
    for j=1:numLabel
        u=data(1+(i-1)*pieceSize:i*pieceSize,1);
        v=template(:,j);
        all_DF(j,i) = HankelAngle(u.',v.');
    end
end
[Y,I]=max(all_DF);

for i=1:numLabel
    ind(i,1)=sum(find(I==i));
end
[Y,lb]=max(ind);

end