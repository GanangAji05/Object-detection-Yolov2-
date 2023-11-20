
c = webcam('Fantech Luminous C30' );
% c = webcam('EƖgato Virtual Camera');
load 'detectorYOLOv2VaporLiquid.mat';

while true
    e = snapshot(c);
    [bboxes, scores,label] = detect(detectorYolov2,e);
    scores1 = scores;
    
    if (~isempty(bboxes))
    e = insertObjectAnnotation(e,'rectangle',bboxes,scores,'Color','green');
    Tmax1 = max(scores1); % Define threshold here
    idx1 = scores1 >= Tmax1;
    bbox10 = bboxes(idx1,:); % This logic doesn't change    Xc1 = bboxes(:,1);%kiri
    Xc1 = bboxes(:,1);%bawah
    Yc1 = bboxes(:,2);%bawah
    a1 = bboxes(:,3);%kiri
    b1 = bboxes(:,4);%bawah
    cenx1 = ((Xc1+(a1/2))); %511 %-----Centroids and Xt Yt
    ceny1 = ((Yc1+(b1/2))); %391
    Xt1 = cenx1(:,1);
    Yt1 = ceny1(:,1);
    end
    C_X = round(bboxes(:,1)+(bboxes(:,3)/2));
    C_Y = round(bboxes(:,2)+(bboxes(:,4)/2));
%     centers = [];
    centers = [centers;C_X C_Y];
    subplot(1,2,1),plot(centers(1:2:end,1),centers(1:2:end,2));
    hold on
    subplot(1,2,2), imshow(e);
    drawnow;
end


