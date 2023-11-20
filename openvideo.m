videoFile = 'video2.mp4';
reader = VideoReader(videoFile);
videoPlayer = vision.VideoPlayer();


while hasFrame(reader)
    frame = readFrame(reader);
    % Run the detector
    [bboxes, scores,label] = detect(detectorYolov2,frame);
    scores1 = scores;
    
    if (~isempty(bboxes))
        frame = insertObjectAnnotation(frame,'rectangle',bboxes,label,'Color','green');
        Tmax1 = max(scores1); % Define threshold here
        pause(0.1);
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
        step(videoPlayer,frame);
end

release(videoPlayer);