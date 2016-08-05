function boundariesOverOriginal(X, BW)
%   PAINT BOUNDARIES OF SEGMENTATION(or GT) OVER IMAGE
%
% 
if ~isempty(X)
    imagesc(X);
end
switch length(unique(BW))
    case 1 
        % No objects in binary image.
        return;
    case 2
        % One or many objects not overlapped.
        boundies = bwboundaries(BW>0);
        numObjects = length(boundies);
        hold on;
        for idx=1:numObjects
            x=boundies{idx}(:,2);
            y=boundies{idx}(:,1);
            
            plot(x,y);
        end
        hold off;
        
    otherwise
        % Must be an overlapping image
        if size(BW,3)>1
            hold on;
            for idx=1:size(BW,3)
                boundies = bwboundaries(BW(:,:,idx)>0);
                x=boundies{1}(:,2);
                y=boundies{1}(:,1);
                
                plot(x,y);
            end
            hold off;
        else
            bw = changeOverlapRepresentation(BW);
            hold on;
            for idx=1:size(bw,3)
                boundies = bwboundaries(bw(:,:,idx)>0);
                x=boundies{1}(:,2);
                y=boundies{1}(:,1);
                
                plot(x,y);
            end
            hold off;
        end
            
end

        
            